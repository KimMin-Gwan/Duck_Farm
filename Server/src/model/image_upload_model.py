from model.sample_model import SampleModelTypeOne
from model.fake_database import Local_Database
from model.data_domain import Bias, Image
from others import CoreControllerLogicError
import boto3
import cv2
import os
import numpy as np

class ImageUploadModel(SampleModelTypeOne):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__bias = Bias()
        self.__image = Image()
        self.__images = []
        
        self.__service_name = '_______________'
        self.__endpoint_url = '_______________'
        self.__access_key = '_______________'
        self.__secret_key = '_______________'
        self.__bucket_name = '________'


    def set_bias_with_bid(self,request) -> bool: 
            try:
                bias_data = self._database.get_data_with_id(target="bid", id=request.bid)

                if not bias_data:
                    return False
            
                self.__bias.make_with_dict(bias_data)

                return True
            except Exception as e:
                raise CoreControllerLogicError(error_type="set_bias_with_bid error | " + str(e))

    def get_image_info(self,request):
        self.__images = request.images
        self.__image.image_type = request.image_type
        self.__image.image_detail = request.image_detail
        self.__image.upload_date = request.upload_date
        self.__image.sid = request.sid
        self.__image.bid = request.bid
    
    def upload_image(self):
        try:
            s3 = boto3.client(self.__service_name, endpoint_url=self.__endpoint_url, aws_access_key_id=self.__access_key,
                            aws_secret_access_key=self.__secret_key)
            
            temp_num=1
            #이미지들
            for img in self.__images:
                #iid 부여
                temp_iid =str(int(self.__bias.iids[-1].split('-')[-1])+temp_num)

                #DB에 이미지 정보 저장
                self.__image.iid = f'{self.__bias.bid}_{temp_iid}'
                self._database.add_new_data(target_id='iid',new_data=self.__image.get_dict_form_data())

                #리사이즈
                original_image = np.array(img).astype(np.uint8)
                resized_img_T = cv2.resize(original_image, dsize=(0,0), fx=0.3, fy=0.3, interpolation=cv2.INTER_LINEAR)
                resized_img_L = cv2.resize(original_image, dsize=(0,0), fx=0.7, fy=0.7, interpolation=cv2.INTER_LINEAR)

                #이미지 임시 저장
                cv2.imwrite('./temp_image/original.jpg', original_image)
                cv2.imwrite('./temp_image/Thumbnail.jpg', resized_img_T)
                cv2.imwrite('./temp_image/Low.jpg', resized_img_L)
                        
                #업로드
                s3.upload_file('./temp_image/original.jpg', self.__bucket_name, f'O{self.__bias.bid}_{temp_iid}.jpg',ExtraArgs={'ACL':'public-read'})
                s3.upload_file('./temp_image/Thumbnail.jpg', self.__bucket_name, f'T{self.__bias.bid}_{temp_iid}.jpg',ExtraArgs={'ACL':'public-read'})
                s3.upload_file('./temp_image/Low.jpg', self.__bucket_name, f'L{self.__bias.bid}_{temp_iid}.jpg',ExtraArgs={'ACL':'public-read'})

                #임시 저장 이미지 삭제
                os.remove('./temp_image/original.jpg')
                os.remove('./temp_image/Thumbnail.jpg')
                os.remove('./temp_image/Low.jpg')
                temp_num+=1

            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="upload error | " + str(e))
    

    def get_response_form_data(self, head_parser):
        try:
            body = {
                'state' : 'success'
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError("response making error | " + e)
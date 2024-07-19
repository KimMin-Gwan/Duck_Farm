from model.sample_model import SampleModelTypeThree
from model.fake_database import Local_Database
from others import CoreControllerLogicError
from model.data_domain import *

class ImagSearchModel(SampleModelTypeThree):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__images = []
        #self.__schedule = Schedule()
        self.__first_list = []
        self.__second_list = []
        self.__third_list = []
        self.__num_image : int = 0


    # 이미지 검색
    def try_searching_images(self,request) -> bool: 
        try:
            tmp_iid = set()
            
            # 검색된 글자와 부분적으로 일치하는 것 포함 모두 찾음?
            iid_list = self._database.search_image_with_data(request.key_word)
            tmp_iid.update(iid_list)
            images_data =  self._database.get_datas_with_ids(target_id="iid", ids=tmp_iid)

            for image_data in images_data :
                image = Image()
                image.make_with_dict(image_data)
                self.__images.append(image)
            
            # 이미지가 있으면 True반환
            return len(self.__images) > 0

        except Exception as e:
            raise CoreControllerLogicError(error_type="try_searching_images_error | " + str(e))
    
    # 이미지 정렬
    def set_list_alignment(self,request) -> bool:
        try:
            self.__images = super()._set_list_alignment(self.__images, request.ordering)
            return True

        except Exception as e:
            raise CoreControllerLogicError(error_type="_set_list_alignment error | " + str(e))

    # 3줄 분배
    def make_image_list(self,request) -> None:
        try:
            num_image = len(self.__images)
            if (num_image - request.num_image) <= 0 : # 이미지 리스트 비어 있음
                return
            else :
                self.__images = self.__images[request.num_image:] # 앞의 이미지 버리기

            count=0
            for i in range(len(self.__images)): # 이미지 3개의 리스트로 분배
                if count >= 20 : # 최대 20개 까지만 허용
                    break
                if i % 3 == 0:
                    self.__third_list.append(self.__images[i].iid)
                elif i % 3 == 1:
                    self.__second_list.append(self.__images[i].iid)
                else:
                    self.__first_list.append(self.__images[i].iid)

                count += 1
                
            self.__num_image = request.num_image + count
            return    
        
        except Exception as e:
            raise CoreControllerLogicError(error_type="make_image_list error | " + str(e))

    # 응답 생성
    def get_response_form_data(self, head_parser):
        try:
            body = {
                'num_image' : self.__num_image,
                'first_list' : self.__first_list,
                'second_list' : self.__second_list,
                'third_list' : self.__third_list
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError("response making error | " + str(e))

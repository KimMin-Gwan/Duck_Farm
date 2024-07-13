from model.sample_model import SampleModelTypeOne
from model.fake_database import Local_Database
from model.data_domain import Bias, Schedule, Image
from datetime import datetime
from others import CoreControllerLogicError

class ImageListByBiasModel(SampleModelTypeOne):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__bias = Bias()
        self.__images = []
        self.__first_list = []
        self.__second_list = []
        self.__third_list = []

    def set_bias_with_bid(self,request) -> bool: 
        try:
            bias_data = self._database.get_data_with_id(target="bid", id=request.bid)

            if not bias_data:
                return False
        
            self.__bias.make_with_dict(bias_data)

            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_bias_with_bid error | " + str(e))
    
    def set_images_with_bid(self) -> bool:
        try:
            if not self.__bias:
                return False
            
            self.__images = self.__bias.iids
            
            return True
        
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_bias_with_bid error | " + str(e))

    def make_image_list(self) -> bool:
        try:
            if not self.__images:
                return False
            for i in range(len(self.__images)):
                if i % 3 == 0:
                    self.__first_list.append(self.__images[i])
                elif i % 3 == 1:
                    self.__second_list.append(self.__images[i])
                else:
                    self.__third_list.append(self.__images[i])
                

            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="make_image_list error | " + str(e))

    def get_response_form_data(self, head_parser):
        try:
            body = {
                'bid': self.__bias.bid,
                'bname': self.__bias.bname,
                'num_image' :len(self.__images),
                'first_list' : self.__first_list,
                'second_list' : self.__second_list,
                'third_list' : self.__third_list
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError("response making error | " + e)
        



class ImageListByBiasNScheduleModel(SampleModelTypeOne):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__bias = Bias()
        self.__images = []
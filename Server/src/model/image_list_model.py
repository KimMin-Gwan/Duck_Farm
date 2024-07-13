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

    def set_bias_with_bid(self,request) -> bool: 
        try:
            bias_data = self._database.get_datas_with_ids(target_id="bid", ids=request.bid)

            if not bias_data:
                return False
            
            self.__images = bias_data.iids

            self.__bias.make_with_dict(bias_data)
            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_bias_with_bid error | " + str(e))
    
    # def set_images_with_bid(self) -> bool:
    #     try:
    #         if not self.__bias:
    #             return False
            
    #         images = self.__bias.iids
            
    #         for bias_data in self.__biases:
    #             bias = Bias()
    #             bias.make_with_dict(bias_data)
    #             self.__biases.append(bias)
    #         return True
        
    #     except Exception as e:
    #         raise CoreControllerLogicError(error_type="set_bias_with_bid error | " + str(e))

    def get_response_form_data(self):
        try:
            body = {}
            body.update(self.__image.get_dict_form_data())
            body.update(self.__bias.get_dict_form_data())
            body['schedule'] = self.__schedule.get_dict_form_data()

            response = self._get_response_data(body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError("response making error | " + e)
        



class ImageListByBiasNScheduleModel(SampleModelTypeOne):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__bias = Bias()
        self.__images = []
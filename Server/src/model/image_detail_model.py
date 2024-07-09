from model.sample_model import SampleModelTypeOne
from model.fake_database import Local_Database
from model.data_domain import Bias, Schedule, Image
from datetime import datetime
from others import CoreControllerLogicError

class ImageDetailModel(SampleModelTypeOne):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__bias = Bias()
        self.__image = Image()
        self.__schedule = Schedule()
        self.__owner = False


    def get_response_form_data(self):
        try:
            body = {
                "user_owner" : self.__owner
            }
            body.update(self.__image.get_dict_form_data())
            body.update(self.__bias.get_dict_form_data())
            body['schedule'] = self.__schedule.get_dict_form_data()

            response = self._get_response_data(body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError("response making error | " + e)







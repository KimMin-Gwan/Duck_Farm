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
        self.__like = False

    def set_image_with_iid(self,request) -> bool:
        try:
            image_data = self._database.get_data_with_id(target="iid", id=request.iid)
            if not image_data:
                return False
            self.__image.make_with_dict(image_data)
            return True

        except Exception as e:
            raise CoreControllerLogicError(error_type="set_image_with_iid error | " + str(e))

    def set_bias_with_bid(self) -> bool: 
        try:
            bias_data = self._database.get_data_with_id(target="bid", id=self.__image.bid)

            if not bias_data:
                return False
            self.__bias.make_with_dict(bias_data)
            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_bias_with_bid error | " + str(e))

    def set_schedule_with_sid(self) -> bool:  
        try:
            sid = self.__image.sid
            schedule_data = self._database.get_data_with_id(target="sid", id=sid)

            if not schedule_data:
                return False

            self.__schedule.make_with_dict(schedule_data)

            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_schedules_with_sid error | " + str(e))
    
    def is_image_owner(self) -> None:
            if self._user.uid == self.__image.uid:
                self.__owner = True
            return
    
    def is_image_like(self) -> None:
        try:
            if self.__image.iid in self._user.like_iids:
                self.__like = True

        except Exception as e:
            raise CoreControllerLogicError(error_type="set_schedules_with_sid error | " + str(e))


    def get_response_form_data(self,head_parser):
        try:
            body = {
                "uname" : self._user.uname,
                "user_owner" : self.__owner,
                "like_state" : self.__like
            }
            body.update(self.__image.get_dict_form_data())
            body.update(self.__bias.get_dict_form_data())
            body['schedule'] = self.__schedule.get_dict_form_data()

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))







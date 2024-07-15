from model.sample_model import SampleModelTypeOne
from model.fake_database import Local_Database
from model.data_domain import Image
from datetime import datetime
from others import CoreControllerLogicError

class ImageLikeModel(SampleModelTypeOne):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__image = Image()

    def set_image_data(self, request) -> bool:  
        try:
            image_data = self._database.get_data_with_id(target="iid", id=request.iid)

            if not image_data:
                return False

            self.__image.make_with_dict(image_data)

            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_schedules_with_sid error | " + str(e))

    def set_image_data(self, request) -> bool:  
        try:
            image_data = self._database.get_data_with_id(target="iid", id=request.iid)

            if not image_data:
                return False

            self.__image.make_with_dict(image_data)

            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_schedules_with_sid error | " + str(e))
        
    def set_image_like(self, request) -> bool:  
        try:
            if request.like:
                self.__image.like += 1
                self._user.like_iids.append(self.__image.iid)
            else:
                self.__image.like -= 1
                self._user.like_iids.remove(self.__image.iid)

            self._database.modify_data_with_id(target_id="uid",
                                                target_data=self._user.get_dict_form_data())

            self._database.modify_data_with_id(target_id="iid",
                                                target_data=self.__image.get_dict_form_data())

            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_schedules_with_sid error | " + str(e))


    def get_response_form_data(self,head_parser):
        try:
            body = {
                "image" : self.__image.get_dict_form_data()
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))
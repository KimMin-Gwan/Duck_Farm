from model.sample_model import SampleModelTypeOne, SampleModelTypeTwo
from model.fake_database import Local_Database
from model.data_domain import Image, Schedule, Bias
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
        

class SearchScheduleModel(SampleModelTypeTwo):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__all_schedules = []
        self.__find_schedules = []

    def set_schedules(self):
        schedule_datas = self._database.get_all_data(target="schedule")

        for schedule_data in schedule_datas:
            schedule = Schedule()
            schedule.make_with_dict(schedule_data)
            self.__all_schedules.append(schedule)
        return True

    def search_schedule_data(self, request):

        self.__find_schedules = self._search_similar_data(data_list=self.__all_schedules,
                                   key_word=request.key_word,
                                   key_attr='sname'
                                  )
        
        if len(self.__find_schedules):
            return False


        return True

    def get_response_form_data(self,head_parser):
        try:
            body = {
                "schedules" : self._make_dict_list_data(list_data=self.__find_schedules)
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))

class SearchBiasModel(SampleModelTypeTwo):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__all_bias= []
        self.__find_bias= []

    def set_biases(self):
        bias_datas = self._database.get_all_data(target="bias")

        for bias_data in bias_datas:
            bias = Bias()
            bias.make_with_dict(bias_data)
            self.__all_bias.append(bias)
        return True

    def search_bias_data(self, request):

        self.__find_bias= self._search_similar_data(data_list=self.__all_bias,
                                   key_word=request.key_word,
                                   key_attr='bname'
                                  )

        if len(self.__find_bias):
            return False

        return True

    def get_response_form_data(self,head_parser):
        try:
            body = {
                "biases" : self._make_dict_list_data(list_data=self.__find_bias)
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))
        






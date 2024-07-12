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

    def set_image_with_iid(self,request) -> bool:
        try:
            image_data = self._database.get_datas_with_ids(target_id="iid", ids=request.iid)
            if not image_data:
                return False
            self._user.make_with_dict(image_data)
            return True

        except Exception as e:
            raise CoreControllerLogicError(error_type="set_image_with_iid error | " + str(e))

    def set_biases_with_bids(self) -> bool: #중복
        try:
            if len(self._user.bids) == 0:
                return False
            bias_datas = self._database.get_datas_with_ids(target_id="bid", ids=self._user.bids)

            for bias_data in bias_datas:
                bias = Bias()
                bias.make_with_dict(bias_data)
                self.__biases.append(bias)
            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_bias_with_bid error | " + str(e))

    def set_schedules_with_sids(self) -> bool: #중복
        try:
            sids = set()
            for bias in self.__biases:
                for sid in bias.sids:
                    sids.add(sid)
            schedule_datas = self._database.get_datas_with_ids(target_id="sid", ids=sids)

            # 스케줄 데이터가 하나도 없다면 그냥 반환
            if not schedule_datas:
                return False

            for schedule_data in schedule_datas:
                schedule = Schedule()
                schedule.make_with_dict(schedule_data)
                self.__schedules.append(schedule)


            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_schedules_with_sid error | " + str(e))
    
    def is_image_owner(self) -> None:
            if self._user.uid == self.__image.uid:
                self.__owner = True
            return

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







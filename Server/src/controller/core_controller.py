from model import User_Model
from model import Image_Model
from model import Bias_Model

class Core_Controller:
    def __init__(self) -> None:
        pass

    def get_none_bias_home_data(self,request, database):

        bias_models=[]
        target_schedules=[]
        image_models=[]
        image_by_date = []
        image_list = []

        user_model = User_Model()
        result = {}
        if not user_model.is_vaild_user(request['uid']) :   #유저 확인
            result = {
                "state_code" : "501",
                "detail" : "permision denied",
            }
            return result

        '''
        for bid in request['bid'] :
            bias_model = Bias_Model(datebase)
            bias_model.make_schedule_list(bid)
            bias_models.append(bias_model)
        for schedule in bias_models[0].get_schedules():
            if (schedule.get_schedule_date() == request['date']):
                target_schedule.append(schedule_date)
        if target_schedules : 
            for schedule in target_schedules:
            image_model = Image_Model(database)
            image_model.make_image_data_with_schedule(schedule.get_sid())
            image_models.append(image_model)
        image_by_date = []
        for bias_model in bias_models:
            image_by_date.append(bias_model.get_image_by_date())
        image_list = []
        for image_model in image_models:
            image_list.append(image_model.get_home_body_image_list())
        latest_image = {
            “bid” : bias_models[0].get_bid(),
            “image_list” : image_list
        }
        result = {
            “state-code” : 201“
            “detail” : “none-bias-home-date-returned”
            “image_by_date” : image_by_date,
            “latest_image” : latest_image
        }
        return result
        '''

        for bid in request['bid'] :
            bias_model = Bias_Model(database)
            bias_model.make_schedule_list(bid)
            bias_models.append(bias_model)

        for schedule in bias_models[0].get_schedules():
            if (schedule.get_date() == request['date']):
                target_schedules.append(schedule)

        if target_schedules :
            for schedule in target_schedules:
                image_model = Image_Model(database)
                image_model.make_image_data_with_schedule(schedule.get_sid())
                image_models.append(image_model)

        for bias_model in bias_models:
            image_by_date.append(bias_model.get_image_by_date())  #bias_model에 get_image_by_date 작성 필요

        for image_model in image_models:
            image_list.append(image_model.get_home_body_image_list())  #image_model에 get_home_body_image_list 작성 필요

        latest_image = {
            'bid' : bias_models[0].get_bid(),
            'image_list' : image_list
        }

        result = {
            'state_code': '201',
            "“image_by_date”" : image_by_date,
            "detail" : 'none-bias-home-date-returned',
            '“latest_image”':latest_image
        }

        return result
    
    def get_bias_home_data(self, request, database):
        return
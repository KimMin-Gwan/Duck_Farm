from user_model import User_Model
from image_model import Image_Model

class Core_Controller:
    def __init__(self) -> None:
        pass

    def get_home_data(self,request):
        user_Model = User_Model()
        result = {}
        if not user_Model.is_vaild_user() :
            return result


        image_Model = Image_Model()

        image_list = image_Model.get_bias_image_data(request['bid'])

        result = {
            'state_code': ''
            "date" : "00/00/00",
            "bid" : request['bid']
            'total_image_list':image_list
        }

        return result
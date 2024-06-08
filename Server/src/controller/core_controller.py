from model import User_Model
from model import Image_Model
from model import Bias_Model

class Core_Controller:
    def __init__(self) -> None:
        pass

        # 1.  유저 속성 확인
        # 3.  달이 0이면 모르겠고 오늘꺼 이슈


    def get_home_data(self,request):
        user_model = User_Model()
        result = {}
        if not user_model.is_vaild_user(request['uid']) :   #유저 확인
            result = {
                "state_code" : "501",
                "detail" : "permision denied",
            }
            return result

        image_model = Image_Model()

        #non-bid user=User(request)  user.get_bid() #bid list 

        if request['bid'] == "0000":
            bias_model = Bias_Model()
            bid = bias_model.get_latest_uploaded_bias(user_model.get_bias())
            image_list = image_model.get_bias_image_data(bid)
        else:
            image_list = image_model.get_bias_image_data(request['bid'])

        result = {
            'state_code': '',
            "date" : "00/00/00",
            "bid" : request['bid'],
            'total_image_list':image_list
        }

        return result
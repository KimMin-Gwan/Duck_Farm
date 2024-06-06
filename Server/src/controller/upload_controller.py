from model import User_Model
from model import Image_Model

class Upload_Controller():
    def __init__(self,database) -> None:
        self.__database = database
        pass
    def upload_new_post(self,request):
        return_data = {
            "state-code" : 223,
            "iid" : [],
            "token" : "",
            "bid" : request['bid'],
        }

        user_model = User_Model(self.__database)
        result:bool = user_model.is_vaild_user(request['uid'])

        if not result:
            return return_data
        
        image_model = Image_Model(self.__database)
        iid = image_model.make_image_data(request)


        #amazno_s3 = Amazno_S3()
        #tokent = amazon_s3.make_upload_token()
        token  = "qwer"
        return_data['state-code'] = 222
        return_data['iid'] = iid
        return_data['token'] = token
        return return_data
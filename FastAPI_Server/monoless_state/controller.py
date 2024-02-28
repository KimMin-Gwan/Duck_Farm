import json
import time
from model import User, Master_Model

class Master_Controller:
    def __init__(self, model):
        self.model:Master_Model = model
        
    def login(self, user_data):
        user_controller = User_Controller(model = self.model)
        result = user_controller.try_login(user_data)
        
        
# User 관련 처리
class User_Controller:
    def __init__(self, model, uid=0):
        self.user_data = User() #  초기화된 상태로 생성
        sign_in_flag = False
        if uid:
            if self.get_user_data(uid):
                print(f"System_Error||{uid}_user_sign_in")
            else:
                print("System_Error||User_Data_could_not_found")
        self.model:Master_Model = model # Model


    # 로그인 시도
    def try_login(self, user_data):
        login_controller = Login_Controller(user_data)
       
    # 유저정보 불러오기

    def get_user_data(self, uid:int) -> bool:
        try:
            if (self.model.find_user_id(uid)):
                self.user_data.set_user_data(self.model)
                return True
            else:
                return False
        except:
            return user_data
    
    # 유저정보 변경
    def modify_user_data(self, user_data):
        pass
    
    # 로그아웃 시도
    def try_sign_out(self):
        pass
    
        
class Login_Controller:
    def __init__(self, user_data=None):
        self.user_data = user_data
        self.try_login(user_data)
    
    def try_login(self):
        self
        pass
        
    
class Error_Controller:
    def __init__(self, Error_type):
        pass
import json
import time

class Master_Controller:
    def __init__(self, model):
        self.model = model
        
    def login(self, user_data):
        user_controller = User_Controller()
        result = user_controller.try_login(user_data)
        
        
class User_Controller:
    def __init__(self, user_data=None):
        self.user_data = user_data
    
    # 로그인 시도
    def try_login(self, user_data):
        login_controller = Login_Controller(user_data)
        
    # 유저정보 불러오기
    def get_user_data(self):
        pass
    
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
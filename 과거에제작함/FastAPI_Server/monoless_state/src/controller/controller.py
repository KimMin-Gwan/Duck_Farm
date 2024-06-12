import json
from model import User, Master_Model
from user_controller import User_Controller
import random
from datetime import datetime # uid 만드는데 활용하려고 했음
from network_provider import Error_Json_Parser

class Master_Controller:
    def __init__(self, model):
        self.model:Master_Model = model
    
    # 유저와 관련된 데이터 처리
    def sign(self, data:dict, type:str=''):
        user_controller = User_Controller(model = self.model)
        result = user_controller.processor(data=data, type=type) 
        return result

    def home(self, data:dict, type:str):
        pass

# Error가 발생할 경우 일관적으로 처리
class Error_Controller:
    def __init__(self, Error_type):
        parser = Error_Json_Parser()
        parser.set_body(tip = Error_type)
        self.result = parser.get_data()

    def get_result(self):
        return self.result

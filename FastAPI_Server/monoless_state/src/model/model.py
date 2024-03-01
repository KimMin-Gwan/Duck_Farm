from database_ma import *
from model.data_format import *


class User_Model:
    def __init__(self) -> None:
        self.db=None

    
    def find_user_uid(self,uid):
        print(uid)

    def get_user_data_as_uid(self,uid,user):
        pass

    def modify_user_data(self,user):
        pass

class Master:
    def __init__(self) -> None:
        self.db=Database()
        self.local_data=Local_Database()

    def get_user_model(self):
        return  User_Model()

    def get_master_model():  #정확한 사용 범위
        return Master()
    
    def get_local_data(self):
        return self.local_data

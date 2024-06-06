from model.fake_database import Local_database
class User_Model:
    # user 유효성 검사
    def __init__(self,databass) -> None:
        self.__databass:Local_Database = databass
    def __init__(self,database) -> None:
        self.__database:Local_database = database
        self.__user = None

    def is_vaild_user(self,uid):
        result = False
        user_data = self.__database.find_user_with_uid(uid)
        if not user_data:
            return result
        self.__user = User(user_data)
        result = True
        return result
    

class User:
    # user 데이터 관리
    def __init__(self, user_data:dict):
        self.__uid = user_data['uid']
        self.__uname =  user_data['uname']
        self.__password =  user_data['password']
        self.__birthday = user_data['birthday']

    def get_uid(self):
        return self.__uid
        
    def get_uname(self):
        return self.__uname
        
    def get_password(self):
        return self.__password

    def get_birthday(self):
        return self.__birthday
        
    def set_birthday(self, birthday):
        self.__birthday = birthday
        return

    def set_uid(self, uid):
        self.__uid = uid
        return

    def set_uname(self, uname):
        self.__uname = uname
        return

    def set_password(self, password):
        self.__password = password 
        return
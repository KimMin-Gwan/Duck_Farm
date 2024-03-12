import json

# 1. accessor, mutator 생성
# 2. 데이터 내부 멤버로 설정해서 보안 유지 (ex. self.__uid)
# 3. mutator중 하나로 한번에 모든 내부 데이터 만들 수 있도록 설정
class User:
    def __init__(self) -> None:
        self.__uid=None
        self.__sex=None
        self.__email=None
        self.__password=None
        self.__birthday=None
        self.__nickname=None
        self.__phonenumber=None 
    def set_user_data(self,uid,email,password,birthday,phone,name,sex):
        self.__uid=uid
        self.__email=email
        self.__password=password
        self.__nickname=name
        self.__phonenumber=phone
        self.__birthday=birthday
        self.__sex=sex
    def get_email(self):
        return self.__email
    def get_sex(self):
        return self.__sex
    def get_password(self):
        return self.__password
    def get_birthday(self):
        return self.__birthday
    def get_nickname(self):
        return self.__nickname
    def get_phonenumber(self):
        return self.__phonenumber
    def get_uid(self):
        return self.__uid
    def set_email(self,email):
        self.__email=email
    def set_sex(self,sex):
        self.__sex=sex
    def set_password(self,password):
        self.__password=password
# 이건 아직 작성 안해도됨
class Profile:
    def __init__(self,user):
        self.user=user





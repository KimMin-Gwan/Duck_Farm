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
    def set_user_data(self,uid,sex,email,password,birthday,nickname,phonenumber):
        self.__uid=uid
        self.__sex=sex
        self.__email=email
        self.__password=password
        self.__birthday=birthday
        self.__nickname=nickname
        self.__phonenumber=phonenumber
# 이건 아직 작성 안해도됨
class Profile:
    def __init__(self,user):
        self.user=user





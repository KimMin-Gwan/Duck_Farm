import json

# 1. accessor, mutator 생성
# 2. 데이터 내부 멤버로 설정해서 보안 유지 (ex. self.__uid)
# 3. mutator중 하나로 한번에 모든 내부 데이터 만들 수 있도록 설정
class User:
    def __init__(self) -> None:
        self.__uid
        self.__sex
        self.__email
        self.__password
        self.__birthday
        self.__nickname
    
    def set_user_data(self,uid,data):
        self.__uid=uid
        self.__sex=data[0]
        self.__email=data[1]
        self.__password=data[2]
        self.__birthday=data[3]
        self.__nickname=data[4]

# 이건 아직 작성 안해도됨
class Profile:
    def __init__(self,user):
        self.user=user





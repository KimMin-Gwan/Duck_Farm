import json

# 1. accessor, mutator 생성
# 2. 데이터 내부 멤버로 설정해서 보안 유지 (ex. self.__uid)
# 3. mutator중 하나로 한번에 모든 내부 데이터 만들 수 있도록 설정
class User:
    def __init__(self) -> None:
        self.uid
        self.sex
        self.email
        self.password
        self.birthday
        self.nickname
    
    def set_user_data(self,uid,data):
        pass

class Profile:
    def __init__(self,user):
        self.user=user





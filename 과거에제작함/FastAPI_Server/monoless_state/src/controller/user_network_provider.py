from src.model import User
from model import *
from network_provider import Json_Parser


# 로그인
class Sign_In_Json_Parser(Json_Parser):
    def __init__(self):
        super.__init__()
        self.body:dict = {
            "user" : {
                'uid' : 0, # 유저 번호
                'email' : "email@email.com",  # 이메일 정보
                'birthday' : "yy/mm/dd",  # 날짜 타입
                'sex' : 'male',  # male vs female
                'nickname' : 'nick' # 닉네임
            }, 
            "status" : 0, # 처리결과 int
            "about" : "tips" # 처리 결과에 대한 주석
        }

    def set_body(self, user_data:User, status:int, about:str) -> None:
        self.body['user']['uid'] = user_data.get_uid()
        self.body['user']['email'] = user_data.get_email()
        self.body['user']['birthday'] = user_data.get_birthday()
        self.body['user']['sex'] = user_data.get_sex()
        self.body['user']['nickname'] = user_data.get_nickname()
        self.body['status'] = status
        self.body['about'] = about
        return
    
    def get_data(self):
        return self.body
    

# 회원 가입
class Sign_Up_Json_Parser(Json_Parser):
    def __init__(self):
        super.__init__()
        self.body:dict = {
            "status" : 0, # 처리결과 int
            "about" : "tips" # 처리 결과에 대한 주석
        }

    # 회원가입시 사용하는 set_otp, 비밀번호 찾기도 이것을 사용
    def set_otp_body(self, otp:int, status:int, about:str) -> None:
        self.body['otp'] = otp
        self.body['status'] = status
        self.body['about'] = about
        return 

    # 비밀번호 설정, 바로 로그인이될것
    def set_password_body(self, user_data:User, status:int, about:str) -> None:
        self.body['uid'] = user_data.get_uid()
        self.body['email'] = user_data.get_email()
        self.body['status'] = status
        self.body['about'] = about
        return 
    

# 비밀번호 찾기(Sing_Up_Json_Pasrser를 상속)
class Find_Password_Json_Parser(Sign_Up_Json_Parser):
    def __init__(self):
        super.__init__()

    def set_otp_body(self, otp: int, status: int, about: str) -> None:
        return super().set_otp_body(otp, status, about)

    # 오버라이딩
    def set_password_body(self, status: int, about: str) -> None:
        self.body['status'] = status # 결과
        self.body['about'] = about
        return 


class Find_Email_Json_Parser(Json_Parser):
    def __init__(self):
        super.__init__()
        self.body:dict = {
            "status" : 0, # 처리결과 int
            "about" : "tips" # 처리 결과에 대한 주석
        }


    def set_body(self, status: int, about: str) -> None:
        self.body['status'] = status # 결과
        self.body['about'] = about
        return 
    



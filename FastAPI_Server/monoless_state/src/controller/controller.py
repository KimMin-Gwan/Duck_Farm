import json
import time
from model import User, Master_Model
from network_provider import Error_Json_Parser
from user_network_provider import *

import random

class Master_Controller:
    def __init__(self, model):
        self.model:Master_Model = model
    
    # 유저와 관련된 데이터 처리
    def sign(self, data:dict, type:str):
        user_controller = User_Controller(model = self.model)
        result = user_controller.processor(data=data, type=type) 
        return result

# Error가 발생할 경우 일관적으로 처리
class Error_Controller:
    def __init__(self, Error_type):
        parser = Error_Json_Parser()
        parser.set_body(tip = Error_type)
        self.result = parser.get_data()

    def get_result(self):
        return self.result


# User 관련 처리
class User_Controller:
    def __init__(self, model, uid=0):
        # user는 왜 만드는가?
        self.user_data = User() #  초기화된 상태로 생성
        self.model:User_Model= model # Model
        sign_in_flag = False
        """
        if uid:
            if self.get_user_data(uid):
                print(f"System_Error||{uid}_user_sign_in")
            else:
                print("System_Error||User_Data_could_not_found")
        """

    # 프로세싱 (data : json데이터, type: 어떤 형식)
    def processor(self, data:dict, type:str):
        body:dict = data['body'] #json 바디 데이터
        try:
            action = self.data['header']['action']
            if action == "sign_in":
                result = self.try_sign_in(data=body) # json데이터 
            if action == "sign_up": # 구축중
                result = self.try_sign_in(data=body, type = type)


        except Exception as error_message:
            error_controller = Error_Controller(Error_type=error_message)
            result = error_controller.get_result()
        finally:
            return result
        
    # 로그인
    def try_sign_in(self, data):
        sign_in = Sign_In(model=self.model) # sign_in
        status, tip = sign_in.try_login(data) #function
        parser = Sign_In_Json_Parser()
        parser.set_body(user_data=self.model.get_user(),  # body data setting
                        status=status, about = tip)
        result = parser.get_data() # json parsing
        return result

    # 회원가입
    def try_sign_up(self, data, type):
        sign_up = Sign_Up(model=self.model)
        status, tip = sign_up.try_sign_up(data=data, type=type)
        if type == "email":
            parser = Sign_Up_Json_Parser()
            parser.set_otp_body(otp=self.model.get_otp(), # set_opt가 선행되어야함
                                 status=status, tip=tip)
        if type == "password":
            parser = Sign_Up_Json_Parser()
            parser.set_password_body(user_data=self.model.get_user(),
                                     status=status, tip=tip)
        result = parser.get_data()
        return result

class Sign_Up:
    def __init__(self, model):
        self.model:User_Model = model

    # data : body 데이터 | type : 어떤 종류의 리퀘스트인가(endpoint)
    def try_sign_up(self, data:dict, type:str):
        result: bool = False
        email = data['email']
        email_result:bool = False
        if type == "email":
            email_result = self.model.find_email(email)
            if email_result:
                result = 0
                tip = "email duplicated"
            else:
                otp_maker = OTP_Maker()
                otp_maker.otp_making(email=email)
                # otp_maker.send_otp(email=email) otp 보내야함
                result = 1,
                tip = "otp send to email"
        if type == "password":
            rex_otp = self.model.get_otp_db(email=email)
            otp = data['otp']
            if otp!=rex_otp:
                result = 0
                tip = "bad access => wrong otp"
            else:
                # 03/02 오후에 작업할 부분
                uid = self.__make_uid()

                #self.model.make_user(uid=uid, email=email, pssowrd= password,
                #                     birthday=birthdya, sex=sex)

                pass


        return result, tip
    
    def __make_uid(self):
        return
        # 03/02 오후에 작업할 부분

class OTP_Maker:
    def __init__(self, model):
        self.model = model
    
    # otp를 만들고 저장
    def otp_making(self, email:str):
        otp, encrypted_otp = self.__otp_generator(email=email)
        self.model.set_otp(encrypted_otp, otp, email) # otp 저장 with email
        return 

    # 이메일로 otp를 보내는 함수
    def send_otp(self, email):
        # otp를 메일로 보내야함
        return 
        
    # otp를 만들어내는 함수
    def __otp_generator(self, email):
        first = ord(email[0])
        second = ord(email[1])
        otp = int(random.random() * 10000)
        encrypted_otp = otp * first * second
        return otp, encrypted_otp

class Sign_In:
    def __init__(self, model):
        self.model = model
    
    def try_login(self, data):
        result: int = 0# 반환 데이터
        email_result :bool = False # 이메일 확인 결과 
        email = data['email']
        password = data['password']
        email_result = self.model.find_email(email)
        if email_result:
            self.model.set_user(email) # 모델에 유저 생성
            # 이 함수는 논의가 필요
            if password == self.model.get_user().get_password():
                result = 1
                tip:str = "sign up successfully"
            else:
                tip:str = "Password not match"
        else:
            tip:str = "Email does not exist"

        return result, tip
                
    
    
        
        
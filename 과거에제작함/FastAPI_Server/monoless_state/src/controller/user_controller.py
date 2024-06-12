from model import User
from user_network_provider import *
from controller import Error_Controller
import random
from datetime import datetime # uid 만드는데 활용하려고 했음

# User 관련 처리
class User_Controller:
    def __init__(self, model, uid=0):
        # user는 왜 만드는가?
        self.user_data = User() #  초기화된 상태로 생성
        self.model:User_Model= model # Model
        sign_in_flag = False
        ''' # uid가 있으면 따로 처리해야함
        if uid:
            if self.get_user_data(uid):
                print(f'System_Error||{uid}_user_sign_in')
            else:
                print('System_Error||User_Data_could_not_found')
        '''

    # 프로세싱 (data : json데이터, type: 어떤 형식)
    def processor(self, data:dict, type:str = ''):
        body:dict = data['body'] #json 바디 데이터
        try:
            action = self.data['header']['action']
            if action == 'sign_in':
                result = self.try_sign_in(data=body) # json데이터 
            if action == 'sign_up': # 구축중
                result = self.try_sign_in(data=body, type = type)
            if action == 'find_email':
                result = self.try_find_email(data=body)
            if action == 'find_password':
                result = self.try_find_password(data=body, type=type)
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
        parser.set_header(action='sign_in')
        parser.set_body(user_data=self.model.get_user(),  # body data setting
                        status=status, about = tip)
        result = parser.get_data() # json parsing
        return result

    # 회원가입
    def try_sign_up(self, data, type):
        sign_up = Sign_Up(model=self.model)
        status, tip = sign_up.try_sign_up(data=data, type=type)
        parser = Sign_Up_Json_Parser()
        if type == 'email':
            parser.set_header(action='sign_up')
            parser.set_otp_body(otp=self.model.get_otp(), # set_opt가 선행되어야함
                                 status=status, about=tip)
        if type == 'password':
            parser.set_header(action='sign_up')
            parser.set_password_body(user_data=self.model.get_user(),
                                     status=status, about=tip)
        result = parser.get_data()
        return result
    
    # 이메일 검색
    def try_find_email(self, data):
        find_email = Find_Email(model=self.model)
        status, tip = find_email.try_find_email(data=data)
        parser = Find_Email_Json_Parser()
        parser.set_header('find_email')
        parser.set_body(status=status, about=tip)
        result = parser.get_data()
        return result
    
    def try_find_password(self, data:dict, type:str):
        find_password = Find_Password(model=self.model)
        status, tip = find_password.try_find_password(data=data, type=type)
        parser = Find_Password_Json_Parser()
        if type == 'email':
            parser.set_header(action='find_password')
            parser.set_otp_body(otp=self.model.get_otp(), # set_opt가 선행되어야함
                                 status=status, about=tip)
        if type == 'password':
            parser.set_header(action='find_password')
            parser.set_password_body(status=status, about=tip)
        result = parser.get_data()
        return result


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

class Sign_Up:
    def __init__(self, model):
        self.model:User_Model = model

    # data : body 데이터 | type : 어떤 종류의 리퀘스트인가(endpoint)
    def try_sign_up(self, data:dict, type:str):
        result: int= False
        email = data['email']
        email_result:bool = False
        if type == 'email':
            result, tip = self.__type_email(self, data)
        if type == 'password':
            result, tip = self.__type_password(self, data)

        return result, tip
    
    def __type_email(self, email):
        email_result = self.model.find_email(email)
        result = 0
        if email_result:
            result = 0
            tip = 'email duplicated'
        else:
            otp_maker = OTP_Maker(self.model)
            otp_maker.otp_making(email=email)
            # otp_maker.send_otp(email=email) otp 보내야함
            result = 1,
            tip = 'otp send to email'

        return result , tip

    def __type_password(self, data):
        result = 0
        rex_otp = self.model.get_otp_db(email=email)
        otp = data['otp']
        if otp!=rex_otp:
            result = 0
            tip = 'bad access => wrong otp'
        else:
            # 03/02 오후에 작업할 부분
            uid = self.__make_uid()
            email = data['email']
            password = data['password']
            birthday = data['birthhday']
            sex = data['sex']
            self.model.make_user(uid=uid, email=email, pssowrd= password,
                                    birthday=birthday, sex=sex)
            result = 1
            tip = 'sign up successfully'
        return result, tip
    
    def __make_uid(self):
        # 아직 못정함
        return


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
                tip:str = 'sign up successfully'
            else:
                tip:str = 'Password not match'
        else:
            tip:str = 'Email does not exist'

        return result, tip
                
    
class Find_Email:
    def __init__(self, model):
        self.model:User_Model = model

    def try_find_email(self, data):
        result:int = 0
        email_result:bool = False
        email = data['email']
        email_result = self.model.find_email(email)
        if email_result:
            result= 1
            tip:str = 'email exist'
        else:
            resul= 0
            tip:str = 'email does not exist'
        return result, tip
    

class Find_Password(Sign_Up):
    def __init__(self, model):
        super.__init__(model=model)
    
    def __type_password(self, data):
        result = 0
        email = data['email']
        rex_otp = self.model.get_otp_db(email=email)
        otp = data['otp']
        if otp!=rex_otp:
            result = 0
            tip = 'bad access => wrong otp'
        else:
            password = data['password']
            self.model.set_user_password(password) # 변경 
            if self.model.modify_user_data(): # 수정한 내용 저장
                result = 1
                tip = 'sign up successfully'
            else:
                result = 0
                tip = 'Database not work'
        return result, tip
    
    # 이걸 써야됨
    def try_find_password(self, data:dict, type:str):
        return super().try_sign_up(data=data, type=type)
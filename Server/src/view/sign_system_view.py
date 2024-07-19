#from typing import Any
from fastapi import FastAPI
from view.master_view import Master_View, RequestHeader
from view.parsers import Head_Parser
from controller import Sign_Controller
import json

class Sign_Service_View(Master_View):
    def __init__(self, app:FastAPI, endpoint:str, database, head_parser) -> None:
        super().__init__(head_parser=head_parser)
        self.__app = app
        self._endpoint = endpoint
        self.__database = database
        self.register_route(endpoint)

    def register_route(self, endpoint:str):
        @self.__app.get(endpoint+'/home')
        def home():
            return 'Hello, This is Root of Sign System Service'

        @self.__app.post(endpoint+'/try_sign_up')
        def try_sign_up(raw_request:dict):
            request = SingUpRequest(request=raw_request)
            sign_controller=Sign_Controller()
            model = sign_controller.try_sign_up(database=self.__database,
                                                             request=request)
            response = model.get_response_form_data(self._head_parser)
            return response
        
        @self.__app.post(endpoint+'/try_login')
        def try_login(raw_request:dict):
            request = LoginRequest(request=raw_request)
            sign_controller=Sign_Controller()
            model = sign_controller.try_login(database=self.__database,
                                                             request=request)
            response = model.get_response_form_data(self._head_parser)
            return response
        
        @self.__app.post(endpoint+'/try_change_password')
        def try_change_password(raw_request:dict):
            request = ChangePasswordRequest(request=raw_request)
            sign_controller=Sign_Controller()
            model = sign_controller.try_change_password(database=self.__database,
                                                             request=request)
            response = model.get_response_form_data(self._head_parser)
            return response
        
        # email 확인
        @self.__app.post(endpoint+'/try_check_email')
        def try_change_password(raw_request:dict):
            request = CheckEmailRequest(request=raw_request)
            sign_controller=Sign_Controller()
            model = sign_controller.check_user_email(database=self.__database,
                                                             request=request)
            response = model.get_response_form_data(self._head_parser)
            return response

class SingUpRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.email = body['email']
        self.password = body['password']
        self.nickname = body['nickname']
        self.birthday = body['birthday']
        self.uname = body['uname']

class LoginRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.email = body['email']
        self.password = body['password']

class ChangePasswordRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.email = body['email']
        self.password = body['password']

# email 확인
class CheckEmailRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.email = body['email']







from typing import Any
from fastapi import FastAPI
from view.master_view import Master_View
from view.parsers import Head_Parser

from controller import Upload_Controller
from controller import Core_Controller
import json

class Core_Service_View(Master_View):
    def __init__(self, app:FastAPI, endpoint:str, database) -> None:
        self.__app = app
        self._endpoint = endpoint
        self.__database = database
        self.register_route(endpoint)

    def register_route(self, endpoint:str):
        @self.__app.get(endpoint+"/home")
        def home():
            return "Hello, This is Root of Core-System Service"

        @self.__app.post(endpoint+"/home_page") #홈 bias선택, 달력, schedule
        def home(request:dict):#request: uid, bid(default: )
            core_Controller=Core_Controller(self.__database)
            result = core_Controller.get_home_data(request) 

            response = Response_Result(
                request_type="client", state_code=result['state-code'],
                detail="success", home_image=result['home_image'],
                bid=result['bid'], date=result['date']
            )

            return response.make_send_data()
        
        @self.__app.post(endpoint+"/upload_post")
        def upload_new_post(request:dict):
            
            # Upload_Controller 생성 및 업로드 처리
            upload_Controller = Upload_Controller(self.__database)
            result= upload_Controller.upload_new_post(request=request)
            response = Response_Result(
                request_type= "client", state_code=result['state-code'],
                detail="success", upload_token= result['token'], bid= result['bid'],
                iid=result['iid']
            )
            return response.make_send_data()


class Response_Result(Head_Parser):
    def __init__(self, request_type, state_code, detail="default",
                 date="", bid="", home_image={}, 
                 upload_token="", iid=""):
        self._header['request-type'] = request_type
        self._header['state-code'] = state_code
        self._header['detail'] = detail
        self._body = {
            "date" : date,
            "bid" : bid,
            "total_image_list" : home_image,
            "upload_token" : upload_token,
            "iid" : iid
        } 

    def make_send_data(self):
        send_data = {
            "header" : self._header,
            "body" : self._body
        }
        response = json.dumps(send_data)
        response = response.encode()
        return response
        








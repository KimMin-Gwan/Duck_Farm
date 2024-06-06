from typing import Any
from fastapi import FastAPI
from  view.master_view import Master_View
from controller import Upload_Controller
import json

class Core_Service_View(Master_View):
    def __init__(self, app:FastAPI, endpoint:str, databass) -> None:
        self.__app = app
        self._endpoint = endpoint
        self.__databass = databass
        self.register_route(endpoint)

    def register_route(self, endpoint:str):
        @self.__app.get(endpoint+"/home")
        def home():
            return "Hello, Core_View"

        @self.__app.post(endpoint+"/home")
        def home(request:dict):
            print(request)
            return
        
        @self.__app.post(endpoint+"/upload_post")
        def upload_new_post(request:dict):
            
            # Upload_Controller 생성 및 업로드 처리
            upload_Controller = Upload_Controller(self.__databass)
            result= upload_Controller.upload_new_post(request=request)

            # 응답 헤더/바디 설정
            self._header['request-type'] = "client"
            self._header['state-code'] = result['state-code']
            if result['state-code'] == 222:
                self._header['deatail'] = "Success to Save image"
            else:
                self._header['deatail'] = "Failed"
            body = {
                "upload-token" : result['token'],
                "bid" : result['bid'],
                "iid" : result['iid']
            }
            response = {
                "header" : self._header,
                "body" : body
            }

            response = json.dumps(response)
            response = response.encode()
            return response



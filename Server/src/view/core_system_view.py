from typing import Any
from fastapi import FastAPI
from view.master_view import Master_View
from view.parsers import Head_Parser

#from controller import Upload_Controller
from controller import Core_Controller
#from controller import Image_Controller
import json

class Core_Service_View(Master_View):
    def __init__(self, app:FastAPI, endpoint:str, database, head_parser) -> None:
        super().__init__(head_parser=head_parser)
        self.__app = app
        self._endpoint = endpoint
        self.__database = database
        self.register_route(endpoint)

    def register_route(self, endpoint:str):
        @self.__app.get(endpoint+'/home')
        def home():
            return 'Hello, This is Root of Core-System Service'

        @self.__app.post(endpoint+'/none_bias_home_data')
        def none_bias_home_data(raw_request:dict):
            request = NoneBiasHomeDataRequest(request=raw_request)
            core_controller=Core_Controller()
            model = core_controller.get_none_bias_home_data(database=self.__database,
                                                             request=request)
            response = model.get_response_form_data(self._head_parser)
            return response
        
        @self.__app.post(endpoint+'/bias_home_data')
        def bias_home_data(raw_request:dict):
            request = BiasHomeDataRequest(request=raw_request)
            core_controller=Core_Controller()
            model = core_controller.get_bias_home_data(database=self.__database,
                                                             request=request)
            response = model.get_response_form_data(self._head_parser)
            return response

        @self.__app.post(endpoint+'/detail_image')
        def get_image_detail(raw_request:dict):
            request = DetailImageRequest(request=raw_request)
            core_controller = Core_Controller()
            model = core_controller.get_image_detail(database=self.__database,
                                                     request=request)
            response = model.get_response_form_data(self._head_parser)
            return response



class RequestHeader:
    def __init__(self, request) -> None:
        header = request['header']

        self.request_type = header['request-type']
        self.client_version = header['client-version']
        self.client_ip = header['client-ip']
        self.uid = header['uid']
        self.endpoint = header['endpoint']

class NoneBiasHomeDataRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']
        self.date = body['date']

class BiasHomeDataRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']
        self.bid = body['bid']
        self.date = body['date']
        
class DetailImageRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']
        self.iid = body['iid']








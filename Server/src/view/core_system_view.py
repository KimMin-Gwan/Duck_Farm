from typing import Any
from fastapi import FastAPI
from view.master_view import Master_View, RequestHeader
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

        @self.__app.post(endpoint+'/image_detail')
        def image_detail(raw_request:dict):
            request = ImageDetailRequest(request=raw_request)
            core_controller = Core_Controller()
            model = core_controller.get_image_detail(database=self.__database,
                                                     request=request)
            response = model.get_response_form_data(self._head_parser)
            return response
        
        @self.__app.post(endpoint+'/get_image_list_by_bias')
        def get_image_list_by_bias(raw_request:dict):
            request = ImageListByBias(request=raw_request)
            core_controller = Core_Controller()
            model = core_controller.get_image_list_by_bias(database=self.__database,
                                                     request=request)
            response = model.get_response_form_data(self._head_parser)
            return response
        
        @self.__app.post(endpoint+'/get_image_list_by_bias_n_schdule')
        def get_image_list_by_bias_n_schdule(raw_request:dict):
            request = ImageListByBiasNSchedule(request=raw_request)
            core_controller = Core_Controller()
            model = core_controller.get_image_list_by_bias_n_schedule(database=self.__database,
                                                     request=request)
            response = model.get_response_form_data(self._head_parser)
            return response
        
        # 최애 팔로잉
        @self.__app.post(endpoint+'/get_bias_following')
        def get_bias_list_by_uid(raw_request:dict):
            request = BiasListByUid(request=raw_request)
            core_controller = Core_Controller()
            model = core_controller.get_bias_list(database=self.__database,
                                                     request=request)
            response = model.get_response_form_data(self._head_parser)
            return response
        
        # 이미지 검색
        @self.__app.post(endpoint+'/search_images')
        def get_search_images(raw_request:dict):
            request = ImageListByRequest(request=raw_request)
            core_controller = Core_Controller()
            model = core_controller.try_search_image(database=self.__database,
                                                     request=request)
            response = model.get_response_form_data(self._head_parser)
            return response

        # 최애 팔로우 시도(언팔 시도 )
        @self.__app.post(endpoint+'/try_follow_bias')
        def try_follow_bias(raw_request:dict):
            request = TryFollowBiasRequest(request=raw_request)
            core_controller = Core_Controller()
            model = core_controller.try_follow_bias(database=self.__database,
                                                     request=request)
            response = model.get_response_form_data(self._head_parser)
            return response


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
        
class ImageDetailRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']
        self.iid = body['iid']
        self.bid = body['bid']

class ImageListByBias(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']
        self.bid = body['bid']
        self.ordering = body['ordering']
        self.num_image = body['num_image']

class ImageListByBiasNSchedule(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']
        self.bid = body['bid']
        self.sid = body['sid']
        self.ordering = body['ordering']
        self.num_image = body['num_image']

# 최애 팔로잉
class BiasListByUid(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']

# 이미지 검색
class ImageListByRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.key_word = body['key_word']
        self.ordering = body['ordering']
        self.num_image = body['num_image']

# 최애 팔로우 시도
class TryFollowBiasRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']
        self.bid = body['bid']







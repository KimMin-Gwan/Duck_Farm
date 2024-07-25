from typing import Any
from fastapi import FastAPI
from view.master_view import Master_View, RequestHeader
from view.parsers import Head_Parser

#from controller import Upload_Controller
from controller import Utility_Controller
#from controller import Image_Controller
import json

class Utility_Service_View(Master_View):
    def __init__(self, app:FastAPI, endpoint:str, database, head_parser) -> None:
        super().__init__(head_parser=head_parser)
        self.__app = app
        self._endpoint = endpoint
        self.__database = database
        self.register_route(endpoint)

    def register_route(self, endpoint:str):
        @self.__app.get(endpoint+'/home')
        def home():
            return 'Hello, This is Root of Utility-System Service'

        @self.__app.post(endpoint+'/image_like_n_dislike')
        def none_bias_home_data(raw_request:dict):
            request = ImageLikeRequest(request=raw_request)
            utility_controller=Utility_Controller()
            model = utility_controller.try_image_like_n_dislike(database=self.__database,
                                                             request=request)
            response = model.get_response_form_data(self._head_parser)
            return response
        
        @self.__app.post(endpoint+'/search_schedule')
        def search_schedule_data(raw_request:dict):
            request = SearchscheduleRequest(request=raw_request)
            utility_controller=Utility_Controller()
            model = utility_controller.try_search_schedule_with_keyword(database=self.__database,
                                                                    request=request)
            response = model.get_response_form_data(self._head_parser)
            return response

        @self.__app.post(endpoint+'/search_bias')
        def search_bias_data(raw_request:dict):
            request = SearchBiasRequest(request=raw_request)
            utility_controller=Utility_Controller()
            model = utility_controller.try_search_bias_with_keyword(database=self.__database,
                                                                    request=request)
            response = model.get_response_form_data(self._head_parser)
            return response

        # 최애 팔로우 시도(언팔 시도 )
        @self.__app.post(endpoint+'/try_follow_bias')
        def try_follow_bias(raw_request:dict):
            request = TryFollowBiasRequest(request=raw_request)
            utility_controller=Utility_Controller()
            model = utility_controller.try_follow_bias(database=self.__database,
                                                     request=request)
            response = model.get_response_form_data(self._head_parser)
            return response

# 최애 팔로우 시도
class TryFollowBiasRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']
        self.bid = body['bid']

class ImageLikeRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']
        self.iid = body['iid']
        self.like = body['like']  # bool

class SearchscheduleRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.key_word = body['key_word']

class SearchBiasRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.key_word = body['key_word']
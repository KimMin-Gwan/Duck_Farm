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
            return 'Hello, This is Root of Core-System Service'

        @self.__app.post(endpoint+'/image_like_n_dislike')
        def none_bias_home_data(raw_request:dict):
            request = ImageLikeRequest(request=raw_request)
            utility_controller=Utility_Controller()
            model = utility_controller.try_image_like_n_dislike(database=self.__database,
                                                             request=request)
            response = model.get_response_form_data(self._head_parser)
            return response
        

class ImageLikeRequest(RequestHeader):
    def __init__(self, request) -> None:
        super().__init__(request)
        body = request['body']
        self.uid = body['uid']
        self.iid = body['iid']
        self.like = body['like']  # bool
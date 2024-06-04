from typing import Any
from fastapi import FastAPI
from  view.master_view import Master_View


class Core_System_View(Master_View):
    def __init__(self, app:FastAPI, endpoint:str) -> None:
        self.__app = app
        self._endpoint = endpoint
        self.register_route(endpoint)

    def register_route(self, endpoint:str):
        @self.__app.get(endpoint+"/home")
        def home():
            return "Hello, Core_View"

        @self.__app.post(endpoint+"/home")
        def home(request:dict):
            print(request)
            return




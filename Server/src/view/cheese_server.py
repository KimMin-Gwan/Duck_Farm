from fastapi import FastAPI
from view.core_system_view import Core_Service_View
import uvicorn


class Cheese_Server:
    def __init__(self, databass) -> None:
        self.__app = FastAPI()
        self.__core_system_view = Core_Service_View(app=self.__app,
                                                   endpoint="/core_system",
                                                   databass=databass)
        self.__core_system_view()

    def run_server(self, host="127.0.0.1", port=5000):
        uvicorn.run(app=self.__app, host=host, port=port)




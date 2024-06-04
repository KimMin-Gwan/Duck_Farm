from fastapi import FastAPI
from view.core_system_view import Core_System_View
import uvicorn


class Cheese_Server:
    def __init__(self) -> None:
        self.__app = FastAPI()
        self.__core_system_view = Core_System_View(app=self.__app,
                                                   endpoint="/core_system")
        self.__core_system_view()

    def run_server(self, host="127.0.0.1", port=5000):
        uvicorn.run(app=self.__app, host=host, port=port)




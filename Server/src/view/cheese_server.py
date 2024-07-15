from fastapi import FastAPI
from view.core_system_view import Core_Service_View
from view.utility_system_view import Utility_Service_View
from view.parsers import Head_Parser
import uvicorn


class Cheese_Server:
    def __init__(self, database) -> None:
        self.__app = FastAPI()
        head_parser = Head_Parser()
        self.__core_system_view = Core_Service_View(app=self.__app,
                                                   endpoint='/core_system',
                                                   database=database,
                                                   head_parser=head_parser)
        self.__utility_system_view = Utility_Service_View(app=self.__app,
                                                   endpoint='/utility_system',
                                                   database=database,
                                                   head_parser=head_parser)

        self.__core_system_view()
        self.__utility_system_view()

    def run_server(self, host='127.0.0.1', port=5000):
        uvicorn.run(app=self.__app, host=host, port=port)




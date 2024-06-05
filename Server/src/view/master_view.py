
from parsers.head_parser import Head_Parser

class Master_View(Head_Parser):
    def __init__(self) -> None:
        self._endpoint = ""
        pass

    def __call__(self) -> None:
        print(f"INFO<-[      Server Route http://Server_HOST:PORT{self._endpoint} Ready.")
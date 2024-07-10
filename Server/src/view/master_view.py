
class Master_View():
    def __init__(self, head_parser) -> None:
        self._head_parser = head_parser
        self._endpoint = ''
        pass

    def __call__(self) -> None:
        print(f'INFO<-[      Server Route http://Server_HOST:PORT{self._endpoint} Ready.')
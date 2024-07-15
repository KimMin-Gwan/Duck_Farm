
class Master_View():
    def __init__(self, head_parser) -> None:
        self._head_parser = head_parser
        self._endpoint = ''
        pass

    def __call__(self) -> None:
        print(f'INFO<-[      Server Route http://Server_HOST:PORT{self._endpoint} Ready.')



class RequestHeader:
    def __init__(self, request) -> None:
        header = request['header']

        self.request_type = header['request-type']
        self.client_version = header['client-version']
        self.client_ip = header['client-ip']
        self.uid = header['uid']
        self.endpoint = header['endpoint']
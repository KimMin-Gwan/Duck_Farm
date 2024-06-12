import json

# Json 형태로 파싱 하는 부분
class Json_Parser:
    def __init__(self):
        self.header = {
            'version' : '',
            'date' : '',  # 'yy/mm/dd'
            'action' : 'default',
            'content-type': 'application/json'
        }
        self.body = {
            'status' : 0,
            'tip' : 'default set'
        }



    # 헤더 작성 부분
    def set_header(self, action:str = '') -> None:
        # action 설정
        self.header['action'] = action

        # version 정보 받아오기
        # self.header['version'] = 

        # 날짜 정보 받아오기 => str 타입 'yy/mm/dd'
        # datetime 모듈 사용해서 작성할것
        # self.header['date'] = 
        return

    # 포멧에 맞춰 정규화 -> json
    def set_data(self, body:dict):
        data = {
            'header' : self.header,
            'body' : body
        }
        json_data = self.json_parsing(data=data)
        return json_data

    # dict to json
    def json_parsing(self, data):
        json_data = json.dumps(data)
        return json_data
    
    def get_data(self):
        json_data = self.set_data(body = self.body)
        return json_data
    

class Error_Json_Parser(Json_Parser):
    def __init__(self):
        super.__init__()

    def set_body(self, tip):
        self.set_header(action='error')
        self.body['status'] = 'bad_access'
        self.body['tip'] = tip





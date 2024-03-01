import json

# 1. accessor, mutator 생성
# 2. 데이터 내부 멤버로 설정해서 보안 유지 (ex. self.__uid)
# 3. mutator중 하나로 한번에 모든 내부 데이터 만들 수 있도록 설정
class User:
    def __init__(self) -> None:
        self.uid
        self.sex
        self.email
        self.password
        self.birthday
        self.nickname
    
    def set_user_data(self,uid,data):
        pass

class Profile:
    def __init__(self,user):
        self.user=user

# Json 형태로 파싱 하는 부분
class Json_Parser:
    def __init__(self):
        self.header = {
            'version' : '',
            'date' : '',  # 'yy/mm/dd'
            'action' : 'default',
            'content-type': 'application/json'
        }

    # 헤더 작성 부분
    def set_header(self, action:str = "") -> None:
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
            "header" : self.header,
            "body" : body
        }
        json_data = self.json_parsing(data=data)
        return json_data

    # dict to json
    def json_parsing(self, data):
        json_data = json.dumps(data)
        return json_data


class Sign_In_Json_Parser(Json_Parser):
    def __init__(self):
        super.__init__()
        self.body:dict = {
            "user" : {
                'uid' : 0, # 유저 번호
                'email' : "email@email.com",  # 이메일 정보
                'password' : "password",  # 비밀번호
                'birthday' : "yy/mm/dd",  # 날짜 타입
                'sex' : 'male',  # male vs female
                'nickname' : 'nick' # 닉네임
            }, 
            "status" : 1, # 처리결과 int
            "about" : "tips" # 처리 결과에 대한 주석
        }

    def set_body(self, user_data:User, status:int, about:str):
        self.body['user']['uid'] = user_data








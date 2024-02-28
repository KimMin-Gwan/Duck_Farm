
# 샘플 타입
# 서버로 들어오는 데이터는 request, 서버에서 나가는 데이터는 response

request = {
    "header" : {
      'version' : '0.2.3', #버전 String
      'date' : "24/01/30",  #날짜 String
      'action' : 'default', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
      'user' : {'login' : 0, 'UID' : 0},  # 로그인된 대상이면 login = 1 (int), UID가 있다면 UID = uid (int)
    },
    "body" : {
        "state" : "true", # 비지니스 대상 데이터
    }
}


response = {
    'header' : {
        'version' : '0.2.3',  # 서버기준 최신 버전
        'date' : 'yy/mm/dd',  # 날짜 String
        'action' : 'defaulst',  # 동작 String
        'content-type': 'application/json' # 전송 데이터 타입 -> 변경 금지
    },
    "body" : {
        "data" : "data", #전하고 싶은 데이터
        "status" : "0", # 처리결과 str
        "about" : "tips" # 처리 결과에 대한 주석
    }
}

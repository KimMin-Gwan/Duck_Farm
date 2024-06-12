

# Email 검색 목적의 데이터
# '/find_email'

find_email_request = {
    'header' : {
      'version' : '0.2.3', #버전 String
      'date' : '24/01/30',  #날짜 String
      'action' : 'find_email', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
      'user' : {'login' : 0, 'UID' : 0},  # 로그인 안됨으로 0
    },
    'body' : {
        'email' : 'email@email.com', # 이메일
    }
}


find_email_response = {
    'header' : {
        'version' : '0.1',
        'date' : 'yy/mm/dd',
        'action' : 'find_email',
        'content-type': 'application/json'
    },
    'body' : {
        'status' : 1, # 처리결과 int
        'about' : 'login possible' # 처리 결과에 대한 주석
    }
}
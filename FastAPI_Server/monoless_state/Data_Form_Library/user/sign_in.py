
# 로그인 목적의 데이터

sign_in_request = {
    "header" : {
      'version' : '0.2.3', #버전 String
      'date' : "24/01/30",  #날짜 String
      'action' : 'signin', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
      'user' : {'login' : 0, 'UID' : 0},  # 로그인 안됨으로 0
    },
    "body" : {
        "email" : "email@email.com", # 이메일
        "password" : "Password!" #비밀번호
    }
}


sing_in_response = {
    'header' : {
        'version' : '0.1',
        'date' : 'yy/mm/dd',
        'action' : 'signin',
        'content-type': 'application/json'
    },
    "body" : {
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
}

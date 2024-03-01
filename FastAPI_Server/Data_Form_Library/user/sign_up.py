# 회원가입 목적의 데이터

# /sign_up/email


# 1 - 사전정보 제공 및 otp 요청
email_request = {
    "header" : {
      'version' : '0.2.3', #버전 String
      'date' : "24/01/30",  #날짜 String
      'action' : 'sign_up', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
      'user' : {'login' : 0, 'UID' : '0'},  # 로그인 안됨으로 0
    },
    "body" : {
        "email" : "email@email.com", # 이메일
    }
}

# otp 전송 부분은 수정이 필요함 # 암호화해버리는게 필요할듯
email_response= {
    "header" : {
      'version' : '0.2.3', #버전 String
      'date' : "24/01/30",  #날짜 String
      'action' : 'sign_up', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
    },
    "body" : {
        "otp" : 1234,  # otp데이터
        "status" : 1, # 처리결과 int
        "about" : "send otp as email" # 처리 결과에 대한 주석
    }
}

# /sign_up/password

# 2 - 비밀번호 설정 요청
password_request = {
    "header" : {
      'version' : '0.2.3', #버전 String
      'date' : "24/01/30",  #날짜 String
      'action' : 'password', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
      'user' : {'login' : 0, 'UID' : '0'},  # 로그인 안됨으로 0
    },
    "body" : {
        "otp" : 1234, # otp데이터 (암호화 x)
        "email" : "email@email.com", # 이메일
        "birthday" : "yy/mm/dd", # 생년월일
        "sex" : "male", # male vs female
        "password" : "Password!" # 변경요청 패스워드
    }
}


password_response= {
    "header" : {
      'version' : '0.2.3', #버전 String
      'date' : "24/01/30",  #날짜 String
      'action' : 'passord', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
    },
    "body" : {
        "uid" : '',  # uid 
        "email" : "email@email.com", # 이메일
        "status" : 0, # 처리결과 int
        "about" : "sign_in_complete" # 처리 결과에 대한 주석
    }
}

# 비밀번호를 찾는 목적의 데이터


# 1 - 이메일을 통해 otp 요청
# /find_password/email

email_request = {
    'header' : {
      'version' : '0.2.3', #버전 String
      'date' : '24/01/30',  #날짜 String
      'action' : 'find_password', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
      'user' : {'login' : 0, 'UID' : '0'},  # 로그인 안됨으로 0
    },
    'body' : {
        'email' : 'email@email.com', # 이메일
    }
}


# otp 전송 부분은 수정이 필요함
email_response= {
    'header' : {
      'version' : '0.2.3', #버전 String
      'date' : '24/01/30',  #날짜 String
      'action' : 'find_password', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
    },
    'body' : {
        'otp' : 1234,  # otp데이터
        'status' : 1, # 처리결과 int
        'about' : 'send otp as email' # 처리 결과에 대한 주석
    }
}


# 2 - 비밀번호 수정 요청
# /find_password/password
password_request = {
    'header' : {
      'version' : '0.2.3', #버전 String
      'date' : '24/01/30',  #날짜 String
      'action' : 'password', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
      'user' : {'login' : 0, 'UID' : '0'},  # 로그인 안됨으로 0
    },
    'body' : {
        'otp' : 1234, # otp데이터 (암호화 x)
        'email' : 'email@email.com', # 이메일
        'password' : 'Password!' # 변경요청 패스워드
    }
}


# otp 전송 부분은 수정이 필요함
password_response= {
    'header' : {
      'version' : '0.2.3', #버전 String
      'date' : '24/01/30',  #날짜 String
      'action' : 'password', # 동작 String
      'content-Type' : 'application/json',  # 전송 데이터 타입 -> 변경 금지
    },
    'body' : {
        'status' : 1, # 처리결과 int
        'about' : 'send otp as email' # 처리 결과에 대한 주석
    }
}

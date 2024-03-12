from src.model.database_ma import *
from src.model.data_format import *


class User_Model:
    def __init__(self) -> None:
        self.db=Database()
        self.localdb=Local_Database()
        self.user = User() # 유저 데이터 초기화 
        self.otp = 0 
  #uid 는 AUTO_INCREMENT 로 동작하고있음 
    # 유저 정보 리턴 
    # 이 함수의 존재 의의에 대해 논의가 필요 
    def get_user(self):
        return self.user
    
    # 이메일 검색
    def find_email(self,email:str) -> bool:
        #self.db.이메일 검색하는 함수
        return  self.db.find_user_email(email)

    # 이메일 또는 uid로 유저 생성
    # 해당 email 또는 uid가 있는지 확인하는 절차가 필요(선행)
    def set_user(self,eamil="", uid=0):
        (flag,uid)=self.db.find_user_email(eamil)

        if flag:
            self.user.set_user_data()
            pass # 아래 주석 참고
            #user_data = self.get_user_data_as_uid(uid) # 유저 데이터 검색
            #self.user = user(user_data)  # 유저 생성
        else:
            pass # 아래 주석 참고
            #user_data = self.get_user_data_as_email(email) # 유저 데이터 검색
            #self.user = user(user_data)  # 유저 생성
        return
    
    # otp 저장
    # 잠깐 사용할 용도 : self.otp, 저장하고 확인 용도: 로컬 DB에 저장
    def set_otp(self, email,encrypted_otp):
        self.otp = encrypted_otp  #  암호화된 데이터
        sql=f"INSERT INTO userTBL (email,otp_code) valuse (%s , %s)"
        data=(email,self.otp)
        self.localdb.cur.execute(sql.data)
        self.localdb.conn.commit() 
        # 로컬 DB에 otp와 email을 쌍으로 저장할것
        return 

    # set_otp가 선행되어야 의미있는 데이터가됨
    def get_otp(self):
        return self.otp
    
    # 로컬 db로 부터 찾아오기
    def get_otp_db(self, email) -> bool:
        # email로 검색하여 otp 찾아오기
        return #True vs False
    
    # uid, email, password, birthday, sex로 유저 만들고 DB에 저장
    def make_user(self, email:str, password:str, birthday:str,phone:str,name:str, sex:str) -> bool:
        # birthday는  "yy/mm/dd" 형식의 str 데이터
        # sex는 "male" 또는 "female" 형식의 str 데이터
        # self.user= User()로 만들고 그대로 저장
        try:
            self.user.set_user_data(email,password,birthday,phone,name,sex)
            return self.db.make_user_db(email,password,birthday,phone,name,sex)
        except:
            return False

    def set_user_password(self, password:str)->bool :
        self.user.set_password(password=password)
        return # True vs False

    def find_user_uid(self,uid):
        print(uid)

    def get_user_data_as_uid(self,uid,user):
        pass

    def modify_user_data(self):
        # db로 현재 self.user의 데이터로 수정해서 저장
        
        pass

class Master:
    def __init__(self) -> None:
        self.db=Database()
        self.local_data=Local_Database()

    def get_user_model(self):
        return  User_Model()

    def get_master_model():  #정확한 사용 범위
        return Master()
    
    def get_local_data(self):
        return self.local_data



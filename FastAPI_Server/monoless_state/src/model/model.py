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
        return  self.db.find_user_email(email)   #(bool / uid)
    
    # 이메일 또는 uid로 유저 생성
    # 해당 email 또는 uid가 있는지 확인하는 절차가 필요(선행)

    def set_user(self,email="", uid=0):  #매개변수가 두개거든 email // uid email을 보냈어 controller 에서는 
        #재사용가능한 코드를 만들라고 email // uid email 가지고 처리하고 uid ==0 이면 email로 찾고 email =="" 이면   user 를 만들어서 set을 해준다.
        sql=f"SELECT * FROM user_total_info WHERE "
        if email=="":
            sql+="uid = %s"
            data=(uid)
        elif uid==0:
            sql+="email = %s" 
            data=(email) 
            
        self.db.cur.execute(sql,data)
        self.db.conn.commit()
        result=self.db.cur.fetchone()
        self.user.set_user_data(result)
        return self.user
    
    # otp 저장
    # 잠깐 사용할 용도 : self.otp, 저장하고 확인 용도: 로컬 DB에 저장

    def set_otp(self, email,encrypted_otp):
        sql=f"INSERT INTO userTBL (email,otp_code) values (%s , %s)"
        data=(email,encrypted_otp)
        self.localdb.cur.execute(sql,data)
        self.localdb.conn.commit() 
        # 로컬 DB에 otp와 email을 쌍으로 저장할것
        return 
    # set_otp가 선행되어야 의미있는 데이터가됨

    def get_otp(self):   #otp
        return self.otp
    
    # 로컬 db로 부터 찾아오기
    def get_otp_db(self, email) -> bool:
        sql="SELECT otp_code FROM userTBL WHERE email = %s"
        self.localdb.cur.execute(sql,email)
        result=self.localdb.cur.fetchone()
        # email로 검색하여 otp 찾아오기
        if(result):
            self.otp=result[0]
            return self.otp 
        else:
            return None 
            
    # uid, email, password, birthday, sex로 유저 만들고 DB에 저장
    def make_user(self, uid,email:str, password:str, birthday:str,phone:str,name:str, sex:str) -> bool:
        # birthday는  "yy/mm/dd" 형식의 str 데이터
        # sex는 "male" 또는 "female" 형식의 str 데이터
        # self.user= User()로 만들고 그대로 저장
        try:
            self.user.set_user_data(uid,email,password,birthday,phone,name,sex)
            return self.db.make_user_db(uid,email,password,birthday,phone,name,sex)
        except:
            return False
    def set_user_password(self, email,password:str)->bool :
        # sql="UPDATE usertbl SET password = %s WHERE email = %s"
        # data=(password,email)

        # self.db.cur.execute(sql,data) 
        # self.db.conn.commit()
        self.user.set_password(password)
        # if(self.db.cur.rowcount>0):
        #     return True
        # else:
        #     return False
  #login model set_user
    def set_user_model_as_uid(self,uid):   #return user Model 
        #uid를 검색을 해서 찾아야하는가? 외부에서 우리 서버를 해킹했어 서버에서 ip를 알아냈을때 ip로 접근을 해서 request uid를 random 하게  uidcheck user_data ==> 기본 데이터들  user_Data 를 뽑는 이유가 main page request해야해 그사람 main page를 보여줘야함
        #  그사람에 대한 데이터를 
        #find_user_email ==> email 사용자가 이메일 찾기 할때 찾기 할때 찾기시작하는데 uid 는 모든상황에서  
        #두단어로 되어있는거 find로 되어있는것 find_email,find_password find라는 이름이 앞에 들어가면 찾기 들어가는 서비스가 제공된다. 
        #  user model 이라는게 model 이라는 친구가 controller 에서 비지니스 로직을 처리하기 위해서 응용하고 활용해야하는데 어떤 데이터를 막 가져다 주면 안된다.  user Model 이 아니고 count 모델 
        # 구독자 수를 count하는 모델이라고 친다면 self.count (integer )  user Model을 count데이터가 필요로해 3번 썼다고 쳐 한번 받은 데이터를 
        pass # 필요없어보임? 
    def get_user_data_as_uid(self,uid,user):
        pass
    
    def modify_user_data(self):
        # db로 현재 self.user의 데이터로 수정해서 저장
        sql="UPDATE usertbl SET email = %s , password= %s  WHERE uid = %s"
        data=(self.user.get_email(),self.user.get_password(),self.user.get_uid())
        self.db.cur.execute(sql,data)
        self.db.conn.commit()
        if(self.db.cur.rowcount>0):
            sql_user_info="UPDATE usertbl SET name = %s , tel = %s, birthdate =%s WHERE uid = %s"
            data_info=(self.user.get_nickname(),self.user.get_phonenumber(),self.user.get_birthday(),self.user.get_uid())
            self.db.cur.execute(sql_user_info,data_info) 
            self.db.conn.commit()
            if(self.db.cur.rowcount>0):
                return True
            else:
                return False
        else:
            return False
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



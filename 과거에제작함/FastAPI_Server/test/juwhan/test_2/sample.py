import pymysql
class Local:
    def __init__(self) -> None:
        self.conn=None
        self.cur=None
        self.__connect_db() 
    def __connect_db(self):
        print('reun __connect_local')
        self.conn=pymysql.connect(host='127.0.0.1',user='root',password='tjs991101',db='duckfarm',charset='utf8')
        self.cur=self.conn.cursor()      
    def send_query(self,type,sql):
        pass
    def __read_data(table,sql):
        pass

    def __write_data(table,sql):
        pass

    def __modify_data(table,sql):
        pass

    def __delete_data(table,sql):
        pass

class Database:
    def __init__(self) -> None:
        self.conn=None
        self.cur=None
        self.__connect_db() 
    def __connect_db(self):
        print('reun __connect_local')
        self.conn=pymysql.connect(host='127.0.0.1',user='root',password='tjs991101',db='duckfarm',charset='utf8')
        self.cur=self.conn.cursor()      

    def send_query(self,type=None,sql=None):
        self.cur.execute('SELECT * FROM user')
        result=self.cur.fetchall()
        print(result)
    def __read_data(self,table,sql):
        pass

    def write_data(self,table,sql):
        self.cur.execute ('INSERT INTO user (user_name , uid) values(sun,123)')
        self.conn.commit()
        pass

    def __modify_data(self,table,sql):
        pass

    def __delete_data(self,table,sql):
        pass

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

class User_Model:
    def __init__(self) -> None:
        self.db=Database()
    def find_user_uid(self,uid):
        print(uid)

    def get_user_data_as_uid(self,uid,user):
        pass

    def modify_user_data(self,user):
        pass

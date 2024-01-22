import pymysql
from Database.constant import *

class server_db:
    def __init__(self):
        self.conn=pymysql.connect(host=HOST,user=USER,password=PASSWORD,db=DB_NAME,charset='utf8')
        self.cur=self.conn.cursor()     

    def select_test(self):
        self.cur.execute("SELECT * from imgTBL")
        while(True):
            row=self.cur.fetchone()
            if row==None:
                break
            data1=row[0]
            print(data1)
            
    def insert_imgpth(self,useremail,imgpath,imgtype):
        sql = "CALL insert_imgpath(%s, %s, %s);"
        params = (useremail, imgpath, imgtype)
        self.cur.execute(sql, params)
        self.conn.commit()

            
# if __name__=="__main__":
#     my_sql=mysql()
#     #my_sql.select_test()
#     my_sql.insert_imgpth("maht","adsfasdf",1)

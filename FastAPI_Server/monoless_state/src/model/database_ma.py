import pymysql
import boto3
import requests
from PIL import Image
# 로컬 디비에 오늘 회원가입한 사람에 대한 데이터가 추가되어야함
class Local_Database: 
    def __init__(self) -> None:
        self.conn=None
        self.cur=None
        self.__connect_db() 
    def __connect_db(self):
        print("reun __connect_local")
        self.conn=pymysql.connect(host="192.168.0.6",user="duck",password="duckfarm1234!",db='duckfarm',charset='utf8')
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
        print("reun __connect_local")
        self.conn=pymysql.connect(host="192.168.0.6",user="duck",password="duckfarm1234!",db='duckfarm',charset='utf8')
        self.cur=self.conn.cursor()      

    def find_user_email(self,u_email):
        return self.cur.callproc("find_email",u_email)
    def send_query(self,type=None,sql=None):
        self.cur.execute("SELECT * FROM user")
        result=self.cur.fetchall()
        print(result)
    def __read_data(self,table,sql):
        pass

    def write_data(self,table,sql):
        self.cur.execute ("INSERT INTO user (user_name , uid) values(sun,123)")
        self.conn.commit()
        pass

    def __modify_data(self,table,sql):
        pass

    def __delete_data(self,table,sql):
        pass

class Bucket:
    def __init__(self)->None:
        self.s3=boto3.client('s3',endpoint_url="https://kr.object.ncloudstorage.com",aws_access_key_id="eeJ2HV8gE5XTjmrBCi48",aws_secret_access_key="zAGUlUjXMup1aSpG6SudbNDzPEXHITNkEUDcOGnv")
        
        self.response=self.s3.list_buckets()
        self.cors()
        self.img_num=0
    def cors(self):   # Cors 설정 해주는 함수 클래스 생성시 자동으로 실행되게 하고 
        bucket_name="baekhyun-test"
        cors_configuration = {
        'CORSRules': [{
            'AllowedHeaders': ['*'],
            'AllowedMethods': ['GET', 'PUT'],
            'AllowedOrigins': ['*'],
            'MaxAgeSeconds': 3000
        }]
    }
        self.s3.put_bucket_cors(Bucket=bucket_name,
                    CORSConfiguration=cors_configuration)    
        response = self.s3.get_bucket_cors(Bucket=bucket_name)
        print(response['CORSRules'])
    def show_bucket(self):  #bucket출력해주는 함수
        
        for bucket in self.response.get('Buckets', []):
            print(bucket.get('Name'))
            
    def put_bucket(self,local_file_path):  #저장소에 올리는 함수 
        bucket_name="baekhyun-test"
        #object_name="sample-folder/"
        #self.s3.put_object(Bucket=bucket_name ,Key=object_name)
        object_name=f'sample-folder/{self.img_num}.png'
        self.img_num+=1
        self.s3.upload_fileobj(local_file_path,bucket_name,object_name)
        
    def delete_bucket_file(self):  #저장소 내 파일 삭제 하는 함수
        bucket_name="test0.1"
        object_name='test사인2'
        self.s3.delete_object(Bucket=bucket_name,Key=object_name)
    def find_file(self) :
        bucket_name="baekhyun-test"
        object_key="/sample/1.jpg"

if __name__=='__main__':
    print("dfadsf")
    buc=Bucket()
    buc.show_bucket()
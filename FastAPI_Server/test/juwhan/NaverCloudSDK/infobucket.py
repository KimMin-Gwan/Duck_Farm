import boto3
from NaverCloudSDK.info import *
import requests
from PIL import Image
service_name = 's3'
endpoint_url = 'https://kr.object.ncloudstorage.com'
#endpoint_url = 'kibxopaerykk22247051.cdn.ntruss.com'
region_name = 'kr-standard'
access_key = ACCESS_KEY
secret_key =SECRET_KEY 
class bucket:
    def __init__(self) -> None:
        self.s3=boto3.client(service_name,endpoint_url=endpoint_url,aws_access_key_id=access_key,aws_secret_access_key=secret_key)
        
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

if __name__ == "__main__":
    buc=bucket()
    buc.show_bucket()

    buc.put_bucket()
    #buc.delete_bucket_file()
    #buc.find_file()
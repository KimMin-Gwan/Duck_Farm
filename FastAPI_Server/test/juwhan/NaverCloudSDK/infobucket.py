import boto3
from info import *
service_name = 's3'
endpoint_url = 'https://kr.object.ncloudstorage.com'
region_name = 'kr-standard'
access_key = ACCESS_KEY
secret_key =SECRET_KEY 

class bucket:
    def __init__(self) -> None:
        self.s3=boto3.client(service_name,endpoint_url=endpoint_url,aws_access_key_id=access_key,aws_secret_access_key=secret_key)
        
        self.response=self.s3.list_buckets()
        
    
    def show_bucket(self):
        for bucket in self.response.get('Buckets', []):
            print(bucket.get('Name'))
    
if __name__ == "__main__":
    #s3 = boto3.client(service_name, endpoint_url=endpoint_url, aws_access_key_id=access_key,
#                      aws_secret_access_key=secret_key)

    #response = s3.list_buckets()

#    for bucket in response.get('Buckets', []):
#        print (bucket.get('Name'))
    buc=bucket()
    buc.show_bucket()
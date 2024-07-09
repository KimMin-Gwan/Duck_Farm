import requests
import time
import hmac
import hashlib
import base64

"""
# 변수 설정
access_key = 'eeJ2HV8gE5XTjmrBCi48'
secret_key = 'zAGUlUjXMup1aSpG6SudbNDzPEXHITNkEUDcOGnv'
timestamp = str(int(time.time() * 1000))
url = 'https://sts.apigw.ntruss.com/api/v1'
method = 'POST'
content_type = 'application/json; charset=utf-8'

# 서명 생성 함수
def make_signature(method, url, timestamp, access_key, secret_key):
    message = f"{method} {url}\n{timestamp}\n{access_key}"
    signing_key = base64.b64encode(hmac.new(secret_key.encode('utf-8'), message.encode('utf-8'), digestmod=hashlib.sha256).digest())
    return signing_key

# 헤더 설정
signature = make_signature(method, url, timestamp, access_key, secret_key)
headers = {
    'Content-Type': content_type,
    'x-ncp-apigw-timestamp': timestamp,
    'x-ncp-iam-access-key': access_key,
    'x-ncp-apigw-signature-v2': signature
}

# 요청 본문 (필요한 경우에 맞게 수정)
payload = {
}

# POST 요청 전송
response = requests.post(url, json=payload, headers=headers)

# 응답 출력
print(response.status_code)
print(response.json())
"""
"""

import boto3
def boto_upload(args):
    server_name = 's3'
    endpoint = 'https://kr.object.ncloudstorage.com'

    images = './test_images/1003.jpg'
    try:
        s3 = boto3.client(
            server_name,
            endpoint_url = endpoint,
            aws_access_key_id = args["access_key"],
            aws_secret_access_key = args["secret_key"]
        )
        s3.upload_file(f"{images}", args["bucket_name"], args["object_name"])

        return {"done"  : True}
    except Exception as e:
        return {"done":False, "error_message": e}

if __name__ == '__main__':
    args = {
        'access_key' : 'eeJ2HV8gE5XTjmrBCi48',
        'secret_key' : 'zAGUlUjXMup1aSpG6SudbNDzPEXHITNkEUDcOGnv',
        'bucket_name' : 'cheese-images',
        'object_name' : 'test_upload.jpg'
    }
    boto_upload(args)

"""
import requests
import hmac
import hashlib
import base64
from datetime import datetime

def get_signature_key(key, date_stamp, region_name, service_name):
    k_date = hmac.new(('AWS4' + key).encode('utf-8'), date_stamp.encode('utf-8'), hashlib.sha256).digest()
    k_region = hmac.new(k_date, region_name.encode('utf-8'), hashlib.sha256).digest()
    k_service = hmac.new(k_region, service_name.encode('utf-8'), hashlib.sha256).digest()
    k_signing = hmac.new(k_service, 'aws4_request'.encode('utf-8'), hashlib.sha256).digest()

    return k_signing

def boto_upload(args):
    images = './test_images/test.jpg'
    try:
        method = 'PUT'
        service = 's3'
        host = 'kr.object.ncloudstorage.com'
        region = 'kr-standard'
        endpoint = f"https://{host}/{args['bucket_name']}/{args['object_name']}"
        content_type = 'application/octet-stream'
        request_parameters = ''

        # Date/Time formatting for headers
        t = datetime.utcnow()
        amz_date = t.strftime('%Y%m%dT%H%M%SZ')
        date_stamp = t.strftime('%Y%m%d')

        # Create a canonical request
        canonical_uri = f"/{args['bucket_name']}/{args['object_name']}"
        canonical_querystring = request_parameters
        canonical_headers = f'host:{host}\n' + f'x-amz-content-sha256:UNSIGNED-PAYLOAD\n' + f'x-amz-date:{amz_date}\n'
        signed_headers = 'host;x-amz-content-sha256;x-amz-date'
        payload_hash = 'UNSIGNED-PAYLOAD'
        canonical_request = f"{method}\n{canonical_uri}\n{canonical_querystring}\n{canonical_headers}\n{signed_headers}\n{payload_hash}"

        # Create a string to sign
        algorithm = 'AWS4-HMAC-SHA256'
        credential_scope = f'{date_stamp}/{region}/{service}/aws4_request'
        print(credential_scope)
        string_to_sign = f"{algorithm}\n{amz_date}\n{credential_scope}\n{hashlib.sha256(canonical_request.encode('utf-8')).hexdigest()}"

        # Calculate the signature
        signing_key = get_signature_key(args['secret_key'], date_stamp, region, service)
        signature = hmac.new(signing_key, string_to_sign.encode('utf-8'), hashlib.sha256).hexdigest()
        

        # Create authorization header
        authorization_header = f"{algorithm} Credential={args['access_key']}/{credential_scope}, SignedHeaders={signed_headers}, Signature={signature}"
        headers = {
            'x-amz-date': amz_date,
            'x-amz-content-sha256': payload_hash,
            'Authorization': authorization_header,
            'Content-Type': content_type
        }

        print(headers)


        # Upload file using PUT method
        with open(images, 'rb') as file:
            response = requests.put(endpoint, data=file, headers=headers)
        
        if response.status_code == 200:
            return {"done": True}
        else:
            return {"done": False, "error_message": response.text}
    except Exception as e:
        return {"done": False, "error_message": str(e)}

if __name__ == '__main__':
    args = {
        'access_key': 'eeJ2HV8gE5XTjmrBCi48',
        'secret_key': 'zAGUlUjXMup1aSpG6SudbNDzPEXHITNkEUDcOGnv',
        'bucket_name': 'cheese-images',
        'object_name': '1001-25.jpg'
    }
    print(boto_upload(args))


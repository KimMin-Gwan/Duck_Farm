import base64
import json
import requests
import pprint
import cv2
import numpy as np

HOST = '127.0.0.1'
PORT = 5000

def send_data():
    url = f'http://{HOST}:{str(PORT)}/core_system/image_upload'

    iamges = []
    paths = ['./test1.png','./test2.png','./test3.png','./test4.png','./test5.png']
    for path in paths:
        with open(path, 'rb') as f:
            data = f.read()
        encoded_img = np.fromstring(data, dtype = np.uint8)
        img = cv2.imdecode(encoded_img, cv2.IMREAD_COLOR)
        iamges.append(img.tolist())


    header = {
        "request-type" : "default",
        "client-version" : 'v1.0.1',
        "client-ip" : '127.0.0.1',
        "uid" : '1234-abcd-5678', 
        "endpoint" : "/core_system/", 
    }

    send_data = {
        "header" : header,
        "body" : {
            'images' : iamges,
            'iid' : '',
            'iname' : '',
            'image_type' : 'jpg',
            'location' : '',
            'image_detail' : '실험용 이미지 입니다.',
            'upload_date' : '2024/07/21',
            'like' : '0',
            'sid' : '6',
            'bid' : '1003',
            'uid' : '1234-abcd-5678'
        }
    }
    
    headers = {
        'Content-Type': 'application/json'
    }
    send_data = json.dumps(send_data)
    send_data.encode()

    response = requests.post(url=url, data = send_data, headers=headers)
    response.encoding = 'utf-8'
    print(response)

    result = response.json()
    result = json.loads(result)
    pprint.pprint(result)



if __name__ == '__main__':
    send_data()

#temp_num -> fake_db.py get_num_list_with_id

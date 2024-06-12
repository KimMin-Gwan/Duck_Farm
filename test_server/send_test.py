import requests
import json

HOST = '192.168.55.213'
PORT = 5000

def send_data():
    url = f'http://{HOST}:{str(PORT)}/core_system/none_bias_home_data'
    #url = f'http://{HOST}:{str(PORT)}/core_system/image_detail'

    send_data = {
        "body" : {
            'uid' : '1234-abcd-5678',
            'date' : '2024/06/12'
        }
    }
    #send_data = {
        #'uid' : '1234-abcd-5678',
        #'iid' : '1001-1'
    #}
    headers = {
        'Content-Type': 'application/json'
    }
    send_data = json.dumps(send_data)
    send_data.encode()

    response = requests.post(url=url, data = send_data, headers=headers)
    response.encoding = 'utf-8'
    result:dict = response.json()
    print(result)



if __name__ == '__main__':
    send_data()

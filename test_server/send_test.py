import requests
import json
import pprint

HOST = '223.130.157.23'
PORT = 80
#HOST = '127.0.0.1'
#PORT = 5000

def send_data():
    #url = f'http://{HOST}:{str(PORT)}/bias_following/get_bias_following'
    url = f'http://{HOST}:{str(PORT)}/core_system/get_image_list_by_bias'
    #url = f'http://{HOST}:{str(PORT)}/core_system/none_bias_home_data'
    #url = f'http://{HOST}:{str(PORT)}/core_system/get_image_list_by_bias_n_schedule'
    #url = f'http://{HOST}:{str(PORT)}/core_system/upload_post'
    #url = f'http://{HOST}:{str(PORT)}/core_system/image_detail'

    header = {
        "request-type" : "default",
        "client-version" : 'v1.0.1',
        "client-ip" : '127.0.0.1',
        "uid" : '1234-abcd-5678', 
        "endpoint" : "/core_system/", 
    }

    #send_data = {
        #"header" : header,
        #"body" : {
            #'uid' : '1234-abcd-5678',
            #'bid' : '1001',
            #'sid' : '5'
        #}
    #}

    send_data = {
        "header" : header,
        "body" : {
            'uid' : '1234-abcd-5678',
            'bid' : '1001',
            'ordering' : 'like',
            'num_image' : '0'
        }
    }

    # send_data = {
    #     "header" : header,
    #     "body" : {
    #         'uid' : '1234-abcd-5678',
    #         'date' : '2024/05/26'
    #     }
    # }

    # send_data = {
    #     "header" : header,
    #     "body" : {
    #         'uid' : '1234-abcd-5678',
    #         'iid' : '1001-1'
    #     }
    # }

    #send_data = {
        #"body" : {
            #"uid" : "1234-abcd-5678",
            #"bname" : "쵸단",
            #"sname" : "QWER 메이크스타 팬싸인회",
            #"date" : "2024/05/19",
            #"detail" : "쵸단사진입니아요",
            #"link" : "",
            #"location" : "",
            #"num_images" : 3
            ##"image_filenames" : ["asdfava.jpg", "dafnavpa.jpg", "dalnfpas.jpg"]
        #}
    #}

    #send_data = {
        #'uid' : '1234-abcd-5678',
        #'bid' : '1001',
        #'sid' : '4'
    #}

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

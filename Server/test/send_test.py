import requests
import json
import pprint

#HOST = '223.130.157.23'
#PORT = 80
HOST = '127.0.0.1'
PORT = 5000

def send_data():
    #url = f'http://{HOST}:{str(PORT)}/core_system/get_bias_following'
    #url = f'http://{HOST}:{str(PORT)}/core_system/get_image_list_by_bias'
    #url = f'http://{HOST}:{str(PORT)}/core_system/search_images'
    #url = f'http://{HOST}:{str(PORT)}/core_system/try_follow_bias'

    #url = f'http://{HOST}:{str(PORT)}/core_system/none_bias_home_data'
    #url = f'http://{HOST}:{str(PORT)}/utility_system/search_schedule'
    #url = f'http://{HOST}:{str(PORT)}/utility_system/search_schedule'
    #url = f'http://{HOST}:{str(PORT)}/utility_system/search_bias'

    #url = f'http://{HOST}:{str(PORT)}/sign_system/try_sign_up'
    #url = f'http://{HOST}:{str(PORT)}/sign_system/try_login'
    #url = f'http://{HOST}:{str(PORT)}/sign_system/try_change_password'
    #url = f'http://{HOST}:{str(PORT)}/sign_system/try_send_email'
    url = f'http://{HOST}:{str(PORT)}/sign_system/try_check_email'

    #url = f'http://{HOST}:{str(PORT)}/core_system/bias_home_data'
    #url = f'http://{HOST}:{str(PORT)}/core_system/get_image_list_by_bias_n_schdule'
    #url = f'http://{HOST}:{str(PORT)}/core_system/upload_post'
    #url = f'http://{HOST}:{str(PORT)}/core_system/image_detail'
    #url = f'http://{HOST}:{str(PORT)}/utility_system/image_like_n_dislike'

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
        #}
    #}

    # send_data = {
    #     "header" : header,
    #     "body" : {
    #         'key_word' : '케이팝',
    #         'ordering' : 'latest',
    #         'num_image' : 0
    #     }
    # }

    send_data = {
        "header" : header,
        "body" : {
            'email' : 'testUser@naver.com',
            #'password' : 'password'
        }
    }
    #send_data = {
        #"header" : header,
        #"body" : {
            #'email' : 'testUser@naver.com',
            #'password' : 'password'
        #}
    #}

    #send_data = {
        #"header" : header,
        #"body" : {
            #'email' : 'test@gmail.com',
            #'password' : 'password',
            #'nickname' : 'test nickname',
            #'birthday' : '2000/03/20',
            #'uname' : '테스터'
        #}
    #}

    #send_data = {
        #"header" : header,
        #"body" : {
            #'uid' : '1234-abcd-5678',
            #'date' : '2024/05/26',
        #}
    #}

    #send_data = {
        #"header" : header,
        #"body" : {
            #'uid' : '1234-abcd-5678',
            #'bid' : '1001',
            #'ordering' : 'like',
            #'num_image' : '0'
        #}
    #}

    #send_data = {
        #"header" : header,
        #"body" : {
            #'uid' : "4321-abcd-5678",
            #'bid' : '1001',
        #}
    #}

    #send_data = {
        #"header" : header,
        #"body" : {
            #'uid' : '1234-abcd-5678',
            #'date' : '2024/05/26',
            #'bid' : '1001'
        #}
    #}

    #send_data = {
        #"header" : header,
        #"body" : {
            #'uid' : '1234-abcd-5678',
            #'iid' : '1001-1',
            #'like' : False
        #}
    #}



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

    # send_data = {
    #     "header" : header,
    #     'body' :{
    #         'uid' : '1234-abcd-5678',
    #         'bid' : '1003',
    #         'iid' : '1001-1'
    #     }
    # }

    #send_data = {
        #"header" : header,
        #'body' :{
            #'uid' : '1234-abcd-5678',
            #'bid' : '1001',
            #'sid' : '1',
            #'ordering' : 'like',
            #'num_image' : '0'
        #}
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

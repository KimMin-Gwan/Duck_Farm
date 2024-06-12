import requests
import json

'''
request_data = {
    'header' : {
        'reqeust-type' : 'client',
        'client-version' : 'v1.0.1',
        'client-ip' : '127.0.0.1',
        'uid' : '',
        'endpoint' : '/endpoint'
    },
    'body' : {}
}
'''

endpoint = '/core_system/home_page'
request_data = {
    'header' : {
        'reqeust-type' : 'client',
        'client-version' : 'v1.0.1',
        'client-ip' : '127.0.0.1',
        'uid' : '',
        'endpoint' : endpoint
    },
    'body' : {
        'uid' : '1234-abcd-5678',
        'bid' : '1001',
    }
}

request_data = json.dumps(request_data)
request_data = request_data.encode()

response = requests.post('http://127.0.0.1:5000'+endpoint, data=request_data)

print(response.json())




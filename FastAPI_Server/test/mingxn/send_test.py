import requests
import json

datas = {
    'name':"mingxn",
    'body':"hello, post"
}

json_data = json.dumps(datas)

#url = "http://127.0.0.1:5000/post_data"
url = "http://127.0.0.1:5000/post_dict"

response = requests.post(url, json=datas)
#result = response.content  # json data
result:dict = response.json() # dict data
print(result)


# 422 Error : data type error

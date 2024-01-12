import requests

datas = {
    'name':"mingxn",
    'body':"hello, post"
}

url = "http://127.0.0.1:5000/post_data"

response = requests.post(url, data=datas)
print(response)


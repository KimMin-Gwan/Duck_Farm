from fastapi import FastAPI
import uvicorn
import json
from pydantic import BaseModel

# app 객체 생성
app = FastAPI()

# get str_data
@app.get('/')
def welcome():
    return_data = 'Hello, World'
    return return_data

# get json_data
@app.get('/json_data')
def json_get():
    sample_data = {'head':'json_data', 'body':'hello world'}
    json_data = json.dumps(sample_data)
    return json_data

# data post using get method
@app.get('/str_get/{get_data}')
def str_get(get_data:str):
    sample_data = {'head':'json_data', 'body':get_data}
    json_data = json.dumps(sample_data)
    return json_data 

class Item(BaseModel):
    name: str
    body : str

# using post method with custom model
@app.post('/post_data')
def str_post(posted_data:Item):
    body_data = posted_data.body
    sample_data = {'head':'json_data', 'body':body_data}
    print(sample_data)
    json_data = json.dumps(sample_data)
    return json_data

# using post method with dict
@app.post('/post_dict')
def str_post(posted_data:dict):
    body_data = posted_data['body']
    sample_data = {'head':'json_data', 'body':body_data}
    print(sample_data)
    json_data = json.dumps(sample_data)
    return json_data

if __name__ == '__main__':
    print('Run Sample System')
    uvicorn.run(app=app, host='127.0.0.1', port=5000)
    
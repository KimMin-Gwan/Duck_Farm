from fastapi import FastAPI, File, UploadFile, HTTPException,Request,Form
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from starlette.responses import HTMLResponse
from fastapi.responses import FileResponse
from fastapi.templating import Jinja2Templates
import requests
from io import BytesIO
from PIL import Image
from NaverCloudSDK import *
from Database import *
from typing import List
app = FastAPI()
my_bucket=bucket()
#my_db =server_db()
# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
)



# 정적 파일 경로 설정
templates = Jinja2Templates(directory='templates')
#app.mount('/static', StaticFiles(directory='static'), name='static')



@app.get('/', response_class=HTMLResponse)
async def get_upload_form():
    file_path = 'static/upload_form.html'
    return FileResponse(file_path, media_type='text/html')


@app.get('/up', response_class=HTMLResponse)
async def start(request:Request):
    file_path = 'templates/find.html'
    return templates.TemplateResponse('find.html',context={'request':request})



@app.get('/up_2', response_class=HTMLResponse)
async def get_upload_form(request :Request):
    # cdn_urls=[
    #         f'kibxopaerykk22247051.cdn.ntruss.com/sample/1.jpg',
            
    #         f'kibxopaerykk22247051.cdn.ntruss.com/sample/2.jpg',

    #         f'kibxopaerykk22247051.cdn.ntruss.com/sample/3.jpg',
    #     ]
    cdn_urls='https://kibxopaerykk22247051.cdn.ntruss.com/sample/3.jpg',
    return templates.TemplateResponse('find.html' ,context={'request':request ,'search_result':cdn_urls})


@app.post('/upload/')
async def upload_images(files: List[UploadFile] = File(...)):
    try:
        for file in files:
            my_bucket.put_bucket(file.file)
            my_db.insert_imgpth('user_email_test','경로 test',1)
        return {'status': 'success', 'message': '이미지가 업로드되었습니다.'}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    

@app.post('/search/')
async def search_image(request:Request,query:str=Form(...)):
    print()
    try:
        cdn_urls=[
            'https://kibxopaerykk22247051.cdn.ntruss.com/sample/10.jpg',
            
            'https://kibxopaerykk22247051.cdn.ntruss.com/sample/11.jpg',

            'https://kibxopaerykk22247051.cdn.ntruss.com/sample/12.jpg',
        ]

        return templates.TemplateResponse('find.html' ,context={'request':request ,'search_result':cdn_urls})
    except Exception as e:
        return {'error':str(e)}
    
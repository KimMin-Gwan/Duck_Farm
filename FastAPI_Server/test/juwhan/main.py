from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from starlette.responses import HTMLResponse
from fastapi.responses import FileResponse
from NaverCloudSDK import *

app = FastAPI()
my_bucket=bucket()

# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 정적 파일 경로 설정
app.mount("/static", StaticFiles(directory="static"), name="static")

@app.get("/", response_class=HTMLResponse)
async def get_upload_form():
    file_path = "static/upload_form.html"
    return FileResponse(file_path, media_type="text/html")

@app.post("/upload/")
async def upload_images(files: list[UploadFile] = File(...)):
    try:
        for file in files:
            my_bucket.put_bucket(file.file)
            # with open(f"static/{file.filename}", "wb") as f:
            #     f.write(contents)
        return {"status": "success", "message": "이미지가 업로드되었습니다."}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

        

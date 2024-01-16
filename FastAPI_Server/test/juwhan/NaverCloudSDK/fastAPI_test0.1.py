from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import FileResponse

app = FastAPI()

# NCOS 설정
ncos_access_key = "3dImIAwFR7HUbEGTmdKl"
ncos_secret_key = "amiKrweWVCFuNFxFmAmDufzkOA8U6PfnjQrWaBy5"
api_server= "https://kr.object.ncloudstorage.com"
ncos_region = "kr-standard"
ncos_bucket_name = "test0.1"

ncos_client = NcloudStorageClient(access_key=ncos_access_key, secret_key=ncos_secret_key, region=ncos_region)

# CDN 엔드포인트 설정
cdn_base_url = "YOUR_CDN_BASE_URL"

@app.post("/upload/image/")
async def upload_image(file: UploadFile = File(...)):
    try:
        # 이미지를 NCOS에 업로드
        ncos_object_key = f"images/{file.filename}"
        with ncos_client.open_bucket(ncos_bucket_name).open(ncos_object_key, "wb") as f:
            f.write(file.file.read())

        # CDN 엔드포인트를 사용하여 이미지 URL 생성
        cdn_image_url = f"{cdn_base_url}/{ncos_object_key}"

        return {"message": "Image uploaded successfully", "cdn_image_url": cdn_image_url}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to upload image: {str(e)}")

@app.get("/image/{object_key}")
async def get_image(object_key: str):
    try:
        # CDN 엔드포인트를 사용하여 이미지 제공
        return FileResponse(f"{cdn_base_url}/{object_key}")
    except Exception as e:
        raise HTTPException(status_code=404, detail=f"Image not found: {str(e)}")

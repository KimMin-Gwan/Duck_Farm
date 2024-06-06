
# 이미지 데이터를 생성하고 디비에 저장함
class Image_Model:
    def __init__(self, databasss) -> None:
        self.__databass = databasss
        self.__image = None

    """
    1. 이미지 아이디 만들기
    1.1 db한테 bias앞으로 된 사진 갯수 받아오니
    1.2 사진 이름을 bias + - + 사진 갯수 + n  으로 반복문 
    1.3 db한테 bias 앞으로 된 사진 갯수 n만큼 추가

    2. 메타정보 만들기
    2.1 Image 데이터 생성
    2.2 ㅇ위에서 생성한 iid 매칭
    2.3 db에 저장

    3. iid 리턴
    """
    # 이미지 데이터 생성함수

    def make_image_data(self, request):
        iids = []
        db_image_num = self.__databass.get_bias_image_num_with_bid(request['bid'])
        upload_image_num = len(request['image_filenames'])

        for n in range (upload_image_num):
            iid = request['bid'] + "-" + str(db_image_num + n)
            iids.append(iid)

        self.__databass.add_bias_image_num(upload_image_num)


        self.__image = Image(request)
        self.__image.set_iid(iids)
        self.__databass.save_new_image_data(self.__image)

        return iids
    
    
    def get_iid(self):
        return self.__iid
        
    def get_iname(self):
        return self.__iname
    
    def get_bid(self):
        return self.__bid
    
    def get_image_type(self):
        return self.__image_type
    
    def get_uid(self):
        return self.__uid
    
    def get_image_info(self):
        return self.__image_info
    
    def get_location(self):
        return self.__location
    
    def get_uploadedDate(self):
        return self.__uploadedDate
    
    def get_scheduleDate(self):
        return self.__scheduleDate

    def get_scheduleName(self):
        return self.__scheduleName
    
    def set_iid(self, iid):
        self._iid = iid
        return

    def set_iname(self, iname):
        self._iname = iname
        return
    
    def set_bid(self, bid):
        self.__bid = bid
        return
    
    def set_image_type(self, image_type):
        self.__image_type = image_type
        return 

    def set_uid(self, uid):
        self.__uid = uid
        return 
    
    def set_image_info(self, image_info):
        self.__image_info = image_info
        return 

    def set_location(self, location):
        self.__location = location
        return 

    def set_uploadedDate(self, uploadedDate):
        self.__uploadedDate = uploadedDate
        return 

    def set_scheduleDate(self, scheduleDate):
        self.__scheduleDate = scheduleDate
        return 
    
    def set_scheduleName(self, scheduleName):
        self.__scheduleName = scheduleName
        return 
    
# 이미지 객체를 생성하고 id설정함
class Image:
    def __init__(self) -> None:
        self.__iid = []

        pass

    def set_iid(self, iids):
        self.__iid = iids
        return 



    
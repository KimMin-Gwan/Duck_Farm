from model.schedule_data import Schedule

class Image_Model:
    def __init__(self, database) -> None:
        self.__database = database
        self.__image = None
        self.__schedule = None

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

    def make_image_data(self, request):
        iids = []
        db_image_num = self.__database.get_bias_image_num_with_bid(request['bid'])
        upload_image_num = len(request['image_filenames'])

        for n in range (upload_image_num):
            iid = request['bid'] + "-" + str(db_image_num + n)
            iids.append(iid)

        self.__database.add_bias_image_num(upload_image_num)

        self.__image = Image(request)
        self.__image.set_iid(iids)
        self.__database.save_new_image_data(self.__image)

        return iids
    
    #이게 맞나?
    #shecdule에 연관된 image 데이터 받아오기
    def make_image_data_with_schedule(self,schedule): 
        
        images=[]
        for iid in schedule.get_iid():
            image_data = self.__database.get_image_data_with_iid(iid)
            image = Image(image_data)
            images.append(image)

        self.__schedule = schedule

        result = images

        return result

    #iid로 이미지 데이터 받아오기 + 이미지를 포함하고 있는 스케쥴 정보 받아오기 (객체에 저장됨)
    def make_image_data_with_iid(self,iid) -> None:
        image_data = self.__database.get_image_data_with_iid(iid)
        self.__image = Image(image_data)

        schedule_data = self.__database.get_schedule_data_with_sid(self.__image.get_sid())
        self.__schedule = Schedule(schedule_data)
        return
    
    #home_page에서 전송할 body 정보
    def get_home_body_image_list(self):
        image_data={ 
            'scheduleName':self.__image.get_schedule_name(),
            'type':self.__image.get_image_type(), 
            'image_url':f'/{self.__image.get_iid()}.{self.__image.get_image_type()}'
        }
        return image_data
    
    #이미지 상세 정보 전달
    def get_detail_image_data(self):
        image_data = { 
            'bias_name':'',
            'user_name':'',
            'user_owner':False,
            'iid': self.__image.get_iid(),
            'upload_date':self.__image.get_uploaded_date(),
            'schedule': {
                'date': self.__schedule.get_date(),
                'name': self.__schedule.get_name(),
                'location': self.__schedule.get_location()
            }
        }

        return image_data
    
    def get_image(self):
        return self.__image
    def get_schedule(self):
        return self.__schedule
    
    def set_image(self,image):
        self.__image=image
    def set_schedule(self,schedule):
        self.__schedule=schedule


class Image:
    def __init__(self,image_data:dict) -> None:
        self.__iid = image_data['iid']
        self.__iname = image_data['iname']
        self.__bid = image_data['bid']
        self.__image_type = image_data['image_type']
        self.__uid = image_data['uid']
        self.__image_info = image_data['image_info']
        self.__location = image_data['location']
        self.__uploaded_date = image_data['uploaded_date']
        self.__schedule_date = image_data['schedule_date']
        self.__schedule_name = image_data['schedule_name']

        self.__sid = image_data['sid']
        pass

    def set_iid(self, iids):
        self.__iid = iids
        return 

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
    
    def get_uploaded_date(self):
        return self.__uploaded_date
    
    def get_schedule_date(self):
        return self.__schedule_date

    def get_schedule_name(self):
        return self.__schedule_name
    
    def get_sid(self):
        return self.__sid
    
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

    def set_uploaded_date(self, uploaded_date):
        self.__uploaded_date = uploaded_date
        return 

    def set_schedule_date(self, schedule_date):
        self.__schedule_date = schedule_date
        return 
    
    def set_schedule_name(self, schedule_name):
        self.__schedule_name = schedule_name
        return 
    
    def set_sid(self,sid):
        self.__sid=sid
        return

    
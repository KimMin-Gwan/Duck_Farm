

class Image_Model:
    def __init__(self, database) -> None:
        self.__database = database
        self.__images = None
        self.__schedules = None

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


    def get_bias_image_data(self, bid):
        #bid = "0000" # 디폴트
        #loop
        """    
        bias = Bias(bid)
        bias_data = bias.get_bias_data()

        schedule = Schedule()
        ##for _ in bias_data.get.sid() : schedule_data = schedule.get_schedule_data #
        #schedule_data = schedule.get_schedule_data()
        ##schedule_data #schedule_list  #list 안에 iid_list 
        #image_lsit=db.get_image_by_sid(schedule.get_sid()) #전부 다 찾을 때 까지 반복

        #result == schedule_data + image_list
        """
        result = self.__database.find_image_with_bid(bid) #bid로 iid찾기 근데 이거 쓰는 함수인가?

        return result
    
    def make_image_data_with_schedule(self,sid): #####
        '''
        images=[]
        for iid in shecdule.get_iid()
            image_data = database.get_image_data_with_iid(iid)
            image = Image(image_data)
            this.images.append(image)

        this.schedule = schedule
        '''
        result =[]
        iids = self.__database.get_iid_with_sid(sid) #select iid from ImageSchedule where sid=sid  / sid로 iid를 찾아서 list로 반환
        for iid in iids:
            image_data = self.__database.get_image_data_with_iid(iid)  # iid로 image 데이터 가져오기 slect * 
            result.append(Image(image_data))

        return result

    def make_image_data_with_iid(self,iid) -> None:
        image_data = self.__database.get_image_data_with_iid(iid)
        self.__images = Image(image_data)

        schedule_data = self.__database.get_schedule_data_with_sid(image.get_sid()) ##
        self.__schedules = Schedule(schedule_data)##########################
        return
    
        def get_home_body_image_list(self):
        image_data={ 
            'scheduleName':self.__images.get_schedule_name(),
            'type':self.__images.get_image_type(), 
            #'image_url':self.__images.get_image_url()   #image url 없음
            'image_url':['/1234.png']
        }
        return image_data
    
    def get_detail_image_data(self,data):
        image_data = { 
            'iid': self.__images.get_iid(),
            'upload_date':self.__images.get_uploaded_date(),
            'schedule': {
                'date': self.__schedules.get_date(),
                'name': self.__schedules.get_name,
                'location': self.__schedules.get_location
            }
        }

        return image_data


class Image:
    def __init__(self,image_data:dict) -> None:
        self.__iid = image_data['iid']
        self.__iname = image_data['iname']
        self.__bid = image_data['bid']
        self.__iamge_type = image_data['image_type']
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

    
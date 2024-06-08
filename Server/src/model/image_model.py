

class Image_Model:
    def __init__(self, database) -> None:
        self.__database = database
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
        result = self.__database.find_image_with_bid(bid)

        return result
    
    def get_image_by_schedule(self,sid): #####
        bias=Bias(bid)
            #bias_model에 schedule class
        return




class Image:
    def __init__(self) -> None:
        self.__iid = ''
        self.__iname=''
        self.__bid=''
        self.__iamge_type=''
        self.__uid=''
        self.__image_info=''
        self.__location=''
        self.__uploadedDate=''
        self.__scheduleDate=''
        self.__scheduleName=''
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

    
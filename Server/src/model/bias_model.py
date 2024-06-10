from datetime import datetime

class Bias_Model:
    def __init__(self, database) -> None:
        self.__database = database 
        self.__bias = None
        self.__schedules = None


    # 받아온 bid 리스트에서 가장 최근에 업데이트된 bid를 반환
    def get_latest_uploaded_bias(self, bids:list, month):
        date_times = []
        for bid in bids:
            date_time = self.__database.get_lates_image_date_time(bid)      #db에 저장된 가장 최근 date를 bid로 가져ㅑ옴
            date_time = datetime.strptime(date_time)
            date_times.append(date_time)

        latest_index = max(date_times)

        return bids[latest_index]

    def make_schedule_list(self,bid) -> None:
        result = []
        '''
        bias_data = self.__database.get_bid_data(bid)
        this.bias = Bias(bias_data)
        '''
        sids = self.__database.get_sid_with_bid(bid) #select sid from BiasSchedule where bid=bid  db에서 받은 sid를 list로 변환하여 받음

        for sid in sids():
            schedule_data = self.__database.get_schedule_with_sid(sid) #sid로 schedule의 모든 데이터를 받아옴 slect *
            result.append(Schedule(schedule_data))

        return

    def get_schedules(self):
        return self.__schedules

    def make_bias_data_with_bid(self,bid) -> None:
        bias_data = self.__database.get_bias_Data_with_bid(bid)
        bias = Bias(bias_data)
        return
    
    def get_image_by_date(self):
        image_by_date={
            'date':self.__schedules.get_date(),
            'bias':self.__schedules.get_bid(),
        }
        return image_by_date
    
    
class Bias:
    def __init__(self,bias_data:dict) -> None:
            self.__bid = bias_data['bid']
            self.__sid = bias_data['sid'] 
            self.__name = bias_data['name']
    
    def get_bid(self):
        return self.__bid
    def get_sid(self):
        return self.__sid
    def get_name(self):
        return self.__name

    def set_bid(self,bid):
        self.__bid=bid
    def set_sid(self,sid):
        self.__sid=sid
    def set_name(self,name):
        self.__name=name

class Schedule: 
    def __init__(self,schedule_data:dict) -> None:
            self.__sid = schedule_data['sid']
            self.__bid = schedule_data['bid']
            self.__date = schedule_data['date']
            self.__name = schedule_data['name']
            self.__location = schedule_data['location']
    
    def get_sid(self):
        return self.__sid
    def get_bid(self):
        return self.__bid
    def get_date(self):
        return self.__date
    def get_name(self):
        return self.__name
    def get_location(self):
        return self.__location

    def set_sid(self, sid):
        self.__sid = sid
    def set_bid(self, bid):
        self.__bid = bid
    def set_date(self, date):
        self.__date = date
    def set_name(self, name):
        self.__name = name
    def set_location(self, location):
        self.__location = location
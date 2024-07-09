from datetime import datetime
#from model.schedule_data import Schedule

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

    #bid로 bias정보를 받아 저장된 sid들을 통해 모든 스케쥴 데이터를 불러옴
    def make_schedule_list(self,bid) -> None:

        bias_data = self.__database.get_bias_data_with_bid(bid)
        self.__bias = Bias(bias_data)

        for sid in self.__bias().get_sid():
            schedule_data = self.__database.get_schedule_with_sid(sid) #sid로 schedule의 모든 데이터를 받아옴 slect *
            self.__schedules.append(Schedule(schedule_data))

        return

    #bid로 bais 데이터 받아오기 (객체에 저장됨)
    def make_bias_data_with_bid(self,bid) -> None:
        bias_data = self.__database.get_bias_Data_with_bid(bid)
        self.__bias = Bias(bias_data)
        return
    
    # 스케줄 날짜들을 뽑아냄 
    def get_image_by_date(self):
        date_list = []
        for schedule in self.__schedules:
            image_by_date={
                'date':schedule.get_date(),
                'bias':self.__bias.get_bid()
            }
            date_list.append(image_by_date)

        return date_list
    
    def get_bias(self):
        return self.__bias 
    def get_schedules(self):
        return self.__schedules
    
    def set_bias(self,bias):
        self.__bias = bias
    def set_schedules(self,schedules):
        self.__schedules=schedules
    
    
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

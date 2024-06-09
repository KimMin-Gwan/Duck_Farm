from datetime import datetime

class Bias_Model:
    def __init__(self, database) -> None:
        self.__database = database


    # 받아온 bid 리스트에서 가장 최근에 업데이트된 bid를 반환
    def get_latest_uploaded_bias(self, bids:list, month):
        date_times = []
        for bid in bids:
            date_time = self.__database.get_lates_image_date_time(bid)
            date_time = datetime.strptime(date_time)
            date_times.append(date_time)

        latest_index = max(date_times)

        return bids[latest_index]

    def make_schedule_list(self,bid):
        result = []
        '''
        bias_data = self.__database.get_bid_data(bid)
        this.bias = Bias(bias_data)
        '''
        sids = self.__database.get_sid_with_bid(bid) #select sid from BiasSchedule where bid=bid

        for sid in sids():
            schedule_data = database.get_schedule_with_sid(sid)
            result.append(Schedule(schedule_data))

        return result

class Bias:
    def __init__(self,bid,sid,name) -> None:
            self.__bid = bid
            self.__sid = sid 
            self.__name = name
    
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
    def __init__(self,sid,bid,date,name,location) -> None:
            self.__sid = sid
            self.__bid = bid
            self.__date = date
            self.__name = name
            self.__location = location
    
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

    def set_sid(self):
        self.__sid = sid
    def set_bid(self):
        self.__bid = sid
    def set_date(self):
        self.__date = sid
    def set_name(self):
        self.__name = sid
    def set_location(self):
        self.__location = location
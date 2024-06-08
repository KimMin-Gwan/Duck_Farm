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

    def make_schedule_list(self,bid):#####
        bias_data=db.get_bias_data(bid)
        bias=Bias(bias_data)
        schedule=db.get_schedule_with_bid(bid)

class Bias: #####
    def __init__(self,bid) -> None:
            self.__bid=bid
            self.__sid=[''] #bias의 모든 schedule id?
            self.__name=''
    
    def get_bid(self):
        return self.__bid
    def get_name(self):
        return self.__name
    def set_bid(self,bid):
        self.__bid=bid
    def set_name(self,name):
        self.__name=name

    def get_bias_data(self):####
        bias_data = db.get_bias_data(self.__bid)

        return bias_data


class Schedule: #####
    def __init__(self,sid) -> None:
            self.__bid=''
            self.__sid=sid
            self.__date=''
            self.__name=''
            self.__tpye=''
    
    def get_schedule_data(self):
        #for i in db.get_schedule_data(self.__sid): schedule_data=i  ??
        schedule_data=db.get_schedule_data(self.__sid)

        return schedule_data
    


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
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



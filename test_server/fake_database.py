import json

class Local_Database:
    def __init__(self) -> None:
        self.__db_file_path = './fake_data/'
        self.__data_files = {
            'user_file' : 'user.json',
            'image_file' : 'image.json',
            'bias_file' : 'bias.json',
            'schedule_file' : 'schedule.json',
        }
        self.__read_json()

    def __read_json(self):
        self.__user_data = []
        self.__image_data = []
        self.__bias_data = []
        self.__schedule_data = []

        data_list = [self.__user_data, self.__image_data, self.__bias_data, self.__schedule_data]

        for file_name, list_data in zip(self.__data_files.values(), data_list):
            with open(self.__db_file_path+file_name, 'r',  encoding='utf-8' )as f:
                list_data.extend(json.load(f))

    def __save_json(self, file_name, data):
        path = self.__db_file_path
        with open(path+file_name, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=4)
        return
    
    # 저장하기
    def __save_user_json(self):
        file_name = self.__data_files['user_file']
        self.__save_json(file_name, self.__user_data)
        return

    # 저장하기
    def __save_image_json(self):
        file_name = self.__data_files['image_file']
        self.__save_json(file_name, self.__image_data)
        return

    # 저장하기
    def __save_bias_json(self):
        file_name = self.__data_files['bias_file']
        self.__save_json(file_name, self.__image_data)
        return

    # 저장하기
    def __save_schedule_json(self):
        file_name = self.__data_files['schedule_file']
        self.__save_json(file_name, self.__image_data)
        return
    
    # uid로 유저 찾기 -> 찾환 데이터 반환 없으면 None 반환
    def get_user_data_with_uid(self, uid:str):
        find_user = None
        for user in self.__user_data:
            if user['uid'] == uid:
                find_user = user

        return find_user

    def get_bias_data_with_bid(self, bid):
        find_bias = None
        for bias in self.__bias_data:
            if bid == bias['bid']:
                find_bias = bias

        return find_bias

    def get_schedule_data_with_sid(self, sid):
        find_schedule = None
        for schedule in self.__schedule_data:
            if sid == schedule['sid']:
                find_schedule = schedule
        return find_schedule

    def get_image_data_with_iid(self, iid):
        find_image = None
        for image in self.__image_data:
            if iid == image['iid']:
                find_image = image
        return find_image
    
    def get_image_datas_with_bid(self, bid):
        find_image = []
        for image in self.__image_data:
            if bid == image['bid']:
                find_image.append(image)

        return find_image





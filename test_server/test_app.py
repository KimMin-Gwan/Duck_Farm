from fastapi import FastAPI
import uvicorn
from fake_database import Local_Database
from datetime import datetime
import json
import pprint

#HOST = '192.168.55.213'
HOST = '127.0.0.1'
PORT = 5000

class Controller:
    def __init__(self) -> None:
        self.__response = {
            'state-code' : '201',
            'body' : '',
        }

    def get_bias_data(self, database:Local_Database, requset:dict):
        self.__response = {
            'state-code' : '201',
            'body' : '',
        }

        bias_data = database.get_bias_data_with_bid(requset['bid'])

        if bias_data:
            self.__response['state-code'] = '200'
            self.__response['body'] = bias_data
        response = json.dumps(self.__response, ensure_ascii=False)
        response = response.encode()
        return response
    

    def get_none_bias_home_data(self, database:Local_Database, requset:dict):
        body = {
            'bias' : [],
            'calender_data' : [],
            'home_body_data' : []
        }
        '''
        a_bias = {
            'bid' : '',
            'bname' : '',
        }
        '''
        user_data = database.get_user_data_with_uid(requset['uid'])

        bids = user_data['bids']
        biases = []

        for bid in bids:
            bias_data = database.get_bias_data_with_bid(bid)
            biases.append(bias_data)

        body_bias = []
        for bias in biases:
            a_bias = {
                'bid' : bias['bid'],
                'bname' : bias['bname']
            }
            body_bias.append(a_bias)

        body['bias'] = body_bias

        '''
            a_calender_data = {
                'date' : '24/04/01',
                'bias' : '1001'
            }
        '''

        schedules = []
        calender_data = []

        for bias in biases:
            for sid in bias['sids']:
                schdeules_data = database.get_schedule_data_with_sid(sid)
                schedules.append(schdeules_data)
                a_calender_data = {
                    'date' : schdeules_data['date'],
                    'bias' : bias['bid']
                }
                calender_data.append(a_calender_data)

        body['calender_data'] = calender_data

        '''
        a_home_body_data = {
            'bname' : '',
            'bid' : '',
            'schedule_data' : []
        }
        a_schedule_data = {
            'scheduleName' : '',
            'type' : 'online',
            'image_url' : []
        }
        a_image_url = '/1001-01.jpg'
        '''
        
        date_format = '%Y/%m/%d'
        target_date = datetime.strptime(requset['date'], date_format)
        schedule_data = []

        pprint.pprint(schedules)

        temp_dict = {}
        for bias in biases:
            temp_dict[bias['bid']] = []

        for schedule in schedules:
            compare_time = datetime.strptime(schedule['date'], date_format)
            if target_date == compare_time:
                image_url = []
                for iid in schedule['iids']:
                    a_image_url = iid + '.jpg'
                    image_url.append(a_image_url)
                #print("schdedule : ", schedule)
                a_schedule_data = {
                    'sid' : schedule['sid'],
                    'schedule_name' : schedule['sname'],
                    'type' : schedule['type'],
                    'image_url' : image_url
                }
                temp_dict[schedule['bid']].append(a_schedule_data)


        home_body_data = []
        for bid, schdeule_data_list in temp_dict.items():
            if len(schdeule_data_list) == 0:
                continue
            for bias in biases:
                if bias['bid'] == bid:
                    bname = bias['bname']

            a_home_body_data = {
                'bname' : bname,
                'bid' : bid,
                'schedule_data' : schdeule_data_list
            }

            home_body_data.append(a_home_body_data)

        body['home_body_data'] = home_body_data

        form = {
            'header' : {
                'state-code' : '200',
            },
            'body' : body
        }
        response = json.dumps(form, ensure_ascii=False)
        #response = response.encode()
        return response

    def get_image_detail(self, database:Local_Database, request:dict):
        form = {
            'header':{
                'state-code' : '201'
            }
        }
        '''
        body = {
            'iid' :'',
            'bias_name' : '',
            'user_owner' : True,
            'upload_date' : '2024/04/01',
            'schedule' : {
                'date' : '2024/03/29',
                'name' : '',
                'location' : ''
            }
        }
        '''
        
        image_data = database.get_image_data_with_iid(iid=request['iid'])
        bias_data = database.get_bias_data_with_bid(bid=image_data['bid'])
        schedule_data = database.get_schedule_data_with_sid(sid=image_data['sid'])

        user_owner = False

        if image_data['uid'] == request['uid']:
            user_owner = True

        body = {
            'iid' : image_data['iid'],
            'bias_name' : bias_data['bname'],
            'user_name' : "테스트 업로더",
            'user_owner' : user_owner,
            'upload_date' : image_data['upload_date'],
            'image_detail' : image_data['image_detail'],
            'schedule' : {
                'date' : schedule_data['date'],
                'name' : schedule_data['sname'],
                'location' : schedule_data['location']
            }
        }

        form['header']['state-code'] = '200'
        form['body']= body
        response = json.dumps(form, ensure_ascii=False)
        response = response.encode()
        return response
    

    def get_image_list_by_bias(self, database:Local_Database, request):
        form = {
            'header':{
                'state-code' : '201'
            }
        }

        body = {
            "bid" : "",
            "bname" : "",
            "num_image" : 0,
            "first_list" : [],
            "second_list" : [],
            "third_list" : []
        }

        bias_data = database.get_bias_data_with_bid(bid = request['bid'])
        image_data = database.get_image_datas_with_bid(bid = request['bid'])

        num_image = len(image_data)
        first_list = []
        second_list = []
        third_list = []
        
        for i, item in enumerate(image_data):
            if i % 3 == 0:
                first_list.append(item)
            elif i % 3 == 1:
                second_list.append(item)
            else:
                third_list.append(item)

        body['bid'] = bias_data['bid']
        body['bname'] = bias_data['bname']
        body['num_image'] = num_image
        body['first_list'] = first_list
        body['second_list'] = second_list
        body['third_list'] = third_list

        form['header']['state-code'] = '200'
        form['body']= body
        response = json.dumps(form, ensure_ascii=False)
        response = response.encode()
        return response
    
    def get_bias_following(self, database:Local_Database, request):
        form = {
            'header':{
                'state-code' : '201'
            }
        }

        body = {
            "bias_list" : [],
            "bias_order" : []
        }

        user_data = database.get_user_data_with_uid(request['uid'])

        bias_list = []
        
        for bid in user_data['bids']:
            bias_data = database.get_bias_data_with_bid(bid)
            bias_list.append(bias_data)

        body['bias_list'] = bias_list
        body['bias_order'] = user_data['bids']

        form['header']['state-code'] = '200'
        form['body']= body
        response = json.dumps(form, ensure_ascii=False)
        response = response.encode()

        return response 



class ImageListModel:
    def __init__(self, database:Local_Database) -> None:
        self.__database  = database
        self.__user = None
        self.__biases = []
        self.__images = []
    

class BiasFollowingController:
    def __init__(self) -> None:
        self.__response = {
            'state-code' : '201',
            'body' : '',
        }
        return
    



class ImageListByBiasRequest:
    def __init__(self, raw_request):
        self.uid = raw_request['uid']
        self.bid = raw_request['bid']
        self.ordier = raw_request['ordering'] 



class View:
    def __init__(self):
        self.__app = FastAPI()
        self.__database = Local_Database()
        self.routes()


    def routes(self):
        @self.__app.get('/')
        def home():
            return 'hello wolrd'
        
        @self.__app.post('/test_data')
        def test_data(request:dict):
            controller = Controller()
            response = controller.get_bias_data(self.__database, request)
            return response

        @self.__app.post('/core_system/none_bias_home_data')
        def get_none_bias_home_data(request:dict):
            print(request)
            controller = Controller()
            response = controller.get_none_bias_home_data(self.__database, request['body'])
            return response

        @self.__app.post('/core_system/image_detail')
        def get_image_detail(request:dict):
            controller = Controller()
            response = controller.get_image_detail(self.__database, request['body'])
            return response

        @self.__app.post('/core_system/get_image_list_by_bias')
        def getImageListByBias(request:dict):
            #request = ImageListByBiasRequest(raw_request=request)
            controller = Controller()
            response = controller.get_image_list_by_bias(self.__database, request['body'])
            return response

        @self.__app.post('/bias_following/get_bias_following')
        def getBiasFollowing(request:dict):
            #request = ImageListByBiasRequest(raw_request=request)
            print(request)
            controller = Controller()
            response = controller.get_bias_following(self.__database, request['body'])
            return response
        




    def run_server(self):
        uvicorn.run(app=self.__app, host=HOST, port=PORT)


if __name__ == '__main__':
    view = View()
    view.run_server()









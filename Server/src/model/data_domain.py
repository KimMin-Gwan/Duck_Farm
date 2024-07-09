from others import DictMakingError

# 추상 클래스
class SampleDomain:
    def get_dict_form_data(self):
        pass

    def make_with_dict(self, dict_data):
        pass

class User(SampleDomain):
    def __init__(self, uid = "", uname = "", password = "",
                 birthday = "", email = "", nickname = ""):
        self.uid = uid
        self.uname = uname
        self.password = password
        self.birthday = birthday
        self.email = email
        self.nickname = nickname
        self.bids = []
        return

    # database로 부터 받아온 데이터를 사용해 내용 구성
    def make_with_dict(self, dict_data):
        try:
            self.uid = dict_data['uid']
            self.uname = dict_data['uname']
            self.password = dict_data['password']
            self.birthday = dict_data['birthday']
            self.email= dict_data['email']
            self.nickname = dict_data['nickname']
            self.bids = dict_data['bids']
            return
        except:
            raise DictMakingError()
    
    # response에 사용되는 json형태로 만들기 위한 dict 데이터
    def get_dict_form_data(self):
        return {
            "uid" : self.uid,
            "uname" : self.uname,
            "password" : self.password,
            "birthday" : self.birthday,
            "email" : self.email,
            "nickname" : self.nickname,
            "bids" : self.bids
        }

class Bias(SampleDomain):
    def __init__(self, bid = "", bname = ""):
        self.bid = bid
        self.bname = bname
        self.sids = []
        self.iids = []

    # database로 부터 받아온 데이터를 사용해 내용 구성
    def make_with_dict(self, dict_data):
        try:
            self.bid = dict_data['bid']
            self.bname = dict_data['bname']
            self.sids = dict_data['sids']
            self.iids = dict_data['iids']
            return
        except:
            raise DictMakingError()
    
    # response에 사용되는 json형태로 만들기 위한 dict 데이터
    def get_dict_form_data(self):
        return{
            "bid" : self.bid,
            "bname" : self.bname,
            "sids" : self.sids,
            "iids" : self.iids
        }


class Schedule:
    def __init__(self, sid = "", sname = "", date = "", 
                 location = "", type = "", bids = [], iids = []):
        self.sid = sid
        self.sname = sname
        self.date = date
        self.location = location
        self.type = type
        self.bids = bids
        self.iids = iids
        pass

    # database로 부터 받아온 데이터를 사용해 내용 구성
    def make_with_dict(self, dict_data):
        try:
            self.sid = dict_data['sid'] 
            self.sname = dict_data['sname'] 
            self.date = dict_data['date'] 
            self.location = dict_data['location']
            self.type = dict_data['type'] 
            self.bids = dict_data['bids'] 
            self.iids = dict_data['iids']
        except:
            raise DictMakingError()

    # response에 사용되는 json형태로 만들기 위한 dict 데이터
    def get_dict_form_data(self):
        return {
            "sid" : self.sid,
            "sname" : self.sname,
            "date" : self.date,
            "location" : self.location,
            "type" : self.type,
            "bids" : self.bids,
            "iids" : self.iids
        }


class Image:
    def __init__(self, iid ="", iname = "", image_type = ".jpg", location = "",
                 image_detail = "", upload_date = "", sid = "", bid = "",
                 uid = ""):
        self.iid = iid
        self.iname = iname
        self.image_type = image_type
        self.location = location
        self.image_detail = image_detail
        self.upload_date = upload_date
        self.sid = sid
        self.bid = bid
        self.uid = uid

    # database로 부터 받아온 데이터를 사용해 내용 구성
    def make_with_dict(self, dict_data):
        try:
            self.iid = dict_data['iid']
            #self.iname = dict_data['iname']
            self.image_type = dict_data['image_type']
            self.image_detail = dict_data['image_detail']
            self.upload_date = dict_data['upload_date']
            self.location = dict_data['location']
            self.sid = dict_data['sid']
            self.bid = dict_data['bid']
            self.uid = dict_data['uid']
        except:
            raise DictMakingError()
        
    # response에 사용되는 json형태로 만들기 위한 dict 데이터
    def get_dict_form_data(self):
        return {
            "iid" : self.iid,
            "iname" : self.iname,
            "image_detail" : self.image_detail,
            "image_type" : self.image_type,
            "upload_date" : self.upload_date,
            "location" : self.location,
            "sid" : self.sid,
            "bid" : self.bid,
            "uid" : self.uid
        }


class User:
    def __init__(self) -> None:
        self.uid
        self.sex
        self.email
        self.password
        self.birthday
        self.nickname
    
    def set_user_data(self,uid,data):
        pass

class Profile:
    def __init__(self,user):
        self.user=user
    
    
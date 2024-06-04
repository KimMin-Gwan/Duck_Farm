import User
import Database
import Local_Data
class Master:
    def __init__(self) -> None:
        self.db=Database.Database()
        self.local_data=Local_Data.Local()

    def get_user_model(self):
        return User.User_Model()

    def get_master_model():  #정확한 사용 범위
        return Master()
    def get_local_data(self):
        return self.local_data

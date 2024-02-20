import sample
class Master:
    def __init__(self) -> None:
        self.db=sample.Database()
        self.local_data=sample.Local()

    def get_user_model(self):
        return sample.User.User_Model()

    def get_master_model():  #정확한 사용 범위
        return Master()
    def get_local_data(self):
        return self.local_data
    


if __name__=="__main__":
    master=Master()

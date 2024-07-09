from model.header_data_model import HeaderModel
from model.fake_database import Local_Database
from model.data_domain import User

class SampleModelTypeOne(HeaderModel):
    def __init__(self, database) -> None:
        self._database:Local_Database = database
        self._user = User()
        super().__init__()

    def get_user_with_uid(self, request):
        # uid를 기반으로 user table 데이터와 userbias 데이터를 가지고 올것
        user_data = self._database.get_user_data_with_uid(request.uid)
        if not user_data:
            return False
        self._user.make_with_dict(user_data)
        return True
    
    
    
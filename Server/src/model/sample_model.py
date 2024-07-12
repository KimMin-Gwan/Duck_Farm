from model.fake_database import Local_Database
from model.data_domain import User
from view.parsers import Head_Parser
import json

class HeaderModel:
    def __init__(self) -> None:
        self._state_code = '500'

    def _get_response_data(self, head_parser:Head_Parser, body):
        header = head_parser.get_header()
        header['state-code'] = self._state_code
        form = {
            'header' : header,
            'body' : body
        }

        response = json.dumps(form, ensure_ascii=False)
        return response

    def set_state_code(self, state_code):
        self._state_code = state_code
        return


class SampleModelTypeOne(HeaderModel):
    def __init__(self, database) -> None:
        self._database:Local_Database = database
        self._user = User()
        super().__init__()

    def set_user_with_uid(self, request):
        # uid를 기반으로 user table 데이터와 userbias 데이터를 가지고 올것
        user_data = self._database.get_data_with_id(target="uid", id=request.uid)
        if not user_data:
            return False
        self._user.make_with_dict(user_data)
        return True
    
    # 추상
    def get_response_form_data(self):
        pass


    def _make_dict_list_data(self, list_data:list)-> list:
        dict_list_data = []
        for data in list_data:
            dict_list_data.append(data.get_dict_form_data())
        return dict_list_data
    




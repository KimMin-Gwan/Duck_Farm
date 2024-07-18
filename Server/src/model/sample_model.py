from model.fake_database import Local_Database
from model.data_domain import User
from view.parsers import Head_Parser
import json
from others import CoreControllerLogicError

import editdistance
from jamo import h2j, j2hcj

class FindSimilarData:
    def __decompose(self, text:str):
        return ''.join(j2hcj(h2j(text.replace(" ", ""))))

    def search_similar(self, data_list:list, key_word:str, key_attr:str):
        results = []
        decomposed_key_data = self.__decompose(key_word)
        for item in data_list:
            target_item = getattr(item, key_attr)
            decomposed_item = self.__decompose(target_item)
            distance = editdistance.eval(decomposed_item, decomposed_key_data)
            if distance <= len(decomposed_item) - len(decomposed_key_data):
                results.append(item)
        return results

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
    def get_response_form_data(self,head_parser):
        try:
            body = {
                "default" : "Default state get_response_form_data func"
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))

    def _make_dict_list_data(self, list_data:list)-> list:
        dict_list_data = []
        for data in list_data:
            dict_list_data.append(data.get_dict_form_data())
        return dict_list_data

class SampleModelTypeTwo(HeaderModel):
    def __init__(self, database) -> None:
        self._database:Local_Database = database
        self._user = User()
        super().__init__()
    

    def _search_similar_data(self, data_list:list, key_word:str, key_attr:str):
        find_similar_data = FindSimilarData()
        result = find_similar_data.search_similar(data_list=data_list,
                                          key_word=key_word, key_attr=key_attr)
        return result

    # 추상
    def get_response_form_data(self):
        pass


    def _make_dict_list_data(self, list_data:list)-> list:
        dict_list_data = []
        for data in list_data:
            dict_list_data.append(data.get_dict_form_data())
        return dict_list_data
    

class SampleModelTypeThree(HeaderModel):
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
    
    def _set_list_alignment(self,product_list , align): #정렬
        if align == "latest":
            sorted_products = sorted(product_list, key=lambda x: x.latest, reverse=True)
        elif align == "rating":
            sorted_products = sorted(product_list, key=lambda x: x.rating, reverse=True)
        elif align == "like":
            sorted_products = sorted(product_list, key=lambda x: x.like, reverse=True)
        else:
            sorted_products = sorted(product_list, key=lambda x: x.iid, reverse=True)
        #sorted_products = sorted(product_list, key=lambda x: datetime.strptime(x.date, "%Y/%m/%d"))

        return sorted_products
    

    # 추상
    def get_response_form_data(self):
        pass


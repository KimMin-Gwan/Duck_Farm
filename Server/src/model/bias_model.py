from datetime import datetime
from model.sample_model import SampleModelTypeOne
from model.fake_database import Local_Database
from model.data_domain import Bias, Schedule
from datetime import datetime
from others import CoreControllerLogicError

class BiasListModel(SampleModelTypeOne):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__biases = []    
    
    #bids로 biases 데이터 받아오기 (객체에 저장됨)
    def get_biases_data_with_bids(self) -> bool:
        biases_data = self._database.get_datas_with_ids(target_id="bid", ids=self._user.bids)
        #self.__biases = Bias(biases_data)
        if len(biases_data)==0 :
            return False
        for bias_data in biases_data :
            bias = Bias()
            bias.make_with_dict(dict_data=bias_data)
            self.__biases.append(bias)
        #print(self.__biases[0].bname)
        return True
    
    def get_response_form_data(self, head_parser):
        try:
            bias_order = self._user.bids
            body = {
                "bias_list" : self._make_dict_list_data(list_data=self.__biases),
                "bias_order" : bias_order
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))

    
class BiasFollowModel(SampleModelTypeOne):
    def __init__(self, database:Local_Database) -> None:
        super().__init__(database)
        self.__result = False
    
    def check_bias_id(self, request) -> bool:
        try:
            if request.bid in self._user.bids:
                self.__try_remove_bias(request.bid)
            else:
                self.__try_add_bias(request.bid)

            self._save_user_data()
            print(request.bid)
        except Exception as e:
            print(e)
            #raise CoreControllerLogicError(error_type="check_bias_id error | ")

    #bids로 biases 데이터 받아오기 (객체에 저장됨)
    def __try_add_bias(self, bid):
        self._user.bids.append(bid)
        self.__result = True
        return

    
    def __try_remove_bias(self, bid):
        self._user.bids.remove(bid)
        self.__result = False
        return
    
    def _save_user_data(self):
        self._database.modify_data_with_id(target_id="uid",
                                            target_data=self._user.get_dict_form_data())
        return

    def get_response_form_data(self, head_parser):
        try:
            body = {
                "result" :  self.__result
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            print(e)
            raise CoreControllerLogicError(error_type="response making error | " + str(e))
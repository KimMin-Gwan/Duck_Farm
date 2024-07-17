from model import SignUpModel
from model import Local_Database
#from view import NoneBiasHomeDataRequest, BiasHomeDataRequest
from others import UserNotExist, CustomError

class Sign_Controller:
    def try_sign_up(self, database:Local_Database, request) -> SignUpModel:
        model = SignUpModel(database=database)
        try:
            if not model.make_uid():
                model.set_state_code("440")
                return model

            if not model.set_user_with_request_data(request=request):
                model.set_state_code("440")
                return model

            model.set_state_code("241")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        finally:
            return model
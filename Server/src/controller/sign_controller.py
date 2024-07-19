from model import SignUpModel, LoginModel, ChangePasswordModel, UserEmailCheck
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
        
    def try_login(self, database:Local_Database, request) -> LoginModel:
        model = LoginModel(database=database)
        try:
            if not model.set_user_with_email(request=request):
                model.set_state_code("253") # email 없음
                return model

            if not model.try_compare_password(request=request):
                model.set_state_code("252") # password 가 다름
                return model

            model.set_state_code("251") # 모든 작업 성공

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        finally:
            return model
        
    def try_change_password(self, database:Local_Database, request) -> LoginModel:
        model = ChangePasswordModel(database=database)
        try:
            if not model.set_user_with_email(request=request):
                model.set_state_code("254") # email 없음

        except UserNotExist as e:
            print("Error Catched : ", e)
            model.set_state_code(e.error_code) # 종합 에러
            return model

        try:
            if not model.try_change_password(request=request):
                model.set_state_code("255") # password 가 다름
                return model

            model.set_state_code("256") # 모든 작업 성공

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        finally:
            return model
    
    # email 확인
    def check_user_email(self, database:Local_Database, request) -> SignUpModel:
        model = UserEmailCheck(database=database)

        try:
            if not model.check_user_email(request=request):
                model.set_state_code("265") # email 일치하지 않음
                return model

            model.set_state_code("266") # email 일치

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        finally:
            return model
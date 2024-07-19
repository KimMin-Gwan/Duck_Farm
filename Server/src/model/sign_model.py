from model.sample_model import SampleModelTypeThree
from model.fake_database import Local_Database
from model.data_domain import User
from datetime import datetime
from others import CoreControllerLogicError, UserNotExist
import uuid

class SignUpModel(SampleModelTypeThree):
    def __init__(self, database) -> None:
        super().__init__(database)
        self.__user = User()
        self.__uid = ""

    def __generate_uid(self):
        uid = str(uuid.uuid4())
        # uuid4()는 형식이 "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"인 UUID를 생성합니다.
        # 이를 "1234-abcd-5678" 형태로 변형하려면 일부 문자만 선택하여 조합합니다.
        uid_parts = uid.split('-')
        return f"{uid_parts[0][:4]}-{uid_parts[1][:4]}-{uid_parts[2][:4]}"

    def make_uid(self):
        result = True

        count = 0
        while True:
            uid = self.__generate_uid()
            if not self._database.get_data_with_id(target="uid", id=uid):
                self.__uid = uid
                break
            else:
                count += 1

            if count > 1000:
                result = False
                break

        return result


    def set_user_with_request_data(self, request):
        try:
            self.__user=User(uname=request.uname, password=request.password, email= request.email,
                 nickname=request.nickname, birthday=request.birthday, uid=self.__uid)
            
            # 약관 관련 저장하기 코드 추가 되어야함

            self._database.add_new_data("uid", self.__user.get_dict_form_data())

            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_user_with_request_data error | " + str(e))


    # json 타입의 데이터로 반환
    def get_response_form_data(self, head_parser):
        try:
            body = {
                "user" : self.__user.get_dict_form_data()
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))


class ChangePasswordModel(SampleModelTypeThree):
    def __init__(self, database) -> None:
        super().__init__(database)
        self.__user = User()
        self.__result = False

    def set_user_with_email(self, request) -> None:
        user_data = self._database.get_data_with_key(target="uid", key="email", key_data=request.email)

        if not user_data:
            raise UserNotExist()

        self.__user.make_with_dict(user_data)
        return True

    def try_change_password(self, request):
        try:
            self.__user.password = request.password
            self._database.modify_data_with_id("uid", self.__user.get_dict_form_data())
            self.__result = True

            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="set_user_with_request_data error | " + str(e))


    # json 타입의 데이터로 반환
    def get_response_form_data(self, head_parser):
        try:
            body = {
                "result" : self.__result
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))

# email 확인
class UserEmailCheckModel(SampleModelTypeThree):
    def __init__(self, database) -> None:
        super().__init__(database)
        self.__result = False

    def check_user_email(self, request):
        try:
            user_data = self._database.get_data_with_key(target="uid", key="email", key_data=request.email)
            if not user_data :
                self.__result = False
            else : # email이 일치함
                self.__result = True

            return True
        except Exception as e:
            raise CoreControllerLogicError(error_type="check_user_email error | " + str(e))


    # json 타입의 데이터로 반환
    def get_response_form_data(self, head_parser):
        try:
            body = {
                "result" : self.__result
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))

import time
# email 확인
class EmailSendModel(SampleModelTypeThree):
    def __init__(self, database) -> None:
        super().__init__(database)
        self.__result = False


    def send_email_checker(self):
        count = 0
        while True:
            time.sleep(1)
            count += 1
            if count == 5:
                break

        self.__result = True
        return 

    # json 타입의 데이터로 반환
    def get_response_form_data(self, head_parser):
        try:
            body = {
                "result" : self.__result
            }

            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))
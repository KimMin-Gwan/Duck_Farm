from model.sample_model import SampleModelTypeThree
from model.data_domain import User
from others import CoreControllerLogicError

class LoginModel(SampleModelTypeThree):
    def __init__(self, database) -> None:
        super().__init__(database)
        self.__user = User()
        self.__result = False
    #email로 user 데이터 받아오기 (객체에 저장됨)
    def set_user_with_email(self, request) -> bool:
        user_data = self._database.get_data_with_key(target="user", key="email", key_data=request.email)
        #self.__biases = Bias(biases_data)
        if not user_data :
            return False
        self.__user.make_with_dict(dict_data=user_data)
        #print(self.__biases[0].bname)
        return True
    
    def try_compare_password(self, request) -> bool:
        if self.__user.password == request.password :
            self.__result = True
            return True
        return False

    # json 타입의 데이터로 반환
    # user 정보 / 실패시 모두 공백으로 전송
    def get_response_form_data(self, head_parser):
        try:
            if self.__result :
                body = {
                    "user" : {
                        "uid" : self.__user.uid,
                        "uname" : self.__user.uname,
                        "email" : self.__user.email,
                        "nickname" : self.__user.nickname
                    },
                    "result" : True
                }
            else :
                body = {
                    "user" : {
                        "uid" : "",
                        "uname" : "",
                        "email" : "",
                        "nickname" : ""
                    },
                    "result" : False
                }

            
            response = self._get_response_data(head_parser=head_parser, body=body)
            return response

        except Exception as e:
            raise CoreControllerLogicError(error_type="response making error | " + str(e))

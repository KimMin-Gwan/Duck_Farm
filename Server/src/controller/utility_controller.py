from model import ImageLikeModel
from model import Local_Database
#from view import NoneBiasHomeDataRequest, BiasHomeDataRequest
from others import UserNotExist, CustomError

class Utility_Controller:
    def try_image_like_n_dislike(self, database:Local_Database, request) -> ImageLikeModel:
        model = ImageLikeModel(database=database)
        try:
            # 유저가 있는지 확인
            if not model.set_user_with_uid(request=request):
                raise UserNotExist("Can not find User with uid")
        except UserNotExist as e:
            print("Error Catched : ", e)
            model.set_state_code(e.error_code) # 종합 에러
            return model

        try:
            if not model.set_image_data(request=request):
                model.set_state_code("220")
                return model

            if not model.set_image_like(request=request):
                model.set_state_code("220")
                return model

            if request.like:
                model.set_state_code("221")
            else:
                model.set_state_code("222")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        finally:
            return model

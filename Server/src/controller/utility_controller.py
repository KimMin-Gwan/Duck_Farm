from model import ImageLikeModel, SearchScheduleModel, SearchBiasModel, BiasFollowModel
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
                model.set_state_code("230")
                return model

            if request.like:
                model.set_state_code("231")

            else:
                model.set_state_code("232")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        finally:
            return model

    def try_search_schedule_with_keyword(self, database:Local_Database, request) -> SearchScheduleModel:
        model = SearchScheduleModel(database=database)
        try:
            # 입력된 키워드가 빈 리스트면 바로 리턴
            if len(request.key_word) == 0:
                model.set_state_code("234")
                return model

            if not model.set_schedules():
                model.set_state_code("530")
                return model
            
            # 찾아낸 리스트가 없다면 234
            if not model.search_schedule_data(request=request):
                model.set_state_code("234")
                return model

            model.set_state_code("235")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e)
            model.set_state_code(e) # 종합 에러

        finally:
            return model

    def try_search_bias_with_keyword(self, database:Local_Database, request) -> SearchBiasModel:
        model = SearchBiasModel(database=database)
        try:
            # 입력된 키워드가 빈 리스트면 바로 리턴
            if len(request.key_word) == 0:
                model.set_state_code("236")
                return model

            if not model.set_biases():
                model.set_state_code("530")
                return model
            
            # 찾아낸 리스트가 없다면 234
            if not model.search_bias_data(request=request):
                model.set_state_code("236")
                return model

            model.set_state_code("237")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e)
            model.set_state_code(e) # 종합 에러

        finally:
            return model

    def try_follow_bias(self, database:Local_Database, request):
        model = BiasFollowModel(database=database)
        try:
            # 유저가 있는지 확인
            if not model.set_user_with_uid(request=request):
                raise UserNotExist("Can not find User with uid")
        except UserNotExist as e:
            print("Error Catched : ", e)
            model.set_state_code(e.error_code) # 종합 에러
            return model

        try:
            model.check_bias_id(request=request)
            model.set_state_code("224")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        finally:
            return model

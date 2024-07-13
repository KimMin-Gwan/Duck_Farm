from model import NoneBiasHomeDataModel, BiasHomeDataModel, ImageDetailModel, ImageListByBiasModel, ImageListByBiasNScheduleModel
from model import Local_Database
#from view import NoneBiasHomeDataRequest, BiasHomeDataRequest
from others import UserNotExist, CustomError


class Core_Controller:
    def get_none_bias_home_data(self, database:Local_Database, request) -> NoneBiasHomeDataModel:
        model = NoneBiasHomeDataModel(database=database)
        try:
            # 유저가 있는지 확인
            if not model.set_user_with_uid(request=request):
                raise UserNotExist("Can not find User with uid")
        except UserNotExist as e:
            print("Error Catched : ", e)
            model.set_state_code(e.error_code) # 종합 에러
            return model

        try:
            if not model.set_biases_with_bids():
                model.set_state_code("210")
                return model
        
            if not model.set_schedules_with_sids():
                model.set_state_code("210")
                return model

            if not model.set_home_body_data_with_target_date(request=request):
                model.set_state_code("210")
                return model
            model.set_state_code("211")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러
            print(e.error_type)

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러
            print(e.error_type)


        finally:
            return model
    
    def get_bias_home_data(self, database:Local_Database, request):
        model = BiasHomeDataModel(database=database)
        model.set_state_code('503')

        return model
    

    def get_image_detail(self, database:Local_Database, request):
        model = ImageDetailModel(database=database)
        try:
            # 유저가 있는지 확인
            if not model.set_user_with_uid(request=request):
                raise UserNotExist("Can not find User with uid")
        except UserNotExist as e:
            print("Error Catched : ", e)
            model.set_state_code(e.error_code) # 종합 에러
            return model

        try:
            model.set_image_with_iid(request=request)
            model.set_bias_with_bid(request=request)
            model.set_schedule_with_sid()

            model.set_state_code("200")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러
            print(e.error_type)

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러
            print(e.error_type)


        finally:
            return model
        
    def get_image_list_by_bias(self, database:Local_Database, request):
        model = ImageListByBiasModel(database=database)
        try:
            # 유저가 있는지 확인
            if not model.set_user_with_uid(request=request):
                raise UserNotExist("Can not find User with uid")
        except UserNotExist as e:
            print("Error Catched : ", e)
            model.set_state_code(e.error_code) # 종합 에러
            return model
        
        try:
            model.set_bias_with_bid(request=request)
            model.set_images_with_bid()
            model.make_image_list()

            model.set_state_code("200")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러
            print(e.error_type)

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러
            print(e.error_type)
            
        finally:
            return model
    
    def get_image_list_by_bias_n_schedule(self, database:Local_Database, request):
        model = ImageListByBiasNScheduleModel(database=database)
        try:
            # 유저가 있는지 확인
            if not model.set_user_with_uid(request=request):
                raise UserNotExist("Can not find User with uid")
        except UserNotExist as e:
            print("Error Catched : ", e)
            model.set_state_code(e.error_code) # 종합 에러
            return model







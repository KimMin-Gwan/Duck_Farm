from model import *
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

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        finally:
            return model
    
    def get_bias_home_data(self, database:Local_Database, request):
        model = BiasHomeDataModel(database=database)
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

            print("hello")
            if not model.set_schedules_with_sids(request=request):
                model.set_state_code("210")
                return model

            if not model.set_home_body_data_with_target_date(request=request):
                model.set_state_code("210")
                return model
            
            model.filtering_home_body_data()

            model.set_state_code("212")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러
        finally:
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
            model.set_bias_with_bid()
            model.set_schedule_with_sid()
            model.is_image_owner()
            model.is_image_like()
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
            model.set_list_alignment(request=request)
            model.set_images_with_bid(request=request)
            model.make_image_list()

            model.set_state_code("218")

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

        try:
            model.set_bias_with_bid(request=request)
            model.set_schedule_with_sid(request=request)
            model.set_list_alignment(request=request)
            model.set_images_with_sid(request=request)
            model.make_image_list()

            model.set_state_code("219")

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
        

    #최애 팔로잉 편집 페이지
    def get_bias_list(self, database:Local_Database, request):
        model = BiasListModel(database=database)
        try:
            # 유저가 있는지 확인
            if not model.set_user_with_uid(request=request):
                raise UserNotExist("Can not find User with uid")
        except UserNotExist as e:
            print("Error Catched : ", e)
            model.set_state_code(e.error_code) # 종합 에러
            return model

        try:
            if not model.get_biases_data_with_bids():
                model.set_state_code("222")
                return model

            model.set_state_code("223")

        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        finally:
            return model

    # 이미지 검색    
    def try_search_image(self, database:Local_Database, request):
        model = ImagSearchModel(database=database)
        try:
            if not model.try_searching_images(request):
                model.set_state_code("233")
                return model
            if not model.set_list_alignment(request):
                model.set_state_code("234")
                return model
            model.make_image_list(request)

            model.set_state_code("235")
        except CustomError as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

        except Exception as e:
            print("Error Catched : ", e.error_type)
            model.set_state_code(e.error_code) # 종합 에러

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

    def image_upload(self, database:Local_Database, request):
        model = ImageUploadModel(database=database)
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
            model.get_image_info(request=request)
            model.upload_image()
            model.set_state_code("220")

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



#from model import User_Model
#from model import Image_Model
#from model import Bias_Model
##from model import Schedule

#class Image_Controller:
    #def __init__(self) -> None:
        #pass

    #def get_image_detail(self, request, database):

        ##유저 확인
        #user_model = User_Model()
        #result = {}
        #if not user_model.is_vaild_user(request['uid']) :
            #result = {
                #'state_code' : '208',
                #'detail' : 'permision denied',
            #}
            #return result

        #image_model= Image_Model(database)
        #image_model.make_image_data_with_iid(request['iid'])

        #bias_model = Bias_Model(database)
        #bias_model.make_bias_data_with_bid(request['bid'])
        
        #result = image_model.get_detail_image_data()

        #result['bias_name']=bias_model.get_name()
        #result['user_name']=user_model.get_uname()

        #if user_model.get_uid() == image_model.get_uid():
            #result['user_owner'] = True
        #else:
            #result['user_owner'] = False

        #return result
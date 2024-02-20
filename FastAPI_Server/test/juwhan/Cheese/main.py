from Master_Model import *


master=Master.get_master_model()
user=master.get_user_model()
user.find_user_uid(134)
loacl=master.get_local_data()

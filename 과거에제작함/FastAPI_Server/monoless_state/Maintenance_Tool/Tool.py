from datetime import datetime
from enum import Enum, auto

class Log_Type(Enum):
    ETC = auto()  # others = 1 
    ERROR = auto() # Error  = 2
    SIGN = auto()  # sign in & sign out  = 3

# Error Catcher
class Error_Catcher(Log_Type):
    def __init__(self, bug_log_path = "./bug_log.txt", log_path="./log.txt", 
                 sign_log_path = "./sign_log.txt"):
        super.__init__()
        print("SYSTEM_CALL::ERROR_DETECTED")
        print("SYSTEM_CALL::NOW_ERROR_CAHTCHER_SETTING")
        self.log_path = log_path
        self.bug_log_path = bug_log_path
        self.sign_log_path = sign_log_path


    """
    ## log wirte on txt file
    detail : log detail
    type : Log_Type.ETC & Log_Type.ERROR & Log_Type.SIGN
    """
    def log_write(self, detail:str, type:Log_Type=Log_Type.ETC):
        time = self.__time_stamp
        log = time + f"::Error | {detail}"
        self.__report(self, log, type)
        return

    # 추가 작성 필요
    # 에러 케쳐에서 에러가 나면 어떻게 처리함?
    def __report(self, log, type):
        if type == Log_Type.ETC:
            log_txt = open(self.log_path, "a")
            log_txt.wirte(log + "\n")
            log_txt.close()
        elif type == Log_Type.ERROR:
            bug_log_txt = open(self.bug_log_path, "a")
            bug_log_txt.wirte(log + "\n")
            bug_log_txt.close()
        elif type == Log_Type.SIGN:
            sign_log_txt = open(self.sign_log_path, "a")
            sign_log_txt.wirte(log + "\n")
            sign_log_txt.close()
        return

    # time setting
    def __time_stamp(self):
        time = datetime.now()
        print(time)
        log = f"[{time}]"
        return 
    
    # Error Catcher distructor
    def __destructor(self):
        return




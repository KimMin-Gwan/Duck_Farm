
class CoreControllerLogicError(Exception):
    def __init__(self, *args: object) -> None:
        super().__init__(*args)
        self.error_code = "501"



def test_func():
    try:
        data_list = 10

        for data in data_list:
            print(data)

    except Exception as e:
        raise CoreControllerLogicError("error in test_func | ", e)
    
    return True

def main():
    try:
        test_func()
    except CoreControllerLogicError as e:
        print("Error Catched : ", e)
    


main()




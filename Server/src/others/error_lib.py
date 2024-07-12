
class CustomError(Exception):
    def __init__(self, *args: object) -> None:
        super().__init__(*args)


class UserNotExist(CustomError):
    def __init__(self, *args: object) -> None:
        super().__init__(*args)
        self.error_code = "401"

class CoreControllerLogicError(CustomError):
    def __init__(self, *args: object, error_type:str) -> None:
        super().__init__(*args)
        self.error_code = "501"
        self.error_type = "CoreControllerLogicError | " + error_type

class DictMakingError(CustomError):
    def __init__(self, *args: object, error_type:str) -> None:
        super().__init__(*args)
        self.error_code = "502"
        self.error_type = "DictMakingError | " + error_type

class DatabaseLogicError(CustomError):
    def __init__(self, *args: object, error_type:str) -> None:
        super().__init__(*args)
        self.error_code = "505"
        self.error_type = "DatabaseLogicError| " + error_type
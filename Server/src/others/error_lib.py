

class UserNotExist(Exception):
    def __init__(self, *args: object) -> None:
        super().__init__(*args)
        self.error_code = "401"

class CoreControllerLogicError(Exception):
    def __init__(self, *args: object) -> None:
        super().__init__(*args)
        self.error_code = "501"

class DictMakingError(Exception):
    def __init__(self, *args: object) -> None:
        super().__init__(*args)
        self.error_code = "502"

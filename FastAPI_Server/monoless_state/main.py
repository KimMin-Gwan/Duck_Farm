from Duck_Farm.FastAPI_Server.monoless_state.src.view import APP_Server
from src.controller import *
from src.model import *


class Main():
    def __init__(self):
        self.model = Master_Model()
        self.controller = Master_Controller(self.model)
        self.app_server = APP_Server(self.controller)
        
    def start_system(self):
        print("SYSTEM_CALL||RUN_SYSTEM")
        self.app_server.run_system()
        
    
if __name__ == "__main__":
    main = Main()
    main.start_system()

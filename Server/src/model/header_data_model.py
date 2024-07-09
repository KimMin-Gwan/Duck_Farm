import json

class HeaderModel:
    def __init__(self) -> None:
        self._state_code = '500'

    def get_response_data(self, body):
        form = {
            'header' : {
                'state-code' : self._state_code
                },
            'body' : body
        }

        response = json.dumps(form, ensure_ascii=False)
        return response

    def set_state_code(self, state_code):
        self._state_code = state_code
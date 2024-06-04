
class Configure_File_Reader:
    def __init__(self) -> None:
        self.host = ""
        self.port = 0000
        self.version = ""

    def extract_host_port(self, file_path="./configure.txt"):
        with open(file_path, 'r', encoding='utf-8') as file:
            for line in file:
                if line.startswith('HOST'):
                    self.host = line.split('=')[1].strip()
                elif line.startswith('PORT'):
                    self.port = int(line.split('=')[1].strip())
                elif line.startswith('VERSION'):
                    self.version = line.split('=')[1].strip()
        

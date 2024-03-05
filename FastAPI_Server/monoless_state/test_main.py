from src.model.model import *


if __name__=="__main__":
    user=User_Model()
    email=input("input email : ")
    password=input("input passwod : ")
    user.find_email(email)
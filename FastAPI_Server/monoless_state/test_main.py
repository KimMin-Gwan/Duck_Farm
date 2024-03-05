from src.model.model import *


if __name__=="__main__":
    user=User_Model()
    while(True):
        number=int(input("1  ==  find_email \n 2 == 회원가입"))
        if(number==1):
            email=input("input email : ")
            user.find_email(email)
        elif(number==2):
            email=(input("email : "))
            password=input("password : ")
            birthday=input("birthday : ")
            sex=input("femail,mail") 
            phone=input("input phone nmumber :")
            name=input("input name : ")
            print(user.make_user(email,password,birthday,phone,name,sex))
        else:
            print("end ===")
            break
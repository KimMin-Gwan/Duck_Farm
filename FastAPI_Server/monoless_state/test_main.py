from src.model.model import *


if __name__=="__main__":
    user=User_Model()
    while(True):
        number=int(input("1  ==  find_email \n 2 == 회원가입  \n  3==otp 장입  \n  4== otp 확인"))
        if(number==1):
            email=input("input email : ")
            user.find_email(email)
        elif(number==2):
            uid=input("uid : ")
            email=(input("email : "))
            password=input("password : ")
            birthday=input("birthday : ")    #2020:11:01 형식으로 입력해야함 
            sex=input("femail,mail : ") 
            phone=input("input phone nmumber :")
            name=input("input name : ")
            print(user.make_user(uid,email,password,birthday,phone,name,sex))
        elif(number==3):
            email=(input("input email"))
            otp=input("input otp")
            user.set_otp(email,otp)
        elif (number==4):
            email=input("input email")
            print(user.get_otp_db(email))
        elif (number==5):
            email=(input("input email"))
            print(user.set_user_password("change_password",email))
        elif (number==6) :
            uid=(input("input uid"))
            user.set_user("",uid)
            
            
        else:
            print("end ===")
            break

import random

def main():

    email = "alsrhks2508@naver.com"

    email1 = ord(email[0])
    email2 = ord(email[1])
    
    print(type(email1))
    print(type(email2))

    rand_n = int(random.random() * 10000)

    otp = rand_n * email1 * email2


    sand_data = otp 

    input_data = rand_n

    input_data = otp

    data = email1 * email2

    result = data%10000
    print(otp)
    


if __name__ == "__main__":
    main()
2147483647
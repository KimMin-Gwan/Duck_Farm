from datetime import datetime

time = datetime.now()

print(time.year)
print(type(time.day))

uid1 = str(time.year%100)
uid2 = str(time.month)

if(time.month < 10):
    uid2 = '0' + uid2

uid3 = str(time.day)

if(time.day < 10):
    uid3 = '0' +  str(time.day)

uid4 = uid1+uid2+uid3

print(f'[{time}]')
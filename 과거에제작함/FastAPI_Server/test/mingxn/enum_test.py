from enum import Enum, auto

class Color(Enum):
    RED = auto()
    GREEN = auto()
    BLUE = auto()

# 열거형 상수 사용 예제
print(type(Color.RED))     # Color.RED
print(Color.RED.value)  # 실제 값에 접근

exit()

# 열거형 상수 비교
if Color.RED == Color.GREEN:
    print('두 색은 같습니다.')
else:
    print('두 색은 다릅니다.')

# 반복문을 통한 열거형 상수 순회
for color in Color:
    print(color)

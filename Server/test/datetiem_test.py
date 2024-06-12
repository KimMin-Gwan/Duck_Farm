import datetime

# 10개의 날짜와 시간 데이터
date_strings = [
    '2024-06-01 12:00:00',
    '2024-06-02 15:30:00',
    '2024-06-03 09:45:00',
    '2024-06-04 11:20:00',
    '2024-06-05 08:15:00',
    '2024-06-06 14:50:00',
    '2024-06-07 18:05:00',
    '2024-06-08 20:30:00',
    '2024-06-09 13:25:00',
    '2024-06-10 10:40:00'
]

# 문자열을 datetime 객체로 변환
date_times = [datetime.datetime.strptime(date_string, '%Y-%m-%d %H:%M:%S') for date_string in date_strings]

# 가장 최신 날짜와 시간을 찾기
latest_date_time = max(date_times)

# 결과 출력
print('가장 최신 날짜와 시간:', latest_date_time)
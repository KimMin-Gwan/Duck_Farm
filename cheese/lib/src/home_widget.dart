import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TopBarWidget
            Container(
              child: TopBarWidget(),
            ),

            // HomeBodyWidget
            Container(
              margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              child: HomeBodyWidget(),
            ),

            // CalenderWidget
            Container(
              margin: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
              child: CalendarWidget(),
            ),

            // BiasWidget
            Container(
              margin: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 10.0),
              child: BiasWidget(selectedDate: DateTime.now()), // 오늘 날짜를 임의로 넣음
            ),
            // 다른 위젯 추가
          ],
        ),
      ),
    );
  }
}


// TopBarWidget
class TopBarWidget extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0), // 좌우 간격
      height: kToolbarHeight, // AppBar와 높이 같게
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 가운데 간격
        children: [
          Image.asset(
            'assets/images/eng_logo.png', // 이미지 경로
          ),
          IconButton(
            onPressed: () {
              // 메뉴 아이콘 클릭 시 동작
            },
            icon: Icon(Icons.menu),
          )
        ],
      ),
    );
  }
}


// HomeBodyWidget
class HomeBodyWidget extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBodyWidget> {
  // 가상의 데이터 리스트
  final List<String> _items = ['Item 1','Item 2']; //Item이 6개일때 스크롤 확인 OK

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100], // 배경을 회색으로 설정
        borderRadius: BorderRadius.circular(10.0), // 모서리를 둥글게 설정 (반지름 10.0)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.more_vert), // 오른쪽 상단에 위치하는 아이콘
              ],
            ),
          ),
          Container(
            height: 100, // 높이를 지정하여 스크롤 가능하도록 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // 가로 스크롤 설정
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    if (index == 0) // 첫 번째 원의 경우
                      SizedBox(width: 15.0), // 원하는 만큼의 왼쪽 빈 공간 추가
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(9.0, 0.0, 9.0, 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1), // 그림자 색상
                                  spreadRadius: 2, // 그림자 퍼짐 반경
                                  blurRadius: 2, // 그림자 흐림 정도
                                  offset: Offset(0, 3), // 그림자 위치 (x, y)
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 30, // 원의 크기 설정
                              backgroundImage: AssetImage('assets/images/eng_logo.png'), // 이미지 경로
                            ),
                          ),
                        ),
                        Text(
                          '정우성', // 텍스트
                          style: TextStyle(
                            fontSize: 16.0, // 텍스트 크기 조절
                          ),
                        ),
                      ],
                    ),
                  ],
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}


// CalenderWidget
class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Container의 배경색을 설정합니다.
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 그림자의 색상과 투명도를
            spreadRadius: 5, // 그림자가 퍼지는 반경
            blurRadius: 5, // 그림자의 흐림 정도
            offset: Offset(0.1, 3), // 그림자의 위치
          ),
        ],
      ),
      child: Column(
        children: [
          // 연도와 월을 화살표와 함께 표시
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
                  });
                },
              ),
              Text(
                DateFormat('MMMM yyyy').format(_focusedDay),
                style: TextStyle(fontSize: 15.0),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
                  });
                },
              ),
            ],
          ),
          Divider(
            color: Colors.lightBlue, // 구분선 색상을 하늘색으로 설정
            thickness: 0.5, // 구분선 두께 설정
          ),
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // `_focusedDay`도 업데이트
              });
            },
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerVisible: false, // 기본 헤더 숨기기
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(color: Colors.black),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.black),
              weekendStyle: TextStyle(color: Colors.black),
            ),
            rowHeight: 75.0, // 날짜 셀의 세로 높이 조정
          ),
          Divider(
            color: Colors.lightBlue, // 구분선 색상을 하늘색으로 설정
            thickness: 0.5, // 구분선 두께 설정
          ),
        ],
      ),
    );
  }
}


// BiasWidget
class BiasWidget extends StatefulWidget {
  final DateTime selectedDate; // Calendar에서 선택한 날짜

  BiasWidget({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _BiasState createState() => _BiasState();
}

class _BiasState extends State<BiasWidget> {
  // 한국어 요일 목록
  final List<String> _weekDays = ['월', '화', '수', '목', '금', '토', '일'];
  final List<String> _items = ['Item 1','Item 2'];

  @override
  Widget build(BuildContext context) {
    // 선택된 날짜의 요일 계산 (1=월요일, 7=일요일)
    String weekDay = _weekDays[widget.selectedDate.weekday - 1];
    String formattedDate = DateFormat('dd').format(widget.selectedDate);
    // String weekDay = DateFormat('E', 'ko_KR').format(widget.selectedDate); // LocaleError 발생

    return Column(
      children: [
        // 첫 번째 파트: 날짜와 요일
        Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
          child: Row(
            children: [
              Text(
                '$formattedDate.$weekDay',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // 두 번째 파트: 원형 사진과 텍스트
        Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 0.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/your_image.png'), // 이미지 경로 수정 필요
              ),
              SizedBox(width: 10),
              Text(
                '정우성',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 왼쪽 부분
              Column(
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.grey,
                  ),
                  Container(
                    width: 2,
                    height: 200, // 임의로 작성
                    color: Colors.grey,
                  ),
                ],
              ),
              // 오른쪽 부분
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 가운데 간격
                      children: [
                        Text(
                          '2023 더팩트 뮤직 어워드',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600, // 글씨를 굵게 설정
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.45), // ???????????
                        Icon(
                          Icons.arrow_forward_ios, // 오른쪽 화살표 아이콘
                          size: 16.0, // 아이콘 크기 조절
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8, // 화면 너비의 90%를 차지하도록 설정
                      height: 150,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10), // 왼쪽 위 모서리
                          bottomLeft: Radius.circular(10), // 왼쪽 아래 모서리
                        ),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal, // 수평 스크롤을 활성화
                        itemCount: 10, // 내부 사각형 개수 -> 추후 바꾸기
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.center, // 내부 사각형을 수직 방향 중앙에 배치
                            child: Container(
                              width: 120, // 내부 사각형 가로
                              height: 120, // 내부 사각형 세로
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent, // 여기에 색상을 지정합니다.
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              margin: EdgeInsets.fromLTRB(
                                  index == 0 ? 20.0 : 10.0, // 첫 번째 사각형만 왼쪽에 추가 공간을 설정
                                  0.0,
                                  10.0,
                                  0.0
                              ), // 사각형 사이의 간격을 설정합니다.
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ],
    );
  }
}
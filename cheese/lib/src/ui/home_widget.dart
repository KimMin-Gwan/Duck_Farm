import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _style.mainWhiteColor,
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
              child: BiasWidget(),
            ),

            // CalenderWidget
            Container(
              margin: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
              child: CalendarWidget(),
            ),

            // BiasWidget
            Container(
              margin: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
              child:
                  HomeBodyWidget(selectedDate: DateTime.now()), // 오늘 날짜를 임의로 넣음
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

// BiasWidget
class BiasWidget extends StatefulWidget {
  @override
  _BiasState createState() => _BiasState();
}

class _BiasState extends State<BiasWidget> {
  final List<String> _items = ['Item 1']; // 가상의 데이터 리스트

  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) {
      queryWidth = maxWidth;
    }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) {
      queryHeight = maxHeight;
    }

    double mainHeight = queryHeight * 0.2;

    return Container(
      decoration: _style.mainBoxDecoration,
      width: queryWidth,
      height: mainHeight,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.more_vert), // 오른쪽 상단에 위치하는 아이콘
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                  height: mainHeight * 0.6, // 높이를 지정하여 스크롤 가능하도록 설정
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // 가로 스크롤 설정
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: _biasProfile(
                          width: queryWidth,
                          height: mainHeight,
                          biasName: '정우성', // 실제 데이터로 변경 가능
                          biasId: _items[index], // 실제 데이터로 변경 가능
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
    );
  }

  Widget _biasProfile({
    required double width,
    required double height,
    required String biasName,
    required String biasId,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [_style.mainBoxShadow],
          ),
          child: CircleAvatar(
            radius: height * 0.2, // 원의 크기 설정
            backgroundImage: AssetImage('assets/images/eng_logo.png'), // 이미지 경로
          ),
        ),
        Text(
          biasName, // 텍스트
          style: TextStyle(
            fontSize: 14.0, // 텍스트 크기 조절
          ),
        ),
      ],
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

  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _style.calenderBoxShadow,
      child: Column(
        children: [
          // 연도와 월을 화살표와 함께 표시
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: () {
                    setState(() {
                      _focusedDay =
                          DateTime(_focusedDay.year, _focusedDay.month - 1);
                    });
                  },
                ),
                Text(
                  DateFormat('MMMM, yyyy').format(_focusedDay),
                  style: TextStyle(fontSize: 15.0),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    setState(() {
                      _focusedDay =
                          DateTime(_focusedDay.year, _focusedDay.month + 1);
                    });
                  },
                ),
              ],
            ),
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
            rowHeight: 70.0, // 날짜 셀의 세로 높이 조정
          ),

          Divider(
            color: Colors.white, // 구분선 색상을 하늘색으로 설정
            thickness: 0.5, // 구분선 두께 설정
          ),
        ],
      ),
    );
  }
}

// HomeBodyWidget
class HomeBodyWidget extends StatefulWidget {
  final DateTime selectedDate; // Calendar에서 선택한 날짜

  HomeBodyWidget({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBodyWidget> {
  // 한국어 요일 목록
  final List<String> _weekDays = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {
    // 선택된 날짜의 요일 계산 (1=월요일, 7=일요일)
    String weekDay = _weekDays[widget.selectedDate.weekday - 1];
    String formattedDate = DateFormat('dd').format(widget.selectedDate);

    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        children: [
          // 첫 번째 파트: 날짜와 요일
          _buildDateAndWeekDay(formattedDate, weekDay),
          // 두 번째 파트: 사진이랑 이름
          _buildProfileSection(),
          // 세 번째 파트: 타임라인
          _buildTimelineSection(context),
        ],
      ),
    );
  }

  Padding _buildDateAndWeekDay(String formattedDate, String weekDay) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      child: Row(
        children: [
          Text(
            '$formattedDate.$weekDay',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Padding _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 0.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage:
                AssetImage('assets/images/your_image.png'), // 이미지 경로 수정 필요
          ),
          SizedBox(width: 10),
          Text(
            '정우성',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Padding _buildTimelineSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineDotLine(),
          Expanded(child: _buildEventSection(context)), // 추가: 남은 공간을 차지하도록 확장
        ],
      ),
    );
  }

  Column _buildTimelineDotLine() {
    return Column(
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
    );
  }

  Column _buildEventSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEventTitle(context),
        _buildEventGallery(context),
      ],
    );
  }

  Padding _buildEventTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 10.0), // 오른쪽 여백 추가
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '2023 더팩트 뮤직 어워드',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16.0,
          ),
        ],
      ),
    );
  }

  Padding _buildEventGallery(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 150,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10, // 내부 사각형 개수 -> 추후 바꾸기
          itemBuilder: (context, index) => _buildGalleryItem(index),
        ),
      ),
    );
  }

  Align _buildGalleryItem(int index) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        margin: EdgeInsets.fromLTRB(
          index == 0 ? 20.0 : 10.0,
          0.0,
          10.0,
          0.0,
        ),
      ),
    );
  }
}

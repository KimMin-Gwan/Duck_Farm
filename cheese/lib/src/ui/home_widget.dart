import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import './src/ui/styles/main_theme.dart"';

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
            Padding(
              padding: EdgeInsets.all(0.0),
              child: TopBarWidget(),
            ),

            // HomeBodyWidget
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              child: BiasWidget(),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
              child: CalendarWidget(),
            ),

            // BiasWidget
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
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
  final double minHeight = 130.0;

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

    double mainHeight =
        max(queryHeight * 0.2, minHeight); // minHeight와 비교하여 더 큰 값을 선택

    return SingleChildScrollView(
      // SingleChildScrollView 추가
      child: ConstrainedBox(
        // minHeight를 보장하기 위한 ConstrainedBox 추가
        constraints: BoxConstraints(minHeight: minHeight), // 최소 높이 설정
        child: IntrinsicHeight(
          // 높이를 자식의 높이에 맞추기 위한 IntrinsicHeight 추가
          child: Container(
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
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 10.0, 0.0),
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
          ),
        ),
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
        Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(
            biasName, // 텍스트
            style: _style.biasName,
          ),
        )
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
                  style: _style.monthYear,
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

          _style.calenderDevider,

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
              todayDecoration: _style.todayBox,
              selectedDecoration: _style.selectedBox,
              weekendTextStyle: _style.weekColor,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: _style.weekColor,
              weekendStyle: _style.weekColor,
            ),
            rowHeight: maxHeight * 0.08, // 날짜 셀의 세로 높이 조정
          ),
          _style.calenderDevider,
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
  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;

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
            style: _style.eventday,
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
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              '정우성',
              style: TextStyle(fontSize: 16),
            ),
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
          radius: 5, // 원 크기 바꿀 필요 없기에 고정값으로
          backgroundColor: _style.mainContainerColor,
        ),
        Container(
          width: 2, // 두께라서 고정값으로
          height: maxHeight * 0.2, // 타임라인 길이 설정 (->0.19)
          color: _style.mainContainerColor,
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
      padding: const EdgeInsets.only(left: 15.0), // 오른쪽 여백 추가
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '2023 더팩트 뮤직 어워드',
            style: _style.eventTitle,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16.0, // 아이콘 사이즈도 바꾸지 X것 같으므로 고정값
          ),
        ],
      ),
    );
  }

  Padding _buildEventGallery(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      child: Container(
        width: maxWidth, // 상세 사진(회색) 가로 사이즈
        height: maxHeight * 0.15, // 세로 사이즈
        margin: EdgeInsets.only(right: 10),
        decoration: _style.eventGalleryBox,
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
        width: maxHeight * 0.12, // 내부 상세사진(보라) 높이
        height: maxHeight * 0.12, // 세로 높이
        decoration: _style.galleryBox,
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

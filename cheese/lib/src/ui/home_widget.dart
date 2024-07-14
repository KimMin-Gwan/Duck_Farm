import 'dart:math';
import 'package:cheese/src/ui/upload_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cheese/src/ui/styles/home_theme.dart';
import 'package:cheese/src/ui/image_detail_widget.dart';
import 'package:cheese/src/ui/bias_following_widget.dart';
import 'package:cheese/src/ui/image_list_category_widget.dart';


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
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) {
      queryWidth = maxWidth;
    }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) {
      queryHeight = maxHeight;
    }
    return Scaffold(
      backgroundColor: _style.mainWhiteColor,
      floatingActionButton: Container(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ImageUploadWidget())
            );
          },
          child: Image.asset('images/assets/upload_button.png'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          TopBarWidget(),
          Column(
            children:[
              Container(
                width: queryWidth,
                height: 78,
              ),
              Container(
                width: queryWidth,
                height: queryHeight - 110,
                child: HomeWidget()
              ),
            ]
          ),
          Column(
              children:[
                Container(
                  width: queryWidth,
                  height: queryHeight - 60,
                  //color: Colors.grey,
                ),
                BottomBarWidget()
              ]
          )
        ],
      )
    );

      /*

       */
  }
}
// TopBarWidget
class TopBarWidget extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBarWidget> {
  final double appBarHeight = 78;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(horizontal: 25.0), // 좌우 간격
      height: appBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 가운데 간격
        children: [
          Container(
            height : 27.5,
            child: Image.asset(
              'images/assets/eng_logo.png', // 이미지 경로
            ),
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


class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CoreBloc, CoreState>(
      builder: (context, state)
      {
      if (state is NoneBiasState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                child: BiasWidget(),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                // child: CalendarWidget(),
                child: CalendarWidget2(),
              ),

              // // HomebodyWidget
              // Padding(
              //   padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
              //   child:
              //   HomeBodyWidget(selectedDate: DateTime.now()), // 오늘 날짜를 임의로 넣음
              // ),

              // HomebodyWidget2
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                child:
                HomeBodyWidget2(selectedDate: DateTime.now()), // 오늘 날짜를 임의로 넣음
              ),
              // 다른 위젯 추가
            ],
          ),
        );
      } else {
        return Container(
            child: Text('로딩 중 ~~')
        );
      }
    });
  }
}


class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  final double bottomBarHeight = 60;
  final maxWidth = 400.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    return Container(
      width: queryWidth,
      height: bottomBarHeight,
      color: Color(0xff232323),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home, color : Colors.white),
          Container(
            width: queryWidth * 0.15,
          ),
          Icon(Icons.search, color : Colors.white),
        ],
      )
    );
  }
}


// BiasWidget
class BiasWidget extends StatefulWidget {
  @override
  _BiasState createState() => _BiasState();
}

class _BiasState extends State<BiasWidget> {
  final List<String> _items = ['Item 1','Item 1','Item 1','Item 1']; // 가상의 데이터 리스트

  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  final double minHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery
        .of(context)
        .size
        .width;
    if (queryWidth > maxWidth) {
      queryWidth = maxWidth;
    }

    double queryHeight = MediaQuery
        .of(context)
        .size
        .height;
    if (queryHeight > maxHeight) {
      queryHeight = maxHeight;
    }
    double mainHeight = max(
        queryHeight * 0.18, minHeight); // minHeight와 비교하여 더 큰 값을 선택

    return BlocBuilder<CoreBloc, CoreState>(
      builder: (context, state) {
        return biasWidgetBody(queryWidth, mainHeight, state);
      }
    );
  }

  Widget biasWidgetBody(queryWidth, mainHeight, state){
      return ConstrainedBox(
        // minHeight를 보장하기 위한 ConstrainedBox 추가
        constraints: BoxConstraints(minHeight: minHeight), // 최소 높이 설정
        child: Container(
          decoration: _style.mainBoxDecoration,
          width: queryWidth,
          height: 40,
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                width: queryWidth * 0.86,
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 9,
                      width: 9,
                      child: Icon(Icons.more_vert), // 오른쪽 상단에 위치하는 아이콘
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 8),
                  height: mainHeight * 0.48, // Specify the height to allow scrolling
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Set horizontal scrolling
                    itemCount: state.homeDataModel.biases.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: _biasProfile(
                          width: queryWidth,
                          height: mainHeight,
                          biasName: state.homeDataModel.biases[index].bname, // Use actual data
                          biasId: state.homeDataModel.biases[index].bid, // Use actual data
                          url: state.homeDataModel.biases[index].bid,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _biasProfile({
    required double width,
    required double height,
    required String biasName,
    required String biasId,
    required String url,
  }) {
    if (biasId == "0000"){
      return InkWell(
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BiasFollowingWidget())
          );
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [_style.mainBoxShadow],
              ),
              child: CircleAvatar(
                radius: height * 0.17, // 원의 크기 설정
                backgroundColor:  Colors.black26,
                child: const Icon(Icons.add, color: Colors.black54),
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
        ),
      );
    }else{
      return
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [_style.mainBoxShadow],
              ),
              child: CircleAvatar(
                  radius: height * 0.17, // 원의 크기 설정
                  //backgroundImage: AssetImage('images/assets/chodan.jpg'), // 이미지 경로
                  backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/${url}.jpg")
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
}

// CalenderWidget
class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }
    return Container(
      width: queryWidth,
        height: 420,
        decoration: _style.calenderBoxShadow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 연도와 월을 화살표와 함께 표시
            Container(
              width: queryWidth * 0.9,
              height : 28,
              padding: EdgeInsets.only(top: 10.0),
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

             // _style.calenderDevider,
            Expanded(
              child: Transform.scale(
                scale: 0.9,
                child: TableCalendar(
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
                      String date = DateFormat('yyyy/MM/dd').format(selectedDay);
                      print(date);
                      BlocProvider.of<CoreBloc>(context).add(NoneBiasHomeDataEvent(date));

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
              )
            ),
            _style.calenderDevider,
          ],
        ),
      );
  }
}

// CalenderWidget
class CalendarWidget2 extends StatefulWidget {
  @override
  _CalendarWidgetState2 createState() => _CalendarWidgetState2();
}

class _CalendarWidgetState2 extends State<CalendarWidget2> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }
    return Container(
      width: queryWidth,
      height: 420,
      decoration: _style.calenderBoxShadow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 연도와 월을 화살표와 함께 표시
          Container(
            width: queryWidth * 0.9,
            height : 28,
            padding: EdgeInsets.only(top: 10.0),
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

          // _style.calenderDevider,
          Expanded(
              child: Transform.scale(
                scale: 0.9,
                child: TableCalendar(
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
                      String date = DateFormat('yyyy/MM/dd').format(selectedDay);
                      print(date);
                      BlocProvider.of<CoreBloc>(context).add(NoneBiasHomeDataEvent(date));

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
              )
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

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
          if (state is NoneBiasState){
              if (state.homeDataModel.homeBodyData.length == 0){
                return Container(
                  child : Text("텅~!")
                );
              }
              else{
                Map core_data= state.homeDataModel.homeBodyData[0];
                var maked_date = DateFormat('yyyy/MM/dd').parse(state.date);
                formattedDate = DateFormat('dd').format(maked_date);
                weekDay = _weekDays[maked_date.weekday - 1];

                // schedule_data에 따라 _buildTimelineSection을 동적으로 생성
                List<Widget> timelineSections = [];
                int numSchedule = 0;
                for (var schedule in core_data['schedule_data']) {
                  timelineSections.add(_buildTimelineSection(context, state, numSchedule));
                  numSchedule++;
                }

                return Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  child: Column(
                    children: [
                      // 첫 번째 파트: 날짜와 요일
                      _buildDateAndWeekDay(formattedDate, weekDay, state),
                      // 두 번째 파트: 사진이랑 이름
                      _buildProfileSection(state),
                      // 세 번째 파트: 타임라인
                      Container(height: 20.0),
                      for (var section in timelineSections) section, // 동적으로 생성된 타임라인 섹션 추가
                    ],
                  ),
                );
              }
          }else{
            return Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
              child: Column(
                children: [
                  // 첫 번째 파트: 날짜와 요일
                  _buildDateAndWeekDay(formattedDate, weekDay, state),
                  // 두 번째 파트: 사진이랑 이름
                  _buildProfileSection(state),
                  // 세 번째 파트: 타임라인
                  _buildTimelineSection(context, state, 0),
                  _buildTimelineSection(context, state, 0),
                ],
              ),
            );
          }
        }
    );
  }

  Padding _buildDateAndWeekDay(String formattedDate, String weekDay, state) {
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

  Padding _buildProfileSection(state) {
    Map core_data= state.homeDataModel.homeBodyData[0];
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 0.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/${core_data['bid']}.jpg")
                //AssetImage('images/assets/chodan.jpg'), // 이미지 경로 수정 필요
          ),
          InkWell(
            onTap:(){
              BlocProvider.of<CoreBloc>(context).add(ImageListCategoryEvent(core_data['bid']));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImageListByCategoryWidget())
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                core_data['bname'],
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }



  Padding _buildTimelineSection(BuildContext context, state, numSchedule) {
    Map core_data = state.homeDataModel.homeBodyData[0];
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineDotLine(),
          Expanded(child: _buildEventSection(context, core_data, numSchedule)), // 추가: 남은 공간을 차지하도록 확장
        ],
      ),
    );
  }


  Column _buildTimelineDotLine() {
    return Column(
      children: [
        CircleAvatar(
          radius: 5, // 원 크기 바꿀 필요 없기에 고정값으로
          backgroundColor: _style.mainLineColor,
        ),
        Container(
          width: 2, // 두께라서 고정값으로
          height: maxHeight * 0.2, // 타임라인 길이 설정 (->0.19)
          color: _style.mainLineColor,
        ),
      ],
    );
  }

  Column _buildEventSection(BuildContext context, core_data, numSchedule) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEventTitle(context, core_data, numSchedule),
        _buildEventGallery(context, core_data, numSchedule),
      ],
    );
  }

  Padding _buildEventTitle(BuildContext context, core_data, numSchedule) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0), // 오른쪽 여백 추가
      child: InkWell(
        onTap: (){
          BlocProvider.of<CoreBloc>(context).add(ImageListCategoryByScheduleEvent(core_data['bid'],
            core_data['schedule_data'][numSchedule]['sid']));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ImageListCategoryByScheduleWidget())
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              core_data['schedule_data'][numSchedule]['schedule_name'],
              style: _style.eventTitle,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.0, // 아이콘 사이즈도 바꾸지 X것 같으므로 고정값
            ),
          ],
        ),
      )
    );
  }

  Padding _buildEventGallery(BuildContext context, core_data, numSchedule) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      child: Container(
        width: maxWidth, // 상세 사진(회색) 가로 사이즈
        height: maxHeight * 0.13, // 세로 사이즈
        margin: EdgeInsets.only(right: 10),
        decoration: _style.eventGalleryBox,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: core_data['schedule_data'][numSchedule]['image_url'].length, // 내부 사각형 개수 -> 추후 바꾸기
          itemBuilder: (context, index) => _buildGalleryItem(index, core_data, numSchedule),
        ),
      ),
    );
  }

  Widget _buildGalleryItem(int index, core_data, numSchedule) {
    String url =  core_data['schedule_data'][numSchedule]['image_url'][index];
    String iid = url.split('.').first;
    return InkWell(
      onTap:(){
        BlocProvider.of<CoreBloc>(context).add(DetailImageDataEvent(iid));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ImageDetailWidget())
        );
      },
        child:Align(
          alignment: Alignment.center,
          child: Container(
              //width: maxHeight * 0.10, // 내부 상세사진(보라) 높이
              //height: maxHeight * 0.10, // 세로 높이
              decoration: _style.galleryBox,
              margin: EdgeInsets.only(left:10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: SizedBox(
                    width : maxHeight * 0.09,
                    height : maxHeight * 0.09,
                    child:Image.network("https://kr.object.ncloudstorage.com/cheese-images/${url}", fit:BoxFit.cover)
                )
              )
          ),
        )
    );
  }
}

// HomeBodyWidget2
class HomeBodyWidget2 extends StatefulWidget {
  final DateTime selectedDate; // Calendar에서 선택한 날짜

  HomeBodyWidget2({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _HomeBodyState2 createState() => _HomeBodyState2();
}

class _HomeBodyState2 extends State<HomeBodyWidget2> {
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

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
          if (state is NoneBiasState){
            if (state.homeDataModel.homeBodyData.length == 0){
              return Container(
                  child : Text("텅~!")
              );
            }
            else{
              Map core_data= state.homeDataModel.homeBodyData[0];
              var maked_date = DateFormat('yyyy/MM/dd').parse(state.date);
              formattedDate = DateFormat('dd').format(maked_date);
              weekDay = _weekDays[maked_date.weekday - 1];

              // schedule_data에 따라 _buildTimelineSection을 동적으로 생성
              List<Widget> timelineSections = [];
              int numSchedule = 0;
              for (var schedule in core_data['schedule_data']) {
                timelineSections.add(_buildTimelineSection(context, state, numSchedule));
                numSchedule++;
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                child: Column(
                  children: [
                    // 첫 번째 파트: 날짜와 요일
                    _buildDateAndWeekDay(formattedDate, weekDay, state),
                    // 두 번째 파트: 사진이랑 이름
                    _buildProfileSection(state),
                    // 세 번째 파트: 타임라인
                    Container(height: 20.0),
                    for (var section in timelineSections) section, // 동적으로 생성된 타임라인 섹션 추가
                  ],
                ),
              );
            }
          }else{
            return Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
              child: Column(
                children: [
                  // 첫 번째 파트: 날짜와 요일
                  _buildDateAndWeekDay(formattedDate, weekDay, state),
                  // 두 번째 파트: 사진이랑 이름
                  _buildProfileSection(state),
                  // 세 번째 파트: 타임라인
                  _buildTimelineSection(context, state, 0),
                  _buildTimelineSection(context, state, 0),
                ],
              ),
            );
          }
        }
    );
  }

  Padding _buildDateAndWeekDay(String formattedDate, String weekDay, state) {
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

  Padding _buildProfileSection(state) {
    Map core_data= state.homeDataModel.homeBodyData[0];

    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 0.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/${core_data['bid']}.jpg")
            //AssetImage('images/assets/chodan.jpg'),
            // 이미지 경로 수정 필요
          ),
          InkWell(
            onTap:(){
              BlocProvider.of<CoreBloc>(context).add(ImageListCategoryEvent(core_data['bid']));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImageListByCategoryWidget())
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                core_data['bname'],
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Spacer(), // 남은 공간을 차지하는 위젯
          DropdownWidget(),// DropdownWidget
        ],
      ),
    );
  }

  Padding _buildTimelineSection(BuildContext context, state, numSchedule) {
    Map core_data = state.homeDataModel.homeBodyData[0];
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineDotLine(),
          Expanded(child: _buildEventSection(context, core_data, numSchedule)), // 추가: 남은 공간을 차지하도록 확장
        ],
      ),
    );
  }


  Column _buildTimelineDotLine() {
    return Column(
      children: [
        CircleAvatar(
          radius: 5, // 원 크기 바꿀 필요 없기에 고정값으로
          backgroundColor: _style.mainLineColor,
        ),
        Container(
          width: 2, // 두께라서 고정값으로
          height: maxHeight * 0.2, // 타임라인 길이 설정 (->0.19)
          color: _style.mainLineColor,
        ),
      ],
    );
  }

  Column _buildEventSection(BuildContext context, core_data, numSchedule) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEventTitle(context, core_data, numSchedule),
        _buildEventGallery(context, core_data, numSchedule),
      ],
    );
  }

  Padding _buildEventTitle(BuildContext context, core_data, numSchedule) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0), // 오른쪽 여백 추가
        child: InkWell(
          onTap: (){
            BlocProvider.of<CoreBloc>(context).add(ImageListCategoryByScheduleEvent(core_data['bid'],
                core_data['schedule_data'][numSchedule]['sid']));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ImageListCategoryByScheduleWidget())
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                core_data['schedule_data'][numSchedule]['schedule_name'],
                style: _style.eventTitle,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.0, // 아이콘 사이즈도 바꾸지 X것 같으므로 고정값
              ),
            ],
          ),
        )
    );
  }

  Padding _buildEventGallery(BuildContext context, core_data, numSchedule) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      child: Container(
        width: maxWidth, // 상세 사진(회색) 가로 사이즈
        height: maxHeight * 0.13, // 세로 사이즈
        margin: EdgeInsets.only(right: 10),
        decoration: _style.eventGalleryBox,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: core_data['schedule_data'][numSchedule]['image_url'].length, // 내부 사각형 개수 -> 추후 바꾸기
          itemBuilder: (context, index) => _buildGalleryItem(index, core_data, numSchedule),
        ),
      ),
    );
  }

  Widget _buildGalleryItem(int index, core_data, numSchedule) {
    String url =  core_data['schedule_data'][numSchedule]['image_url'][index];
    String iid = url.split('.').first;
    return InkWell(
        onTap:(){
          BlocProvider.of<CoreBloc>(context).add(DetailImageDataEvent(iid));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImageDetailWidget())
          );
        },
        child:Align(
          alignment: Alignment.center,
          child: Container(
            //width: maxHeight * 0.10, // 내부 상세사진(보라) 높이
            //height: maxHeight * 0.10, // 세로 높이
              decoration: _style.galleryBox,
              margin: EdgeInsets.only(left:10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: SizedBox(
                      width : maxHeight * 0.09,
                      height : maxHeight * 0.09,
                      child:Image.network("https://kr.object.ncloudstorage.com/cheese-images/${url}", fit:BoxFit.cover)
                  )
              )
          ),
        )
    );
  }
}

class DropdownWidget extends StatefulWidget {
  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String _selectedText = '오프라인';
  IconData _selectedIcon = Icons.circle;

  final Map<String, Color> _colorMap = {
    '전체': Color(0xFFF7CE52),
    '온라인': Color(0xFF675DEF),
    '오프라인': Color(0xFFF7CE52),
  };

  void _onSelected(String value, IconData icon) {
    setState(() {
      _selectedText = value;
      _selectedIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.white, // 팝업 메뉴 배경색 설정
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1.0), // 외곽선 색상과 두께 설정
            borderRadius: BorderRadius.circular(8.0), // 모서리 반경 설정
          ),
        ),
      ),
      child: Container(
        child: OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0), // 버튼의 패딩 조정
            minimumSize: Size(0, 20), // 버튼의 최소 세로 길이 조정
            side: BorderSide(color: Colors.grey, width: 1.0), // 외곽선 색상과 두께 설정
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 버튼의 터치 영역 조정
          ),
          child: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == '전체') {
                _onSelected(value, Icons.circle);
              } else if (value == '온라인') {
                _onSelected(value, Icons.circle);
              } else if (value == '오프라인') {
                _onSelected(value, Icons.circle);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: '전체',
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 12, color: Color(0xFFF7CE52)),
                      Container(width: 8),
                      Text('전체'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: '온라인',
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 12, color: Color(0xFF675DEF)), // 적절한 아이콘 추가
                      Container(width: 8),
                      Text('온라인'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: '오프라인',
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 12, color: Color(0xFFF7CE52)),
                      Container(width: 8),
                      Text('오프라인'),
                    ],
                  ),
                ),
              ];
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  _selectedIcon,
                  size: 12,
                  color: _colorMap[_selectedText], // 선택된 아이콘 색상 설정
                ),
                Container(width: 8),
                Text(
                  _selectedText,
                  style: TextStyle(
                    color: Colors.black, // 텍스트 색상 설정
                    fontSize: 12, // 폰트 크기 설정
                    fontWeight: FontWeight.normal, // 폰트 굵기 설정
                  ),
                ),
                Container(width: 1),
                Icon(Icons.arrow_drop_down, size: 24), // 드롭다운 아이콘
              ],
            ),
          ),
        ),
      ),
    );
  }
}

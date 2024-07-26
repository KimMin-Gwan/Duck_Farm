import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cheese/src/ui/styles/home_theme.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateFormat _dateFormat = DateFormat("yyy/MM/dd");

  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;

  Map _events = {};

  Map _makeEventsMap(Map dateList){
    Map dateTimeMap = {};

    for (var singleData in dateList.entries ){
      DateTime date = _dateFormat.parse(singleData.key);
      dateTimeMap[date] = singleData.value;
    }
    return dateTimeMap;
  }


  @override
  Widget build(BuildContext context){
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
          if (state is NoneBiasState) {
            _events = _makeEventsMap(state.homeDataModel.calenderData);
            return calendarArea(queryWidth, queryHeight);
          }else{
            return calendarArea(queryWidth, queryHeight);
          }
        }
    );
  }


  Widget calendarArea(queryWidth, queryHeight) {
    return Stack(
      children: [
        /*
        Image.network(
            "https://kr.object.ncloudstorage.com/cheese-images/1001-1.jpg",
            fit: BoxFit.cover,
            width: queryWidth,
            height: 530
        ),
        
         */
        Opacity(
            opacity: 1,
            child: Container(
              width: queryWidth,
              height: 530,
              decoration: _style.calenderBoxShadow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 연도와 월을 화살표와 함께 표시
                  Container(
                    width: queryWidth * 0.9,
                    height: 60,
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_left),
                          onPressed: () {
                            setState(() {
                              _focusedDay = DateTime(
                                  _focusedDay.year, _focusedDay.month - 1);
                            });
                          },
                        ),
                        Text(
                          DateFormat('MMMM, yyyy').format(_focusedDay),
                          style: _style.monthYear,
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: () {
                            setState(() {
                              _focusedDay = DateTime(
                                  _focusedDay.year, _focusedDay.month + 1);
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
                            //print(date);
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
                        eventLoader: (day) {
                          // 날짜 비교 시 시간을 무시
                          return _events[DateTime(day.year, day.month, day.day)] ?? [];
                        },
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, events) {
                            if (events.isNotEmpty) {
                              List iconEvents = events;
                              return Container(
                                height: 20,  // Stack 높이 설정
                                child: Stack(
                                  children: List.generate(iconEvents.length, (index) {
                                    String key = iconEvents[index];
                                    return Positioned(
                                      left: index * 10.0,  // 겹치는 정도 조절 (반씩 겹치기 위해 10.0으로 설정)
                                      child: CircleAvatar(
                                        //backgroundColor: color,
                                        backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/T${key}.jpg"),
                                        radius: 10,
                                      ),
                                    );
                                  }),
                                ),
                              );
                            }
                            return Container(); // 이벤트가 없을 경우 빈 컨테이너 반환
                          },
                        ),

                      ),
                    ),
                  ),
                  _style.calenderDevider,
                ],
              ),
            )
        )
      ],
    );

  }
}

// CalenderWidget2
class CalendarWidget2 extends StatefulWidget {
  @override
  _CalendarWidgetState2 createState() => _CalendarWidgetState2();
}

class _CalendarWidgetState2 extends State<CalendarWidget2> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateFormat _dateFormat = DateFormat("yyy/MM/dd");

  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;

  Map _events = {};

  Map _makeEventsMap(Map dateList){
    Map dateTimeMap = {};

    for (var singleData in dateList.entries ){
      DateTime date = _dateFormat.parse(singleData.key);
      dateTimeMap[date] = singleData.value;
    }
    return dateTimeMap;
  }


  @override
  Widget build(BuildContext context){
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
          if (state is BiasState) {
            _events = _makeEventsMap(state.homeDataModel.calenderData);
            return calendarArea(queryWidth, queryHeight, state);
          }else{
            return calendarArea(queryWidth, queryHeight, state);
          }
        }
    );
  }


  Widget calendarArea(queryWidth, queryHeight, state) {
    return Stack(
      children: [
        /*
        Image.network(
            "https://kr.object.ncloudstorage.com/cheese-images/1001-1.jpg",
          fit: BoxFit.cover,
          width: queryWidth,
          height: 530
        ),

         */
        Opacity(
          opacity: 1,
            child: Container(
              width: queryWidth,
              height: 530,
              decoration: _style.calenderBoxShadow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 연도와 월을 화살표와 함께 표시
                  Container(
                    width: queryWidth * 0.9,
                    height: 60,
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_left),
                          onPressed: () {
                            setState(() {
                              _focusedDay = DateTime(
                                  _focusedDay.year, _focusedDay.month - 1);
                            });
                          },
                        ),
                        Text(
                          DateFormat('MMMM, yyyy').format(_focusedDay),
                          style: _style.monthYear,
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: () {
                            setState(() {
                              _focusedDay = DateTime(
                                  _focusedDay.year, _focusedDay.month + 1);
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
                            //print(date);
                            BlocProvider.of<CoreBloc>(context).add(BiasHomeDataEvent(date,state.targetBid));
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
                        eventLoader: (day) {
                          // 날짜 비교 시 시간을 무시
                          return _events[DateTime(day.year, day.month, day.day)] ?? [];
                        },
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, events) {
                            if (events.isNotEmpty) {
                              List iconEvents = events;
                              return Container(
                                height: 20,  // Stack 높이 설정
                                child: Stack(
                                  children: List.generate(iconEvents.length, (index) {
                                    String key = iconEvents[index];
                                    Color iconColor = Colors.red;
                                    if (key == "offline"){
                                      iconColor = Colors.blue;
                                    }
                                    return Positioned(
                                      left: index * 10.0,  // 겹치는 정도 조절 (반씩 겹치기 위해 10.0으로 설정)
                                      child: CircleAvatar(
                                        backgroundColor: iconColor,
                                        radius: 10,
                                      ),
                                    );
                                  }),
                                ),
                              );
                            }
                            return Container(); // 이벤트가 없을 경우 빈 컨테이너 반환
                          },
                        ),

                      ),
                    ),
                  ),
                  _style.calenderDevider,
                ],
              ),
            )
        )
      ],
    );

  }
}



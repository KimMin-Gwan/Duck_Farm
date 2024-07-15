import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cheese/src/ui/styles/home_theme.dart';

// CalenderWidget
class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
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
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left),
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
                  icon: const Icon(Icons.arrow_right),
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

  final Map<DateTime, List> _events = {
    DateTime(2024, 6, 2): [{'iconIndex': 1}],
    DateTime(2024, 7, 2): [{'iconIndex': 1},{'iconIndex': 2}, {'iconIndex': 3}],
    // 더 많은 이벤트 추가 가능
  };

  Map _makeEventsMap(List dateList){
    Map dateTimeMap = {};

    for (var singleDate in dateList){
      String dateTime = singleDate['date'];
      DateTime date = _dateFormat.parse(dateTime);
      bool isKeyExist = dateTimeMap.containsKey(date);
      if (isKeyExist){
        dateTimeMap[date] = singleDate
      }

    }

    return dateTimeMap;
  }



  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) {
      queryWidth = maxWidth;
    }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로 한정
    if (queryHeight > maxHeight) {
      queryHeight = maxHeight;
    }
    return Container(
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
                            Map key = iconEvents[index];
                            Color color;
                            switch (key['iconIndex']) {
                              case 1:
                                color = Colors.purpleAccent;
                                break;
                              case 2:
                                color = Colors.blueAccent;
                                break;
                              case 3:
                                color = Colors.redAccent;
                                break;
                              default:
                                color = Colors.grey; // 기본값으로 회색 사용
                            }
                            return Positioned(
                              left: index * 10.0,  // 겹치는 정도 조절 (반씩 겹치기 위해 10.0으로 설정)
                              child: CircleAvatar(
                                backgroundColor: color,
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
    );
  }
}



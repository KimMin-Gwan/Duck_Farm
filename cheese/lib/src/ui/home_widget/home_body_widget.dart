import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cheese/src/ui/styles/home_theme.dart';
import 'package:cheese/src/ui/image_detail/image_detail_widget.dart';
import 'package:cheese/src/ui/image_list/image_list_category_widget.dart';

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
                  child : const Text("텅~!")
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
              backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/T${core_data['bid']}.jpg")
            //AssetImage('images/assets/chodan.jpg'), // 이미지 경로 수정 필요
          ),
          InkWell(
            onTap:(){
              BlocProvider.of<CoreBloc>(context).add(ImageListCategoryEvent(core_data['bid'], 'like'));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ImageListByCategoryWidget())
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                core_data['bname'],
                style: const TextStyle(fontSize: 16),
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
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
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
                core_data['schedule_data'][numSchedule]['sid'], 'like'));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ImageListCategoryByScheduleWidget())
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                core_data['schedule_data'][numSchedule]['sname'],
                style: _style.eventTitle,
              ),
              const Icon(
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
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      child: Container(
        width: maxWidth, // 상세 사진(회색) 가로 사이즈
        height: maxHeight * 0.13, // 세로 사이즈
        margin: const EdgeInsets.only(right: 10),
        decoration: _style.eventGalleryBox,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: core_data['schedule_data'][numSchedule]['iids'].length, // 내부 사각형 개수 -> 추후 바꾸기
          itemBuilder: (context, index) => _buildGalleryItem(index, core_data, numSchedule),
        ),
      ),
    );
  }

  Widget _buildGalleryItem(int index, core_data, numSchedule) {
    String url =  core_data['schedule_data'][numSchedule]['iids'][index];
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
              margin: const EdgeInsets.only(left:10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: SizedBox(
                      width : maxHeight * 0.09,
                      height : maxHeight * 0.09,
                      child:Image.network("https://kr.object.ncloudstorage.com/cheese-images/T${url}.jpg", fit:BoxFit.cover)
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
          if (state is BiasState){
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
              backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/T${core_data['bid']}.jpg")
            //AssetImage('images/assets/chodan.jpg'),
            // 이미지 경로 수정 필요
          ),
          InkWell(
            onTap:(){
              BlocProvider.of<CoreBloc>(context).add(ImageListCategoryEvent(core_data['bid'], 'like'));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImageListByCategoryWidget())
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                core_data['bname'],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const Spacer(), // 남은 공간을 차지하는 위젯
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
                core_data['schedule_data'][numSchedule]['sid'], 'like'));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ImageListCategoryByScheduleWidget())
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                core_data['schedule_data'][numSchedule]['sname'],
                style: _style.eventTitle,
              ),
              const Icon(
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
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      child: Container(
        width: maxWidth, // 상세 사진(회색) 가로 사이즈
        height: maxHeight * 0.13, // 세로 사이즈
        margin: const EdgeInsets.only(right: 10),
        decoration: _style.eventGalleryBox,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: core_data['schedule_data'][numSchedule]['iids'].length, // 내부 사각형 개수 -> 추후 바꾸기
          itemBuilder: (context, index) => _buildGalleryItem(index, core_data, numSchedule),
        ),
      ),
    );
  }

  Widget _buildGalleryItem(int index, core_data, numSchedule) {
    String url =  core_data['schedule_data'][numSchedule]['iids'][index];
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
              margin: const EdgeInsets.only(left:10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: SizedBox(
                      width : maxHeight * 0.09,
                      height : maxHeight * 0.09,
                      child:Image.network("https://kr.object.ncloudstorage.com/cheese-images/T${url}.jpg", fit:BoxFit.cover)
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
    '전체': const Color(0xFFF7CE52),
    '온라인': const Color(0xFF675DEF),
    '오프라인': const Color(0xFFF7CE52),
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
            side: const BorderSide(color: Colors.grey, width: 1.0), // 외곽선 색상과 두께 설정
            borderRadius: BorderRadius.circular(8.0), // 모서리 반경 설정
          ),
        ),
      ),
      child: Container(
        child: OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0), // 버튼의 패딩 조정
            minimumSize: Size(0, 20), // 버튼의 최소 세로 길이 조정
            side: const BorderSide(color: Colors.grey, width: 1.0), // 외곽선 색상과 두께 설정
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
                      const Icon(Icons.circle, size: 12, color: Color(0xFFF7CE52)),
                      Container(width: 8),
                      const Text('전체'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: '온라인',
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 12, color: Color(0xFF675DEF)), // 적절한 아이콘 추가
                      Container(width: 8),
                      const Text('온라인'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: '오프라인',
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 12, color: Color(0xFFF7CE52)),
                      Container(width: 8),
                      const Text('오프라인'),
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
                  style: const TextStyle(
                    color: Colors.black, // 텍스트 색상 설정
                    fontSize: 12, // 폰트 크기 설정
                    fontWeight: FontWeight.normal, // 폰트 굵기 설정
                  ),
                ),
                Container(width: 1),
                const Icon(Icons.arrow_drop_down, size: 24), // 드롭다운 아이콘
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/ui/home_widget/bias_widget.dart';
import 'package:cheese/src/ui/home_widget/calender_widget.dart';
import 'package:cheese/src/ui/home_widget/home_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/ui/home_widget/bar_widgets.dart';
import 'package:cheese/src/ui/styles/home_theme.dart';
import 'package:cheese/src/ui/upload_widget.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/ui/home_widget/bias_following_widget.dart';
import 'package:cheese/src/ui/home_widget/bias_add_widget.dart';

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
    double queryHeight = MediaQuery.of(context).size.height;

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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Image.asset('images/assets/upload_button.png'),
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
                      child: const HomeWidget()
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
                  const BottomBarWidget()
                ]
            )
          ],
        )
    );
  }
}


class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final double minHeight = 100.0;
  final HomeTheme _style = HomeTheme(); // 테마
  String targetBid = "";

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
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child: biasWidget(context),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                    // child: CalendarWidget(),
                    child: CalendarWidget(),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                    child:
                    HomeBodyWidget(selectedDate: DateTime.now()), // 오늘 날짜를 임의로 넣음
                  ),
                  // 다른 위젯 추가
                ],
              ),
            );
          } else if(state is BiasState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child: biasWidget(context),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                    // child: CalendarWidget(),
                    child: CalendarWidget2(),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                    child:
                    HomeBodyWidget2(selectedDate: DateTime.now()), // 오늘 날짜를 임의로 넣음
                  ),
                  // 다른 위젯 추가
                ],
              ),
            );
          } else {
            return Container(
                child: const Text('로딩 중 ~~')
            );
          }
        });
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimatedScrollableBottomSheet(); // 제작한 바텀 시트 반환한다
      },
    );
  }

  Widget biasWidget(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    double mainHeight = max(
        queryHeight * 0.18, minHeight); // minHeight와 비교하여 더 큰 값을 선택

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
          return biasWidgetBody(queryWidth, mainHeight, state);
        }
    );
  }

  Widget biasWidgetBody(queryWidth, mainHeight, state){
    return BlocListener<CoreBloc, CoreState>(
        listener: (context, state) {
          if (state is BiasState) {
            setState(() {
              targetBid = state.targetBid;
            });
          } else{
            setState(() {
              targetBid = "";
            });
          }
        },
    child: ConstrainedBox(
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
                      height: 22,
                      width: 22,
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<CoreBloc>(context).add(BiasListEvent());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BiasFollowingWidget())
                          );
                        },
                        child:Icon(Icons.more_vert), // 오른쪽 상단에 위치하는 아이콘
                      )
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 8),
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
                          state: state
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }

  Widget _biasProfile({
    required double width,
    required double height,
    required String biasName,
    required String biasId,
    required String url,
    required CoreState state,
  }) {
    if (state is NoneBiasState){
      if (biasId == "0000"){
        return InkWell(
          onTap: () => _showModalBottomSheet(context),
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
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  biasName, // 텍스트
                  style: _style.biasName,
                ),
              )
            ],
          ),
        );
      }else {
        return InkWell(
            onTap: (){
              BlocProvider.of<CoreBloc>(context).add(BiasHomeDataEvent.none_date(url));
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [_style.mainBoxShadow],
                  ),
                  child:CircleAvatar(
                      radius: height * 0.17, // 원의 크기 설정
                      //backgroundImage: AssetImage('images/assets/chodan.jpg'), // 이미지 경로
                      backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/T${url}.jpg",
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    biasName, // 텍스트
                    style: _style.biasName,
                  ),
                )
              ],
            )
        );
      }
    }else{
      if (biasId == "0000"){
        return InkWell(
          onTap: () => _showModalBottomSheet(context),
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
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  biasName, // 텍스트
                  style: _style.biasName,
                ),
              )
            ],
          ),
        );
      }else if(biasId == targetBid){
        return InkWell(
            onTap: (){
              BlocProvider.of<CoreBloc>(context).add(BiasHomeDataEvent.none_date(url));
            },
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [_style.mainBoxShadow],
                    ),
                    child: Stack(
                      children: [
                        CircleAvatar(
                            radius: height * 0.17, // 원의 크기 설정
                            //backgroundImage: AssetImage('images/assets/chodan.jpg'), // 이미지 경로
                            backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/T${url}.jpg",
                            )
                        ),
                      ],
                    )

                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    biasName, // 텍스트
                    style: _style.biasName,
                  ),
                )
              ],
            )
        );
      }else{
        return InkWell(
            onTap: (){
              BlocProvider.of<CoreBloc>(context).add(BiasHomeDataEvent.none_date(url));
            },
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [_style.mainBoxShadow],
                    ),
                    child: Stack(
                      children: [
                        CircleAvatar(
                            radius: height * 0.17, // 원의 크기 설정
                            //backgroundImage: AssetImage('images/assets/chodan.jpg'), // 이미지 경로
                            backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/T${url}.jpg",
                            )
                        ),
                        Container(
                          width: height * 0.34, // CircleAvatar의 두 배 (지름)
                          height: height * 0.34, // CircleAvatar의 두 배 (지름)
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.5), // 배경을 어둡게 하기 위한 반투명 레이어
                          ),
                        )
                      ],
                    )

                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    biasName, // 텍스트
                    style: _style.biasName,
                  ),
                )
              ],
            )
        );
      }
    }
  }
}

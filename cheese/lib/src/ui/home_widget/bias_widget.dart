import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/home_theme.dart';
import 'package:cheese/src/ui/home_widget/bias_following_widget.dart';

// BiasWidget
class BiasWidget extends StatefulWidget {
  @override
  _BiasState createState() => _BiasState();
}

class _BiasState extends State<BiasWidget> {
  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  final double minHeight = 100.0;

  @override
  Widget build(BuildContext context) {
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
          BlocProvider.of<CoreBloc>(context).add(BiasListEvent());
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
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                biasName, // 텍스트
                style: _style.biasName,
              ),
            )
          ],
        ),
      );
    }else{
      return InkWell(
        onTap: (){

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
                  //backgroundImage: AssetImage('images/assets/chodan.jpg'), // 이미지 경로
                  backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/T${url}.jpg")
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
  }
}

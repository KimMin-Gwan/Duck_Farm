import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cheese/src/ui/styles/home_theme.dart';


class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/error.svg', // 이미지 경로를 지정하세요
              width: maxWidth*0.5, // 이미지 너비
              height: maxWidth*0.5, // 이미지 높이
            ),
            Padding(padding: EdgeInsets.only(top: 10.0),
              child: Text(
                '오류가 발생했습니다:(',
                style: TextStyle(fontSize: 16.0), // 텍스트 스타일을 설정하세요
              ),
            ),

          ],
        ),
      ),
    );
  }
}
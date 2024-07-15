import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/sign_widget/login_try_widget.dart';
import 'package:cheese/src/ui/sign_widget/login_widget.dart';

class CompleteSignUpWidget extends StatefulWidget {
  const CompleteSignUpWidget({super.key});

  @override
  State<CompleteSignUpWidget> createState() => _CompleteSignUpWidgetState();
}

class _CompleteSignUpWidgetState extends State<CompleteSignUpWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
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
      body: SafeArea(
        child: Column(
          children: [
            TopBarWidget(),
            mainTitleArea(queryWidth, queryHeight),
            SizedBox(
              height: 20,
            ),
            mainLogoArea(queryWidth, queryHeight),
            TextBodyWidget(),
            BodyWidget().functionButton(queryWidth, queryHeight, '최애 설정하기'),
          ],
        ),
      ),
    );
  }
}

class TextBodyWidget extends StatelessWidget {
  TextBodyWidget({super.key});

  final LoginTheme _style = LoginTheme(); // 테마
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

    return Column(
      children: [
        completeTextArea(queryWidth, queryHeight),
        subTextArea(queryWidth, queryHeight),
      ],
    );
  }
  Widget completeTextArea(width, height){
    return Container(
      child: Text('치즈 가입을 완료하였습니다.'),
    );
  }
  Widget subTextArea(width, height){
    return Container(
      alignment: Alignment.center,
      child: Text('이제 나의 최애를 설정하고\n 보고싶은 날짜의 사진을 편하게 즐겨보세요!'),
    );
  }
}

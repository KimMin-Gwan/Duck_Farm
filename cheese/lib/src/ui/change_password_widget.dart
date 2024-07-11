import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/login_try_widget.dart';

// import 'package:cheese/src/ui/login_widget.dart';
import 'package:cheese/src/ui/member_login_widget.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key});

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;
  String changePassword = '비밀번호를 변경해주세요.';

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
            BodyWidget().titleArea(queryWidth, queryHeight, changePassword),
            LoginBodyWidget().passwordInputArea(queryWidth, queryHeight,'비밀번호'),
            LoginBodyWidget().passwordInputArea(queryWidth, queryHeight,'비밀번호 확인'),
            SizedBox(
              height: 20,
            ),
            completeChangePwd(queryWidth, queryHeight),
          ],
        ),
      ),
    );
  }

  Widget completeChangePwd(width, height) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('비밀번호 변경이 성공적으로 \n완료되었습니다.',),
                actions: [
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: Text('재로그인하기'),
                      ),
                    ),
                  ),
                ],
              );
            });
      },
      child: Container(
        width: width * 0.8,
        height: height * 0.05,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: Text(
          '비밀번호 변경',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

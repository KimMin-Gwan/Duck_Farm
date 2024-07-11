import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/login_try_widget.dart';
import 'package:cheese/src/ui/member_login_widget.dart';

class PasswordCreateWidget extends StatefulWidget {
  const PasswordCreateWidget({super.key});

  @override
  State<PasswordCreateWidget> createState() => _PasswordCreateWidgetState();
}

class _PasswordCreateWidgetState extends State<PasswordCreateWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  String createPassword = '치즈와 함께할 \n비밀번호를 생성해주세요.';
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

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TopBarWidget(),
            BodyWidget().titleArea(queryWidth, queryHeight, createPassword),
            LoginBodyWidget().passwordInputArea(queryWidth, queryHeight,'비밀번호'),
            LoginBodyWidget().passwordInputArea(queryWidth, queryHeight,'비밀번호 확인'),
            SizedBox(
              height: 20,
            ),
            BodyWidget().functionButton(queryWidth, queryHeight, '다음'),
          ],
        ),
      ),
    );
  }
}

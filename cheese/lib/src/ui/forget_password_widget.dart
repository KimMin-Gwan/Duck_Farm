import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/login_try_widget.dart';
import 'package:cheese/src/ui/first_visitor_widget.dart';

class ForgetPasswordWidget extends StatefulWidget {
  const ForgetPasswordWidget({super.key});

  @override
  State<ForgetPasswordWidget> createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {
  final LoginTheme _style = LoginTheme();// 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  String forgetPwd = '비밀번호가 기억나지 않나요?';

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
            BodyWidget().titleArea(queryWidth, queryHeight, forgetPwd),
            EmailBodyWidget(),
            ReTransmitEmailWidget(),
          ],
        ),
      ),
    );
  }
}

class EmailBodyWidget extends StatelessWidget {
  EmailBodyWidget({super.key});

  final LoginTheme _style = LoginTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;
  String infoMail = '가입하신 주소로 비밀번호 변경을 위한\n'
      '메일이 발송되었어요.\n'
      '이메일을 확인한 후 이 페이지로 돌아와주세요.';

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
        Container(
          width: queryWidth * 0.8,
          height: queryHeight * 0.05,
          child: Text("이메일@이메일.com",
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),),
        ),
        Container(
          width: queryWidth * 0.8,
          height: queryHeight * 0.15,
          child: Text(infoMail),
        )
      ],
    );
  }
}




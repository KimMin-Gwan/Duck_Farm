import 'package:cheese/src/ui/sign_widget/login_try_widget.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';

final _formkey = GlobalKey<FormState>();

class MemberLoginWidget extends StatefulWidget {
  const MemberLoginWidget({super.key});

  @override
  State<MemberLoginWidget> createState() => _MemberLoginWidgetState();
}

class _MemberLoginWidgetState extends State<MemberLoginWidget> {
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
            LoginBodyWidget(),
          ],
        ),
      ),
    );
  }
}

class LoginBodyWidget extends StatelessWidget {
  LoginBodyWidget({super.key});

  final LoginTheme _style = LoginTheme();
 // 테마
  final double maxWidth = 400.0;

  final double maxHeight = 900.0;

  bool interaction = false;

  String memberVisit = '치즈 회원이시군요! \n로그인 해주세요.';


  BodyWidget bodyWidget = BodyWidget();

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
        bodyWidget.titleArea(queryWidth, queryHeight, memberVisit),
        bodyWidget.emailInputArea(queryWidth, queryHeight),
        passwordInputArea(queryWidth, queryHeight, '비밀번호를 입력해주세요.'),
        SizedBox(
          height: 20,
        ),
        bodyWidget.functionButton(queryWidth, queryHeight, '로그인'),
        SizedBox(
          height: 20,
        ),
        forgetPassWordArea(queryWidth, queryHeight),
      ],
    );
  }

  Widget passwordInputArea(width, height, text) {
    return Container(
      height: height * 0.1,
      width: width * 0.8,
      child: Form(
        key: _formkey,
        child: TextFormField(
          validator: (value){
            if(value!.isEmpty){
              return '비밀번호가 일치하지 않아요.';
            }else
              return null;
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
            final formKeyState = _formkey.currentState!;
            if(formKeyState.validate()){
              formKeyState.save();
            }
            },
          obscureText: true,
          decoration: InputDecoration(
            label: Text(text),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){},
                  child: Icon(Icons.remove_red_eye,
                  size: 20,),
                ),
                InkWell(
                  onTap: (){},
                  child: Icon(Icons.close,size: 20,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassWordArea(width, height) {
    return InkWell(
      onTap: () {},
      child: Text(
        '비밀번호가 기억나지 않나요?',
        style: TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }
}

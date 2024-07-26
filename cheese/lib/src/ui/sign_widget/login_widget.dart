import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/sign_widget/login_try_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cheese/src/bloc/sign_bloc/sign_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_state.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
        top: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LoginBodyWidget(),
            MiddleWidget(),
            BottomWidget(),
          ],
        ),
      ),
    );
  }
}

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({super.key});

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: queryHeight * 0.1,
        ),
        mainTitleArea(queryWidth, queryHeight),
        SizedBox(
          height: 20,
        ),
        mainLogoArea(queryWidth, queryHeight),
      ],
    );
  }
}

Widget mainTitleArea(width, height) {
  return Text(
    '치즈',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget mainLogoArea(width, height) {
  return Container(
    width: 130,
    height: 130,
    color: Colors.grey,
  );
}

class MiddleWidget extends StatelessWidget {
  MiddleWidget({super.key});
  final LoginTheme _style = LoginTheme();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('카카오톡으로 시작하기'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.yellow,
            fixedSize: _style.emailStartButtonSize,
          ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(
          onPressed: () {},
          child: Text('구글로 시작하기'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            fixedSize: _style.emailStartButtonSize,
          ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(
          onPressed: () {},
          child: Text('네이버로 시작하기'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            fixedSize: _style.emailStartButtonSize,
          ),
        ),
        SizedBox(height: 40,), // 작대기 자리
        ElevatedButton(
          onPressed: () {},
          child: Text('이메일로 시작하기'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            fixedSize: _style.emailStartButtonSize,
          ),
        ),
      ],
    );
  }
}

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
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

    return InkWell(
        onTap: () {
          BlocProvider.of<SignBloc>(context).add(StartSignEvent());
        },
        child: Container(
            alignment: Alignment.center,
            width: queryWidth,
            height: 100,
            child: const Text("로그인 시도하기")));
  }
}

/*
return BlocBuilder<SignBloc, SignState>(
builder: (context, state){
if ( state is EmailInputState){


 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cheese/src/bloc/sign_bloc/sign_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_state.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';

final _formKey = GlobalKey<FormState>();

class LoginTryWidget extends StatefulWidget {
  const LoginTryWidget({super.key});

  @override
  State<LoginTryWidget> createState() => _LoginTryWidgetState();
}

class _LoginTryWidgetState extends State<LoginTryWidget> {
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            TopBarWidget(),
            BodyWidget(),
          ],
        ),
      ),
    );
  }
}

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({super.key});

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
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

    return Container(
      height: queryHeight * 0.1,
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.chevron_left,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  BodyWidget({super.key});

  final LoginTheme _style = LoginTheme();// 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;
  TextEditingController emailEditingController = TextEditingController();
  SignEvent emailInputEvent = EmailInputEvent("");

  String email = '로그인 혹은 회원가입을 위한 \n이메일을 입력해주세요.';
  String emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  // RegExp regExp = RegExp(emailPattern);
  @override
  Widget build(BuildContext context) {
    emailInputEvent = EmailInputEvent(emailEditingController.text);
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
        titleArea(queryWidth, queryHeight, email),
        SizedBox(
          height: 20,
        ),
        emailInputArea(queryWidth, queryHeight),
        SizedBox(
          height: 20,
        ),
        functionButton(queryWidth, queryHeight, '다음', context, emailInputEvent),
      ],
    );
  }

  Widget titleArea(width, height, text) {
    return Container(
      alignment: Alignment.topLeft,
      height: height * 0.1,
      width: width * 0.8,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget emailInputArea(width, height) {
    return Container(
      height: height * 0.1,
      width: width * 0.8,
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: emailEditingController,
          validator: (value){
            if(value!.isEmpty){
              return '이메일을 입력해주세요.';
            }else if(!RegExp(emailPattern).hasMatch(value)){
              return '※ 올바른 이메일 형식을 입력해주세요';
            }else
              return null;
          },
            onTapOutside: (event){
            FocusManager.instance.primaryFocus?.unfocus();
            final formKeyState = _formKey.currentState!;
            if(formKeyState.validate()){
              formKeyState.save();
            }
            },
            decoration: InputDecoration(
              label: Text('이메일'),
              suffixIcon: Icon(Icons.close),
              hintText: '이메일 입력',
            ),
          ),
      ),
    );
  }

  Widget functionButton(width, height, text, context, event) {
    return InkWell(
      onTap: () {
        BlocProvider.of<SignBloc>(context).add(event);
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
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }


}

import 'package:cheese/src/ui/sign_widget/login_try_widget.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';
import 'package:cheese/src/model/sign_model.dart';

final _formKey2 = GlobalKey<FormState>();
final _formKey3 = GlobalKey<FormState>();

class MemberLoginWidget extends StatefulWidget {
  final TryLoginModel tryLoginModel;

  const MemberLoginWidget({super.key, required this.tryLoginModel});

  @override
  State<MemberLoginWidget> createState() => _MemberLoginWidgetState();
}

class _MemberLoginWidgetState extends State<MemberLoginWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
  bool interaction = false;
  late final TryLoginModel tryLoginModel;

  @override
  void initState() {
    super.initState();
    tryLoginModel = widget.tryLoginModel;
  }

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;

    double queryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBarWidget(),
            LoginBodyWidget(tryLoginModel: tryLoginModel,),
          ],
        ),
      ),
    );
  }
}
class LoginBodyWidget extends StatefulWidget {
  final TryLoginModel tryLoginModel;
  const LoginBodyWidget({super.key, required this.tryLoginModel});

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {

  final LoginTheme _style = LoginTheme();
 // 테마
  final double maxWidth = 400.0;

  final double maxHeight = 900.0;

  bool interaction = false;
  bool flag1 = false;
  bool flag2 = false;
  String memberVisit = '치즈 회원이시군요! \n로그인 해주세요.';
  //String email = '로그인 혹은 회원가입을 위한 \n이메일을 입력해주세요.';
  String emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailTextController.text = widget.tryLoginModel.user.email;
    flag1 = true;

  }


  @override
  Widget build(BuildContext context) {
    BodyWidget bodyWidget = BodyWidget(
      emailEditingController: emailTextController);

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
        TitleArea(
            width: queryWidth,
            height: queryHeight,
            text: memberVisit),
        emailInputArea(queryWidth, queryHeight),
        passwordInputArea(queryWidth, queryHeight, '비밀번호를 입력해주세요.'),
        SizedBox(
          height: 20,
        ),
        functionButton(queryWidth, queryHeight,
            '로그인', context,),
        SizedBox(
          height: 20,
        ),
        forgetPassWordArea(queryWidth, queryHeight),
      ],
    );
  }

  Widget functionButton(width, height, text, context) {
    return InkWell(
      onTap: () {
        print(flag1);
        print(flag2);
        if (flag1 && flag2){
          BlocProvider.of<SignBloc>(context).add(
            TryLoginEvent(
                emailTextController.text,
                passwordTextController.text
            )
          );
        }
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

  Widget emailInputArea(width, height) {
    return Container(
      height: height * 0.1,
      width: width * 0.8,
      child: Form(
        key: _formKey2,
        child: TextFormField(
          controller: emailTextController,
          validator: (value){
            if(value!.isEmpty){
              setState(() {
                flag1 = false;
              });
              return '이메일을 입력해주세요.';
            }else if(!RegExp(emailPattern).hasMatch(value)){
              setState(() {
                flag1 = false;
              });
              return '※ 올바른 이메일 형식을 입력해주세요';
            }else if(widget.tryLoginModel.stateCode == "253"){
              return '잘못된 이메일 입니다';
            }
            else{
              setState(() {
                flag1 = true;
              });
            }
          },
          onTapOutside: (event){
            FocusManager.instance.primaryFocus?.unfocus();
            final formKeyState = _formKey2.currentState!;
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

  Widget passwordInputArea(width, height, text) {
    return Container(
      height: height * 0.1,
      width: width * 0.8,
      child: Form(
        key: _formKey3,
        child: TextFormField(
          controller: passwordTextController,
          validator: (value){
            if(value!.isEmpty){
              return '비밀번호를 입력해주세요.';
            } else if(widget.tryLoginModel.stateCode == "252"){
            return '잘못된 비밀번호 입니다';
            }else{
              setState(() {
                flag2 = true;
              });
              return null;
            }
            },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
            final formKeyState = _formKey3.currentState!;
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

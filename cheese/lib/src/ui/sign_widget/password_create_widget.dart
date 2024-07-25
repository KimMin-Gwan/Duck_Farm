import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/sign_widget/login_try_widget.dart';
import 'package:cheese/src/ui/sign_widget/member_login_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cheese/src/bloc/sign_bloc/sign_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_state.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';

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

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController= TextEditingController();
  String createPassword = '치즈와 함께할 \n비밀번호를 생성해주세요.';

  bool flag = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TopBarWidget(),
            TitleArea(
                width:queryWidth,
                height:queryHeight,
                text: createPassword),
            inputPasswordWidget(),
            SizedBox(
              height: 20,
            ),
            functionButton(queryWidth, queryHeight,
                '다음', context,
            ),
          ],
        ),
      ),
    );
  }

  Widget functionButton(width, height, text, context) {
    return InkWell(
      onTap: () {
        if (flag){
          BlocProvider.of<SignBloc>(context).add(
              PasswordInputEvent(
                  passwordTextController.text)
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

  final _formKey = GlobalKey<FormState>();
  String _passwordValue = '';
  String _passwordCheckValue = '';
  bool obscureCreateToggle = true;
  bool obscureCheckToggle = true;

  @override
  Widget inputPasswordWidget() {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          passwordCreatArea(queryWidth, queryHeight,'비밀번호'),
          passwordCheckArea(queryWidth, queryHeight,'비밀번호 확인'),
        ],
      ),
    );
  }

  Widget passwordCreatArea(width, height, text) {
    return Container(
      height: height * 0.1,
      width: width * 0.8,
        child: TextFormField(
          validator: (value){
            if(value!.isEmpty){
              return '비밀번호를 입력해주세요.';
            } else if(value.length < 8 || value.length > 16){
              return '※ 영어 대소문자, 숫자를 포함한 최소 8, 최대 16자로 구성';
            } else
              return null;
          },
          onChanged: (value){
            setState(() {
              _passwordValue = value!;
            });
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
            final formKeyState = _formKey.currentState!;
            if(formKeyState.validate()){
              formKeyState.save();
            }
          },
          obscureText: obscureCreateToggle,
          decoration: InputDecoration(
            label: Text(text),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      obscureCreateToggle = !obscureCreateToggle;
                    });
                  },
                  child: Icon(Icons.remove_red_eye,
                    size: 20,),
                ),
                InkWell(
                  onTap: (){},
                  child: Icon(Icons.close,size: 20,),
                ),
              ],
            ),
            helperText: '※ 영어 대소문자, 숫자를 포함한 최소 8, 최대 16자로 구성',
          ),
        ),
    );
  }

  Widget passwordCheckArea(width, height, text) {
    return Container(
      height: height * 0.1,
      width: width * 0.8,
        child: TextFormField(
          controller: passwordTextController,
          validator: (value){
            if(value!.isEmpty){
              return '비밀번호를 입력해주세요.';
            }else if(_passwordValue != value) {
              return '비밀번호가 일치하지 않아요.';
            }else{
              setState(() {
                flag = true;
              });
            }
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
            final formKeyState = _formKey.currentState!;
            if(formKeyState.validate()){
              formKeyState.save();
            }
          },
          onSaved: (value){
            _passwordCheckValue = value!;
          },
          obscureText: obscureCheckToggle,
          decoration: InputDecoration(
            label: Text(text),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      obscureCheckToggle = !obscureCheckToggle;
                    });
                  },
                  child: Icon(Icons.remove_red_eye,
                    size: 20,),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      _passwordCheckValue = '';
                    });
                  },
                  child: Icon(Icons.close,size: 20,),
                ),
              ],
            ),
          ),
        ),
    );
  }
}


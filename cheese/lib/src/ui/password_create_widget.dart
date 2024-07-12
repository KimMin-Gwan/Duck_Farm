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
            InputPasswordWidget(),
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

class InputPasswordWidget extends StatefulWidget {
  const InputPasswordWidget({super.key});

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;
  final _formKey = GlobalKey<FormState>();
  String _passwordValue = '';
  String _passwordCheckValue = '';
  bool obscureCreateToggle = true;
  bool obscureCheckToggle = true;

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
          validator: (value){
            if(value!.isEmpty){
              return '비밀번호를 입력해주세요.';
            }else if(_passwordValue != value) {
              return '비밀번호가 일치하지 않아요.';
            }else
              return null;
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


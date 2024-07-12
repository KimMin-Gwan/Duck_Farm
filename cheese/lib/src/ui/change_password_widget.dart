import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/login_try_widget.dart';
import 'package:cheese/src/ui/password_create_widget.dart';
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
  final _formKey = GlobalKey<FormState>();
  String _passwordValue = '';
  String _passwordChangeValue = '';
  bool obscureInputToggle = true;
  bool obscureChangeToggle = true;

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TopBarWidget(),
              BodyWidget().titleArea(queryWidth, queryHeight, changePassword),
              passwordInputArea(queryWidth, queryHeight, '비밀번호 입력'),
              passwordChangeArea(queryWidth, queryHeight, '비밀번호 확인'),
              SizedBox(
                height: 20,
              ),
              completeChangePwd(queryWidth, queryHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordInputArea(width, height, text) {
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
        obscureText: obscureInputToggle,
        decoration: InputDecoration(
          label: Text(text),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    obscureInputToggle = !obscureInputToggle;
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

  Widget passwordChangeArea(width, height, text) {
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
          _passwordChangeValue = value!;
        },
        obscureText: obscureChangeToggle,
        decoration: InputDecoration(
          label: Text(text),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    obscureChangeToggle = !obscureChangeToggle;
                  });
                },
                child: Icon(Icons.remove_red_eye,
                  size: 20,),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    _passwordChangeValue = '';
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

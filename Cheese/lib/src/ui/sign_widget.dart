import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/ui/style.dart';
import 'package:cheese/src/ui/sign_in_widget.dart';
import 'dart:io';


// 로그인 또는 회원가입 선택 창
class Sign_Widget extends StatefulWidget {
  Sign_Widget({Key? key}) : super(key: key);

  @override
  _SignWidgetState createState() => _SignWidgetState();
}


class _SignWidgetState extends State<Sign_Widget> {
  int _selectedContainerIndex = -1;
  int _flex1 = 9;
  int _flex2 = 2;
  Duration _duration = Duration(milliseconds: 400);
  var _style = SignWidgetTheme();

  SignUpWidthSize(double queryWidth, int state){
    double width = 0;
    if (state == 0){
      width = (_flex1 * queryWidth) / (_flex1 + _flex2);
    }
    else if (state == 1){
      width = (_flex2 * queryWidth) / (_flex1 + _flex2);
    }
    else {
      width = queryWidth / 2;
    }
    print("SignUp : ${width}");
    return width;
  }

  SignInWidthSize(double queryWidth, int state){
    double width = 0;
    if (state == 1){
      width = (_flex1 * queryWidth) / (_flex1 + _flex2);
    }
    else if (state == 0){
      width = (_flex2 * queryWidth) / (_flex1 + _flex2);
    }
    else {
        width = queryWidth / 2;
      }
    print("SignIn : ${width}");
    return width;
  }

  signUp() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("회원 가입", style: _style.getMainText()),
        Container(
        padding: EdgeInsets.all(40),
        child: Icon(Icons.arrow_forward,
        color: _style.getWhite(),
        size: 50,
        )
      )
    ]
  );


  signIn() => Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("로그인", style: _style.getMainText()),
    Container(
      padding: EdgeInsets.all(40),
      child: Icon(Icons.arrow_back,
        color: _style.getWhite(),
        size: 50,
        )
      )
    ]
  );


  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width - 2;
    double queryHeight = MediaQuery.of(context).size.height;
    double height1 = (_flex1 * queryHeight) / (_flex1 + _flex2 + _flex2);
    double height2 = (_flex2 * queryHeight) / (_flex1 + _flex2 + _flex2);


    return Scaffold(
        body: Container(
          color: _style.getBoxColor(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Container(
                height: height2,
              ),
              Container(
                  height: height1,
                  child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                // 회원가입 => 0
                                _selectedContainerIndex = 0;
                                // 애니메이션을 위한 정지
                              });
                            },
                            child: AnimatedContainer(
                                duration: _duration,
                                curve: Curves.easeInOut,
                                width: SignUpWidthSize(queryWidth, _selectedContainerIndex),
                                height: height1,
                                alignment: Alignment.center,
                                child: _selectedContainerIndex == 1? Column() : signUp(),
                                color: _style.getBoxColor()
                            )
                        ),
                        SizedBox(
                          width: 2,
                          height: height1,
                          child : DecoratedBox(
                            decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                          )
                          )
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                // 로그인 => 1;
                                _selectedContainerIndex = 1;
                                // 애니메이션을 위한 정지
                                Future.delayed(_duration, (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignInWidget())
                                  );
                                });
                              });
                            },
                            child: AnimatedContainer(
                                duration: _duration,
                                curve: Curves.easeInOut,
                                width: SignInWidthSize(queryWidth, _selectedContainerIndex),
                                alignment: Alignment.center,
                                child: _selectedContainerIndex == 0? Column() : signIn(),
                                color: _style.getBoxColor()
                            )
                        )
                      ]
                  )
              ),
              Container(
                  width: queryWidth,
                  height: height2,
                  alignment: Alignment.center,
                  child: Text("South Korea", style: _style.getLangText()),
              )
            ]
        )
      )
    );
  }
}






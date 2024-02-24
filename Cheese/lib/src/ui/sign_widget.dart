import 'package:flutter/material.dart';
import 'package:cheese/src/models/user_view.dart';
import 'package:cheese/src/bloc/user_bloc.dart';

class 



class Sign_Widget extends StatefulWidget {
  Sign_Widget({Key? key}) : super(key: key);

  @override
  _SignWidgetState createState() => _SignWidgetState();
}

class _SignWidgetState extends State<Sign_Widget> {
  int _selectedContainerIndex = -1;
  int _flex1 = 9;
  int _flex2 = 3;
  Duration _duration = Duration(seconds: 1);

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

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    print("QueryWidth : ${queryWidth}");
    return Scaffold(
        body: Container(
          color: Colors.black45,
          child: Row(children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedContainerIndex = 0;
                  });
                },
                child: AnimatedContainer(
                    duration: _duration,
                    curve: Curves.easeInOut,
                    width: SignUpWidthSize(queryWidth, _selectedContainerIndex),
                    height: queryHeight,
                    alignment: Alignment.center,
                    child: Text("회원 가입"),
                    color: Colors.red
                )
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedContainerIndex = 1;
                  });
                },
                child: AnimatedContainer(
                    duration: _duration,
                    curve: Curves.easeInOut,
                    width: SignInWidthSize(queryWidth, _selectedContainerIndex),
                    height: queryHeight,
                    alignment: Alignment.center,
                    child: Text("로그인"),
                    color: Colors.blue
                )
            )
          ]
          )
        )
    );
  }
}



class Sign_Up_Widget extends StatefulWidget {
  Sign_Up_Widget({Key? key}) : super(key: key);
  //const Sign_Up_Widget({super.key});

  @override
  _Sign_Up_WidgetState createState() => _Sign_Up_WidgetState();
  //State<Sign_Up_Widget> createState() => _Sign_Up_WidgetState();
}

class _Sign_Up_WidgetState extends State<Sign_Up_Widget> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}










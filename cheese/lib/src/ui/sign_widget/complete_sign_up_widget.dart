import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/sign_widget/login_try_widget.dart';
import 'package:cheese/src/ui/sign_widget/login_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cheese/src/bloc/sign_bloc/sign_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_state.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';
class CompleteSignUpWidget extends StatefulWidget {
  const CompleteSignUpWidget({super.key});

  @override
  State<CompleteSignUpWidget> createState() => _CompleteSignUpWidgetState();
}

class _CompleteSignUpWidgetState extends State<CompleteSignUpWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  TextEditingController emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBarWidget(),
            mainTitleArea(queryWidth, queryHeight),
            SizedBox(
              height: 20,
            ),
            mainLogoArea(queryWidth, queryHeight),
            SizedBox(
              height: 20,
            ),
            textBodyArea(queryWidth, queryHeight),
            SizedBox(
              height: 20,
            ),
            functionButton(queryWidth, queryHeight,
                '최애 설정하기', context),
          ],
        ),
      ),
    );
  }

  Widget functionButton(width, height, text, context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<SignBloc>(context).add( InitSignEvent());
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



  Widget textBodyArea(queryWidth, queryHeight) {
    return Column(
      children: [
        completeTextArea(queryWidth, queryHeight),
        SizedBox(
          height: 10,
        ),
        subTextArea(queryWidth, queryHeight),
      ],
    );
  }
  Widget completeTextArea(width, height){
    return Container(
      child: Text('치즈 가입을 완료하였습니다.',style: TextStyle(
        fontSize: 18,
      ),),
    );
  }
  Widget subTextArea(width, height){
    return Container(
      alignment: Alignment.center,
      child: Text('이제 나의 최애를 설정하고\n 보고싶은 날짜의 사진을 편하게 즐겨보세요!',
      textAlign: TextAlign.center,),
    );
  }
}

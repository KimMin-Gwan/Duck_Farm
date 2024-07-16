import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/sign_widget/login_widget.dart';
import 'package:cheese/src/ui/sign_widget/login_try_widget.dart';

class AgreementRawWidget extends StatefulWidget {
  const AgreementRawWidget({super.key});

  @override
  State<AgreementRawWidget> createState() => _AgreementRawWidgetState();
}

class _AgreementRawWidgetState extends State<AgreementRawWidget> {
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
            mainTitleArea(queryWidth, queryHeight),
            SizedBox(
              height: 20,
            ),
            Text('치즈의 이용 약관에 동의해주세요.'),
            SizedBox(
              height: 40,
            ),
            AgreementTextWidget(),


          ],
        ),
      ),
    );
  }
}

class AgreementTextWidget extends StatefulWidget {
  const AgreementTextWidget({super.key});

  @override
  State<AgreementTextWidget> createState() => _AgreementTextWidgetState();
}

class _AgreementTextWidgetState extends State<AgreementTextWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  bool isAllChecked = false;
  bool isRequireChecked = false;
  bool isSelectChecked = false;
  bool ischeck1 = false;
  bool ischeck2 = false;
  bool ischeck3 = false;
  bool ischeck4 = false;
  bool ischeck5 = false;
  bool ischeck6 = false;

  void isUpdateAllCheck(){
    isAllChecked = isRequireChecked && isSelectChecked;
  }

  void isUpdateRequireCheck(){
    isRequireChecked = ischeck1 && ischeck2 && ischeck3;
  }

  void isUpdateSelectCheck(){
    isSelectChecked = ischeck4 && ischeck5 && ischeck6;
  }

  void resetState(){
    isAllChecked = false;
    isRequireChecked = false;
    isSelectChecked = false;
    ischeck1 = false;
    ischeck2 = false;
    ischeck3 = false;
    ischeck4 = false;
    ischeck5 = false;
    ischeck6 = false;
  }

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('전체동의'),
            Checkbox(
                value: isAllChecked,
                onChanged: (value) {
                  setState(() {
                    isAllChecked = value!;
                    isRequireChecked = value;
                    isSelectChecked = value;
                    ischeck1 = value;
                    ischeck2 = value;
                    ischeck3 = value;
                    ischeck4 = value;
                    ischeck5 = value;
                    ischeck6 = value;
                  });
                })
          ],
        ),
        Divider(color: Colors.grey,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('필수 전체동의'),
            Checkbox(
                value: isRequireChecked,
                onChanged: (value) {
                  setState(() {
                    isRequireChecked = value!;
                    ischeck1 = value;
                    ischeck2 = value;
                    ischeck3 = value;
                    isUpdateRequireCheck();
                    isUpdateAllCheck();
                  });
                })
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('(필수1)'),
            Checkbox(
                value: ischeck1,
                onChanged: (value){
                  setState(() {
                    ischeck1 = value!;
                    isUpdateRequireCheck();
                    isUpdateAllCheck();
                  });
                })
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('(필수2)'),
            Checkbox(
                value: ischeck2,
                onChanged: (value){
                  setState(() {
                    ischeck2 = value!;
                    isUpdateRequireCheck();
                    isUpdateAllCheck();
                  });
                })
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('(필수3)'),
            Checkbox(
                value: ischeck3,
                onChanged: (value){
                  setState(() {
                    ischeck3 = value!;
                    isUpdateRequireCheck();
                    isUpdateAllCheck();
                  });
                })
          ],
        ),
        Divider(color: Colors.grey,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('선택 전체동의'),
            Checkbox(
                value: isSelectChecked,
                onChanged: (value) {
                  setState(() {
                    isSelectChecked = value!;
                    ischeck4 = value;
                    ischeck5 = value;
                    ischeck6 = value;
                    isUpdateSelectCheck();
                    isUpdateAllCheck();
                  });
                })
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('(선택1)'),
            Checkbox(
                value: ischeck4,
                onChanged: (value){
                  setState(() {
                    ischeck4 = value!;
                    isUpdateSelectCheck();
                    isUpdateAllCheck();
                  });
                })
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('(선택2)'),
            Checkbox(
                value: ischeck5,
                onChanged: (value){
                  setState(() {
                    ischeck5 = value!;
                    isUpdateSelectCheck();
                    isUpdateAllCheck();
                  });
                })
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('(선택3)'),
            // Switch(
            //     value: ischeck6,
            //     onChanged: (bool value) {
            //       setState(() {
            //         ischeck6 = value;
            //         isUpdateSelectCheck();
            //         isUpdateAllCheck();
            //       });
            //     }),
            Checkbox(
                value: ischeck6,
                onChanged: (value){
                  setState(() {
                    ischeck6 = value!;
                    isUpdateSelectCheck();
                    isUpdateAllCheck();
                  });
                })
          ],
        ),
        functionButton(queryWidth, queryHeight, '가입완료'),
      ],
    );
  }

  Widget functionButton(width, height, text) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        width: width * 0.8,
        height: height * 0.05,
        decoration: BoxDecoration(
          color: isRequireChecked ? Colors.deepPurple : Colors.grey,
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


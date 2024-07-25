import 'package:flutter/material.dart';

class BiasAddTheme {
  Color mainWhiteColor = const Color(0xFFFFFFFF);
  Color mainPurpleColor= const Color(0xFF5941DA);
  Color mainGreyColor= const Color(0xFF595959);
  // BiasWidget
  BoxDecoration mainBoxDecoration = BoxDecoration();
  TextStyle saveText = TextStyle();
  TextStyle cancelText = TextStyle();
  UnderlineInputBorder focusUnderLine=UnderlineInputBorder();
  UnderlineInputBorder basicUnderLine=UnderlineInputBorder();
  CircleAvatar biasImage= CircleAvatar();


  BiasAddTheme() {
    saveText = TextStyle(
      color: mainPurpleColor,
      fontSize: 16,
    );

    cancelText=TextStyle(
      color: mainGreyColor,
      fontSize: 16,
    );

    focusUnderLine=UnderlineInputBorder(
      borderSide: BorderSide(color: mainGreyColor), // 포커스 밑줄 색상
    );

    basicUnderLine=UnderlineInputBorder(
      borderSide: BorderSide(color: mainGreyColor), // 기본 밑줄 색상
    );

    biasImage=CircleAvatar(
      radius: 13.0,
      backgroundColor:mainPurpleColor, // 원형 도형 색상(임시. 삭제할 것)
      // backgroundImage: AssetImage('assets/images/person.png'), // 추후 이미지 넣을 것!
    );
  }
}

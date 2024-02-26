import 'package:flutter/material.dart';

// SignWidget 에 사용된 테마
class SignWidgetTheme {
  static const _boxColor = Color(0xff181420);
  static const _mainText = TextStyle(fontSize: 24, color: Color(0xffFFFFFF));
  static const _langText = TextStyle(fontSize: 10, color: Color(0xffFFFFFF));
  static const _white = Color(0xffFFFFFF);


  getBoxColor() => _boxColor;
  getMainText() => _mainText;
  getLangText() => _langText;
  getWhite() => _white;

}

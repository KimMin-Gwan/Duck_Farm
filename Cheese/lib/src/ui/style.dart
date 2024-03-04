import 'package:flutter/material.dart';

class Theme {
  Color almostBlack = Color(0xff171717);
  Color grayBlack = Color(0xff232323);
  Color white = Color(0xffFFFFFF);
  Color black = Color(0xff000000);
  Color gray = Color(0xff666666);
  Color whiteGray = Color(0xffD9D9D9);
  Color pink = Color(0xffFD999A);


  Color getGrayBlack() => grayBlack;
  Color getAlmostBlack() => almostBlack;
  Color getWhite() => white;
  Color getBlack() => black;
  Color getGray() => gray;
  Color getPink() => pink;
  Color getWhiteGray() => whiteGray;
}

class HomeScaffoldTheme extends Theme {
  TextStyle _mainText = TextStyle(fontSize: 20, color: Color(0xffFFFFFF));
  TextStyle _langText = TextStyle(fontSize: 10, color: Color(0xffFFFFFF));
  TextStyle _navigationBarText = TextStyle();

  HomeScaffoldTheme(){
    _navigationBarText = TextStyle(fontSize: 8, fontWeight:FontWeight.w100,
        color: super.getBlack());
  }

  TextStyle getNavigationBarText() => _navigationBarText;
  TextStyle getMainText() => _mainText;
  TextStyle getLangText() => _langText;
}
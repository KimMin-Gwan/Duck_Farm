import 'package:flutter/material.dart';


class Theme {
  Color boxColor = Color(0xff181420);
  Color white = Color(0xffFFFFFF);
  Color black = Color(0xff000000);

  Color getBoxColor() => boxColor;
  Color getWhite() => white;
  Color getBlack() => black;
}

class SignWidgetTheme extends Theme {
  TextStyle _mainText = TextStyle(fontSize: 20, color: Color(0xffFFFFFF));
  TextStyle _langText = TextStyle(fontSize: 10, color: Color(0xffFFFFFF));

  TextStyle getMainText() => _mainText;
  TextStyle getLangText() => _langText;
}

class SignInWidgetTheme extends SignWidgetTheme {
  TextStyle _optionText = TextStyle();
  TextStyle _loginButtonText = TextStyle();
  TextStyle _simpleLoginText = TextStyle();
  ButtonStyle _loginButton = ButtonStyle();
  BoxDecoration _mainBoxTheme = BoxDecoration();
  TextStyle _textFieldLabelTextStyle = TextStyle();
  BorderSide _textFieldBorder = BorderSide();

  SignInWidgetTheme(){
    _optionText = TextStyle(fontSize: 8, color: getWhite());
    _loginButtonText = TextStyle(fontSize: 12, color: getBlack());
    _simpleLoginText = TextStyle(fontSize: 12, color: getWhite());
    _textFieldLabelTextStyle = TextStyle(fontSize: 10, color: getWhite());
    _textFieldBorder = BorderSide(color: getWhite());
    _loginButton = ElevatedButton.styleFrom(
      backgroundColor: Color(0xffFD999A),
      surfaceTintColor: Color(0xffFD999A),
      foregroundColor: getWhite(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
    _mainBoxTheme = BoxDecoration(
      color: getBoxColor(),
      borderRadius: BorderRadius.circular(20),
    );
  }

  TextStyle getOptionText() => _optionText;
  TextStyle getLoginButtonText() => _loginButtonText;
  TextStyle getSimpleLoginText() => _simpleLoginText;
  TextStyle getTextFieldLabelTextStyle() =>_textFieldLabelTextStyle;
  ButtonStyle getLoginButtonTheme() => _loginButton;
  BoxDecoration getMainBoxTheme() => _mainBoxTheme;
  BorderSide getTextFieldBorder() => _textFieldBorder;

}

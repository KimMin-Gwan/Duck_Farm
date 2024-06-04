import 'package:flutter/material.dart';


class Theme {
  Color boxColor = Color(0xff181420);
  Color white = Color(0xffFFFFFF);
  Color black = Color(0xff000000);
  Color gray = Color(0xff666666);
  Color whiteGray = Color(0xffD9D9D9);
  Color pink = Color(0xffFD999A);

  Color getBoxColor() => boxColor;
  Color getWhite() => white;
  Color getBlack() => black;
  Color getGray() => gray;
  Color getPink() => pink;
  Color getWhiteGray() => whiteGray;
}

class SignWidgetTheme extends Theme {
  TextStyle _mainText = TextStyle(fontSize: 20, color: Color(0xffFFFFFF));
  TextStyle _langText = TextStyle(fontSize: 10, color: Color(0xffFFFFFF));

  TextStyle getMainText() => _mainText;
  TextStyle getLangText() => _langText;
}

class SignUpWidgetTheme extends SignWidgetTheme{

  BoxDecoration _mainBoxTheme = BoxDecoration();
  ButtonStyle _simpleButton = ButtonStyle();
  TextStyle _simpleButtonText = TextStyle();
  TextStyle _genderButtonText = TextStyle();
  TextStyle _birthdayTextFieldLabelTextStyle = TextStyle();
  TextStyle _validationTextStyle = TextStyle();
  BorderSide _birthdayTextFieldBorder = BorderSide();
  TextStyle _emailTextFieldLabelTextStyle = TextStyle();



  SignUpWidgetTheme(){
    _validationTextStyle = TextStyle(fontSize: 8, color:Colors.red);
    _emailTextFieldLabelTextStyle = TextStyle(fontSize: 20, color: getWhite());
    _birthdayTextFieldLabelTextStyle= TextStyle(fontSize: 24, fontWeight: FontWeight.w200, color: getWhite());
    _birthdayTextFieldBorder= BorderSide(color: getWhite());
    _simpleButtonText= TextStyle(fontSize: 12, color: getWhite());
    _mainBoxTheme = BoxDecoration(
      color: getBoxColor(),
      borderRadius: BorderRadius.circular(20),
    );
    _simpleButton = ElevatedButton.styleFrom(
        minimumSize: Size(100, 50),
        backgroundColor: getPink(),
        surfaceTintColor: getWhite(),
        foregroundColor: getWhite(),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )
    );
    _genderButtonText = TextStyle(fontSize: 24, color:getWhite());

  }

  TextStyle getEmailTextFieldLabelTextStyle() => _emailTextFieldLabelTextStyle;
  TextStyle getValidationTextStyle() => _validationTextStyle;
  BorderSide getBirthdayTextFieldBorder() => _birthdayTextFieldBorder;
  TextStyle getSimpleButtonText() => _simpleButtonText;
  TextStyle getGenderButtonText() => _genderButtonText;
  TextStyle getBirthdayTextFieldLabelTextStyle() => _birthdayTextFieldLabelTextStyle;
  BoxDecoration getMainBoxTheme() => _mainBoxTheme;
  // 선택되면 색깔이 바뀌어야함
  ButtonStyle getSimpleButton() => _simpleButton;
  ButtonStyle getButtonAsOption(bool value){
    if (value) {
      return ElevatedButton.styleFrom(
          minimumSize: Size(100, 50),
          backgroundColor: Color(0xffFD999A),
          surfaceTintColor: getWhite(),
          foregroundColor: getWhite(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )
      );
    }
    else{
      return ElevatedButton.styleFrom(
          minimumSize: Size(100, 50),
          backgroundColor: getBoxColor(),
          surfaceTintColor: getBoxColor(),
          foregroundColor: getWhite(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )
      );
    }
  }
  ButtonStyle getGenderButton(bool value){
    if (value) {
      return ElevatedButton.styleFrom(
        side: BorderSide(
          color: getWhite(),
          width: 2.0,
        ),
        minimumSize: Size(110, 48),
        backgroundColor: Color(0xffFD999A),
        surfaceTintColor: getWhite(),
        foregroundColor: getWhite(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )
      );
    }
    else{
      return ElevatedButton.styleFrom(
          side: BorderSide(
            color: getWhite(),
            width: 2.0,
          ),
        minimumSize: Size(110, 48),
        backgroundColor: getBoxColor(),
        surfaceTintColor: getBoxColor(),
        foregroundColor: getWhite(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )
      );
    }
  }

}




class SignInWidgetTheme extends SignWidgetTheme {
  TextStyle _optionText = TextStyle();
  TextStyle _loginButtonText = TextStyle();
  TextStyle _simpleLoginText = TextStyle();
  ButtonStyle _loginButton = ButtonStyle();
  ButtonStyle _loginButtonDark = ButtonStyle();
  BoxDecoration _mainBoxTheme = BoxDecoration();
  TextStyle _textFieldLabelTextStyle = TextStyle();
  BorderSide _textFieldBorder = BorderSide();

  SignInWidgetTheme(){
    _optionText = TextStyle(fontSize: 8, color: getWhite());
    _loginButtonText = TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: getBlack());
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
    _loginButtonDark = ElevatedButton.styleFrom(
      backgroundColor: getWhiteGray(),
      surfaceTintColor: getWhiteGray(),
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
  ButtonStyle getLoginButtonDarkTheme() => _loginButtonDark;
  BoxDecoration getMainBoxTheme() => _mainBoxTheme;
  BorderSide getTextFieldBorder() => _textFieldBorder;

}

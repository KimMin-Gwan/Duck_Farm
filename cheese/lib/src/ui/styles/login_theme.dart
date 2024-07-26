import 'package:cheese/src/ui/styles/main_theme.dart';
import 'package:flutter/material.dart';

class LoginTheme extends MainTheme {
  TextStyle emailTransmitText = TextStyle();
  TextStyle remainTimeText = TextStyle();

  Size emailStartButtonSize = Size(300, 50);

  LoginTheme() {
    emailTransmitText = TextStyle(
      shadows: [
        Shadow(
          color: Colors.grey,
          offset: Offset(0, 3),
          blurRadius: 5,
        ),
      ],
      color: Colors.deepPurple,
      fontWeight: FontWeight.w400,
    );

    remainTimeText = TextStyle(
      color: Colors.deepPurpleAccent,
    );
  }
}

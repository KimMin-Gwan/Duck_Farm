import 'package:cheese/src/ui/styles/main_theme.dart';
import 'package:flutter/material.dart';

class BiasFollowingTheme extends MainTheme {
  TextStyle titleTextStyle = TextStyle();
  TextStyle saveTextStyle = TextStyle();
  BiasFollowingTheme(){
    titleTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
    saveTextStyle = TextStyle(fontSize: 15, color: Colors.deepPurpleAccent, fontWeight: FontWeight.w600);;

}

}
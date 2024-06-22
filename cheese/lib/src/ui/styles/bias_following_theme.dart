import 'package:cheese/src/ui/styles/main_theme.dart';
import 'package:flutter/material.dart';

class BiasFollowingTheme extends MainTheme {
  TextStyle titleTextStyle = TextStyle();
  TextStyle addSaveTextStyle = TextStyle();
  TextStyle idolNameTextStyle = TextStyle();
  Decoration listBoxDecoration = BoxDecoration();
  Decoration profileImageBoxDecoration = BoxDecoration();

  BiasFollowingTheme(){
    listBoxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: Colors.deepPurpleAccent.shade100,
            width: 0.8
        )
    );
    profileImageBoxDecoration = BoxDecoration(
        color: Colors.blue,
        shape:BoxShape.circle
    );
    titleTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
    addSaveTextStyle = TextStyle(fontSize: 15, color: Colors.deepPurpleAccent, fontWeight: FontWeight.w600);;
    idolNameTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
}

}
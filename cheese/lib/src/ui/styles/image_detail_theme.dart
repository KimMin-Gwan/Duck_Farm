import 'package:cheese/src/ui/styles/main_theme.dart';
import 'package:flutter/material.dart';

class ImageDetailTheme extends MainTheme{
  Color scheduleTitleColor = Colors.deepPurpleAccent.withOpacity(0.3);
  Color threeDotColor = Colors.grey.withOpacity(0.7);
  Decoration profileDecoration = BoxDecoration();
  Decoration listOptionDecoration = BoxDecoration();
  TextStyle locationText = TextStyle();
  TextStyle likeText = TextStyle();
  TextStyle nickNameText = TextStyle();
  TextStyle dateText = TextStyle();
  TextStyle scheduleTitleText = TextStyle();
  TextStyle idolNameText = TextStyle();
  TextStyle infoText = TextStyle();
  TextStyle optionText = TextStyle();

  ImageDetailTheme(){
    profileDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.black,
    );
    listOptionDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.grey),
      color: Colors.white
    );
    optionText = TextStyle(fontSize: 11, fontWeight: FontWeight.w500);
    locationText = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    likeText = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    nickNameText = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    dateText = TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.7), fontWeight: FontWeight.w600);
    scheduleTitleText = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    idolNameText = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    infoText = TextStyle(fontSize: 12);
  }
}
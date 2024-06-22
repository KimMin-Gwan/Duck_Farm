import 'package:cheese/src/ui/styles/main_theme.dart';
import 'package:flutter/material.dart';

class ImageCategoryTheme extends MainTheme{
  Color bottomAreaColor = Color(0xff232323);
  Color scheduleTitleColor = Colors.deepPurpleAccent.withOpacity(0.3);
  TextStyle sortTextStyle =  TextStyle();
  TextStyle totalPictureTextStyle =  TextStyle();
  TextStyle biasNameText = TextStyle();
  TextStyle scheduleTitleText = TextStyle();

  ImageCategoryTheme(){
    sortTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
    totalPictureTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
    biasNameText = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
    scheduleTitleText = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

  }

}
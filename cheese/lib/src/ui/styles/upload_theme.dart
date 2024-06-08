import 'package:cheese/src/ui/styles/main_theme.dart';
import 'package:flutter/material.dart';

// 박스 데코레이션, 그림자 설정, 텍스트 스타일, 버튼 스타일, 기본 사용 색깔 등 정의
// 스타일을 적용할 클래스에서 var _style = HomeTheme() 로 적용 후
// 스타일 적용할 부분에서 _style.member 형태로 사용할 것
// ex) decoration : _style.mainBoxDecoration

class UploadTheme extends MainTheme{
  // 데이터 멤버로 사전 정의
  BoxDecoration mainBoxDecoration = BoxDecoration();
  BoxDecoration imageBoxDecoration = BoxDecoration();
  Color imageBoxColor = Colors.grey.withOpacity(0.5);
  TextStyle infoTitleText = TextStyle();
  TextStyle inputDataText = TextStyle();
  TextStyle emptyDataText = TextStyle();
  TextStyle essentialStarText = TextStyle();
  TextStyle uploadTitleText = TextStyle();
  TextStyle completeButton = TextStyle();
  Divider divideLine = Divider();

  // 생성자 내부에서 상세 정의
  UploadTheme(){
    imageBoxDecoration = BoxDecoration(
      color: imageBoxColor,
      borderRadius: BorderRadius.circular(8),
    );
    uploadTitleText = TextStyle(fontSize:15, fontWeight: FontWeight.w700);
    completeButton = TextStyle(fontSize: 15, color: Colors.deepPurpleAccent, fontWeight: FontWeight.w600);
    infoTitleText = TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w200);
    inputDataText = TextStyle(fontSize: 13,);
    emptyDataText = TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.8));
    essentialStarText = TextStyle(fontSize: 15, color: Colors.deepPurpleAccent, fontWeight: FontWeight.w700);
  }
// 접근자 수정자 생성 금지


}
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cheese/src/ui/styles/main_theme.dart';

// 박스 데코레이션, 그림자 설정, 텍스트 스타일, 버튼 스타일, 기본 사용 색깔 등 정의
// 스타일을 적용할 클래스에서 var _style = HomeTheme() 로 적용 후
// 스타일 적용할 부분에서 _style.member 형태로 사용할 것
// ex) decoration : _style.mainBoxDecoration

class HomeTheme extends MainTheme
{
  // 데이터 멤버로 사전 정의
  BoxDecoration mainBoxDecoration = BoxDecoration();

  // 생성자 내부에서 상세 정의
  HomeTheme(){
    /*
    mainBoxDecoration = BoxDecoration(
      color: mainContainerColor,
      //borderRadius: BorderRadius()
    )
     */
  }
  // 접근자 수정자 생성 금지


}
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cheese/src/ui/styles/main_theme.dart';

// 박스 데코레이션, 그림자 설정, 텍스트 스타일, 버튼 스타일, 기본 사용 색깔 등 정의
// 스타일을 적용할 클래스에서 var _style = HomeTheme() 로 적용 후
// 스타일 적용할 부분에서 _style.member 형태로 사용할 것
// ex) decoration : _style.mainBoxDecoration

class HomeTheme extends MainTheme {
  // BiasWidget
  BoxDecoration mainBoxDecoration = BoxDecoration();
  BoxShadow mainBoxShadow = BoxShadow();
  TextStyle biasName = TextStyle();
  // CalenderWidget
  BoxDecoration calenderBoxShadow = BoxDecoration();
  Divider calenderDevider = Divider();
  TextStyle monthYear = TextStyle();
  BoxDecoration todayBox = BoxDecoration();
  BoxDecoration selectedBox = BoxDecoration();
  TextStyle weekColor = TextStyle();
  // HomeBodyWidget
  TextStyle eventday = TextStyle();
  BoxDecoration eventGalleryBox = BoxDecoration();
  BoxDecoration galleryBox = BoxDecoration();
  TextStyle eventTitle = TextStyle();

  HomeTheme() {
    // BiasWidget
    mainBoxDecoration = BoxDecoration(
      color: Colors.grey[200], // 추후 색 변경하기
      borderRadius: BorderRadius.circular(10.0),
    );

    mainBoxShadow = BoxShadow(
      color: Colors.grey.withOpacity(1), // 그림자 색상
      spreadRadius: 2, // 그림자 퍼짐 반경
      blurRadius: 2, // 그림자 흐림 정도
      offset: Offset(0, 3), // 그림자 위치 (x, y)
    );

    calenderBoxShadow = BoxDecoration(
      color: mainWhiteColor,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // 그림자의 색상과 투명도를
          spreadRadius: 5, // 그림자가 퍼지는 반경
          blurRadius: 5, // 그림자의 흐림 정도
          offset: Offset(0.1, 3), // 그림자의 위치
        ),
      ],
    );

    biasName = TextStyle(
      fontSize: 10.0, // 텍스트 크기 조절
    );

    // CalenderWidget
    calenderDevider = Divider(
      color: Colors.white, // 구분선 색상을 하늘색으로 설정
      thickness: 0.5, // 구분선 두께 설정
    );
    monthYear = TextStyle(fontSize: 12.0);
    todayBox = BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    );
    selectedBox = BoxDecoration(
      color: Colors.blueAccent,
      shape: BoxShape.circle,
    );
    weekColor = TextStyle(color: Colors.black);

    // HomeBodyWidget
    eventday = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
    eventTitle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);

    eventGalleryBox = BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
    );

    galleryBox = BoxDecoration(
      color: Colors.deepPurpleAccent,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    );
  }
}

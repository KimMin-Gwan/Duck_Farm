import 'package:flutter/material.dart';

// TopBarWidget
class TopBarWidget extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBarWidget> {
  final double appBarHeight = 78;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(horizontal: 25.0), // 좌우 간격
      height: appBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 가운데 간격
        children: [
          Container(
            height : 27.5,
            child: Image.asset(
              'images/assets/eng_logo.png', // 이미지 경로
            ),
          ),
          IconButton(
            onPressed: () {
              // 메뉴 아이콘 클릭 시 동작
            },
            icon: const Icon(Icons.menu),
          )
        ],
      ),
    );
  }
}

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  final double bottomBarHeight = 60;
  final maxWidth = 400.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    return Container(
        width: queryWidth,
        height: bottomBarHeight,
        color: const Color(0xff232323),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.home, color : Colors.white),
            Container(
              width: queryWidth * 0.15,
            ),
            const Icon(Icons.search, color : Colors.white),
          ],
        )
    );
  }
}

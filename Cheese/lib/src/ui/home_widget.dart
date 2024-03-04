import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/ui/style.dart';


class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  //final BLoC
  var _style = HomeScaffoldTheme();
  final maxWidth = 400.0;
  final maxHeight = 1200.0;

  int _selectedIndex = 0;

  bool selectedIndexFinder(int myIndex) {
    if (myIndex == _selectedIndex) {
      return true;
    } else {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery
        .of(context)
        .size
        .width;
    // 가로 최대 길이를 400으로 한정
    //if (queryWidth > maxWidth) {
    //queryWidth = maxWidth;}
    double queryHeight = MediaQuery
        .of(context)
        .size
        .height;
    // 세로 최대 길이를 1200으로  한정
    //if (queryWidth > maxHeight) {
    //queryWidth = maxHeight; }


    return Scaffold(
        appBar: AppBar(
            backgroundColor: _style.getAlmostBlack(),
            foregroundColor: _style.getAlmostBlack(),
            elevation: 0,
            title: IconButton(
              icon: Image(
                image: AssetImage("assets/homeIcon.png"),
                width: 200,
              ),
              onPressed: () {},
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.menu, color: _style.getWhite()),
                onPressed: () {},
              )
            ]
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: _style.getWhite(),
          backgroundColor: _style.getWhite(),
          shape: CircleBorder(),
          child: Icon(Icons.add, size: 30, color: _style.getBlack()),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: homeBodyWidget(queryWidth, queryHeight),
        bottomNavigationBar: homeBottomAppBar(queryWidth, queryHeight)
    );
  }

  Widget homeBodyWidget(width, height) {
    return Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        color: _style.getAlmostBlack(),
        child: SingleChildScrollView(
            child: Column(
                children: [
                  Container(
                    width: width,
                    height: height * 0.13,
                    color: Colors.grey,
                    child: HomeADwidget(),
                  ),
                  Container(
                    width: width,
                    height: width * 0.3,
                    color: Colors.grey,
                    child: MyWaifuWidget(),
                  ),
                  Container(
                    width: width,
                    height: height * 0.5,
                    color: Colors.purple,
                  ),
                  Container(
                    width: width,
                    height: height * 0.5,
                    color: Colors.orange,
                  ),
                ]
            )
        )
    );
  }

  BottomNavigationBar homeBottomAppBar(width, height) {
    return BottomNavigationBar(
        iconSize: 25,
        backgroundColor: _style.getGrayBlack(),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _style.getWhite(),
        unselectedItemColor: _style.getWhite(),
        // 선택 안된 아이콘 색상
        selectedFontSize: 8,
        unselectedFontSize: 8,
        selectedLabelStyle: _style.getNavigationBarText(),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: _style.getGrayBlack(),
            icon: selectedIndexFinder(0) ? Icon(Icons.person) : Icon(
                Icons.person_outlined),
            label: "홈",
          ),
          BottomNavigationBarItem(
              backgroundColor: _style.getGrayBlack(),
              icon: selectedIndexFinder(1) ? Icon(Icons.search_sharp) : Icon(
                  Icons.search),
              label: "검색"
          ),
          BottomNavigationBarItem(
              backgroundColor: _style.getGrayBlack(),
              icon: selectedIndexFinder(2) ? Icon(Icons.person) : Icon(
                  Icons.person_outlined),
              label: "알림"
          ),
          BottomNavigationBarItem(
            backgroundColor: _style.getGrayBlack(),
            icon: selectedIndexFinder(3) ? Icon(Icons.person) : Icon(
                Icons.person_outlined),
            label: "마이페이지",
          ),
        ]
    );
  }
}

class HomeADwidget extends StatefulWidget {
  @override
  State<HomeADwidget> createState() => _HomeADwidgetState();
}

class _HomeADwidgetState extends State<HomeADwidget> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 30,
        child: PageView(
            scrollDirection : Axis.horizontal,
            controller: _pageController,
            children :[
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.green,
              )
            ]
        )
    );
  }
}

class CircleWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    return Container(
      width: queryWidth * 0.18,
      height: queryWidth * 0.18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
    );
  }
}


class MyWaifuWidget extends StatefulWidget {
  const MyWaifuWidget({super.key});

  @override
  State<MyWaifuWidget> createState() => _MyWaifuWidgetState();
}

class _MyWaifuWidgetState extends State<MyWaifuWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width:10),
          CircleWidget(),
          SizedBox(width:10),
          CircleWidget(),
          SizedBox(width:10),
          CircleWidget(),
          SizedBox(width:10),
          CircleWidget(),
          SizedBox(width:10),
          CircleWidget(),
          SizedBox(width:10),
          CircleWidget(),
          SizedBox(width:10),
        ]
    );

  }
}






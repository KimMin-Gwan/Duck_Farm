import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/ui/home_widget/bias_widget.dart';
import 'package:cheese/src/ui/home_widget/calender_widget.dart';
import 'package:cheese/src/ui/home_widget/home_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/ui/home_widget/bar_widgets.dart';
import 'package:cheese/src/ui/styles/home_theme.dart';
import 'package:cheese/src/ui/upload_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeTheme _style = HomeTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;


  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) {
      queryWidth = maxWidth;
    }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) {
      queryHeight = maxHeight;
    }
    return Scaffold(
        backgroundColor: _style.mainWhiteColor,
        floatingActionButton: Container(
            height: 80,
            width: 80,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImageUploadWidget())
                );
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Image.asset('images/assets/upload_button.png'),
            )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          children: [
            TopBarWidget(),
            Column(
                children:[
                  Container(
                    width: queryWidth,
                    height: 78,
                  ),
                  Container(
                      width: queryWidth,
                      height: queryHeight - 110,
                      child: const HomeWidget()
                  ),
                ]
            ),
            Column(
                children:[
                  Container(
                    width: queryWidth,
                    height: queryHeight - 60,
//color: Colors.grey,
                  ),
                  const BottomBarWidget()
                ]
            )
          ],
        )
    );
  }
}


class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state)
        {
          if (state is NoneBiasState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child: BiasWidget(),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                    // child: CalendarWidget(),
                    child: CalendarWidget2(),
                  ),

                  // // HomebodyWidget
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                  //   child:
                  //   HomeBodyWidget(selectedDate: DateTime.now()), // 오늘 날짜를 임의로 넣음
                  // ),

                  // HomebodyWidget2
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                    child:
                    HomeBodyWidget2(selectedDate: DateTime.now()), // 오늘 날짜를 임의로 넣음
                  ),
                  // 다른 위젯 추가
                ],
              ),
            );
          } else {
            return Container(
                child: const Text('로딩 중 ~~')
            );
          }
        });
  }
}


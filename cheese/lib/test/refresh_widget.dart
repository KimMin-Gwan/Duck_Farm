import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshWidget extends StatefulWidget {
  const RefreshWidget({super.key});

  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override

  final maxWidth = 400.0;
  final maxHeight = 900.0;
  bool interaction = false;
  List<Color> colors = [Colors.red, Colors.blue, Colors.green,];
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return Scaffold(
       body: SmartRefresher(
         controller: _refreshController,
         onRefresh: () async{
           await Future.delayed(Duration(seconds: 3));
           setState(() {
             colors.shuffle();
           });
           _refreshController.refreshCompleted();
           },
         header: CustomHeader(
           builder: (context, mode){
             Widget body;
             if (mode == RefreshStatus.idle) {
               body = Text("당겨서 새로고침");
             } else if (mode == RefreshStatus.refreshing) {
               body = Icon(Icons.bookmark_add);
             } else if (mode == RefreshStatus.completed) {
               body = Text("새로고침이 완료되었습니다");
             } else if (mode == RefreshStatus.failed) {
               body = Text("새로고침에 실패!");
             } else {
               body = Text("당겨서 새로고침");
             }
             return Center(
               child: Container(
                 width: queryWidth * 0.3,
                 height: queryHeight * 0.1,
                 color: Colors.yellow,
                 child: body
               )

             );
           },
         ),
         child: SingleChildScrollView(
           child: Column(
             children: [
               Container(
                 width: queryWidth,
                 height: queryHeight * 0.3,
                 color: colors[0],
               ),
              Container(
                 width: queryWidth,
                 height: queryHeight * 0.3,
                 color: colors[1],
              ),
              Container(
                 width: queryWidth,
                 height: queryHeight * 0.3,
                 color: colors[2],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
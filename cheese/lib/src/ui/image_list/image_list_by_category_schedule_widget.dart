import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cheese/src/ui/styles/image_category_theme.dart';

class ImageListByCategoryScheduleWidget extends StatefulWidget {
  const ImageListByCategoryScheduleWidget({super.key});

  @override
  State<ImageListByCategoryScheduleWidget> createState() => _ImageListByCategoryScheduleWidgetState();
}

class _ImageListByCategoryScheduleWidgetState extends State<ImageListByCategoryScheduleWidget> {
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return Scaffold(
      body: Column(
        children: [
          TopBarWidget(),
          BodyWidget(),
          BottomBarWidget(),
        ],
      ),
    );
  }
}

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({super.key});

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  final _style = ImageCategoryTheme();
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return Container(
      height: queryHeight * 0.08,
      child: Row(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.chevron_left),
              )
          ),
          Container(
            alignment: Alignment.center,
            width: queryWidth * 0.75,
            child: Text("라이즈",style: _style.biasNameText,),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.add),
              )
          ),
        ],
      ),
    );
  }
}





class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final _style = ImageCategoryTheme();
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return SingleChildScrollView(
      child: Column(
        children: [
          ScheduleDetailWidget(),
          Container(
            height: 50,
            child: Row(
              children: [
                Container(
                  width: queryWidth * 0.82,
                  child: Text('  전체 사진',style: _style.totalPictureTextStyle,),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          child: Icon(CupertinoIcons.arrow_up_arrow_down, size: 17),
                        ),
                        Container(
                          child: Text(' 인기순',style: _style.sortTextStyle,),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 571.4,
            //child: ImageListWidget(),
          )
        ],
      ),
    );
  }
}

class ScheduleDetailWidget extends StatefulWidget {
  const ScheduleDetailWidget({super.key});

  @override
  State<ScheduleDetailWidget> createState() => _ScheduleDetailWidgetState();
}

class _ScheduleDetailWidgetState extends State<ScheduleDetailWidget> {
  final _style = ImageCategoryTheme();
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return Container(
      height: queryHeight * 0.05,
      color: _style.scheduleTitleColor,
      child: Center(
        child: Text('231010 | 2023 더팩트 뮤직 어워즈(TMA)',
          style: _style.scheduleTitleText,),
      ),
    );;
  }
}

/*

class ImageListWidget extends StatefulWidget {
  const ImageListWidget({super.key});

  @override
  State<ImageListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ImageListWidget> {
  final _style = ImageCategoryTheme();
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;
  List<String> images = ['images/assets/chodan.jpg','images/assets/upload_button.png','images/assets/chodan.jpg',
    'images/assets/chodan.jpg','images/assets/upload_button.png','images/assets/chodan.jpg',
    'images/assets/chodan.jpg','images/assets/upload_button.png','images/assets/chodan.jpg',
    'images/assets/chodan.jpg','images/assets/upload_button.png','images/assets/chodan.jpg',
    'images/assets/chodan.jpg','images/assets/upload_button.png','images/assets/chodan.jpg',
    'images/assets/chodan.jpg','images/assets/upload_button.png','images/assets/chodan.jpg',
    'images/assets/chodan.jpg','images/assets/upload_button.png','images/assets/chodan.jpg',
    'images/assets/chodan.jpg','images/assets/upload_button.png','images/assets/chodan.jpg',];


  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      crossAxisCount: 3, // 열의 개수
      crossAxisSpacing: 8.0, // 열 간격
      mainAxisSpacing: 8.0, // 행 간격
      // childAspectRatio: 1.0, // 자식 아이템의 비율
      padding: EdgeInsets.all(8),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(images[index], fit: BoxFit.cover),
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.count(
        1,
        (index % 7 ==0)?2.5:1,
      ),
    );
  }
}

 */


class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  final _style = ImageCategoryTheme();
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return Container(
        width: queryWidth,
        height: 60,
        color: _style.bottomAreaColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home, color : Colors.white),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(Icons.add, size: 30,),
            ),
            Icon(Icons.search, color : Colors.white,),
          ],
        )
    );;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cheese/src/ui/styles/image_category_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';



class ImageListByCategoryWidget extends StatefulWidget {
  const ImageListByCategoryWidget({super.key});

  @override
  State<ImageListByCategoryWidget> createState() => _ImageListByCategoryWidgetState();
}

class _ImageListByCategoryWidgetState extends State<ImageListByCategoryWidget> {
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


    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state){
      if (state is ImageListCategoryState) {
        return Container(
          alignment: Alignment.bottomCenter,
            height: queryHeight * 0.12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: (){
                        BlocProvider.of<CoreBloc>(context).add(NoneBiasHomeDataEvent.none_date());
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.chevron_left),
                    )
                ),
                Container(
                  alignment: Alignment.center,
                  width: queryWidth * 0.75,
                  child: Text(state.imageListCategoryModel.bname,
                    style: _style.biasNameText,),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: (){
                      },
                      icon: Icon(Icons.add),
                    )
                ),
              ],
            ),
          );
      }else{
        return Container(
          alignment: Alignment.center,
          child: const Text("로딩중")
        );
      }
    });
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
          // 여기 수정
          Container(
            height: queryHeight * 0.88 - 110, child: ImageListWidget(),
          )
        ],
      ),
    );
  }
}

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
  List<Container> firstWidgetList = [];
  List<Container> secondWidgetList = [];
  List<Container> thirdWidgetList = [];

  @override
  Widget build(BuildContext context) {
    double queryWidth =  MediaQuery.of(context).size.width;

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
      if (state is ImageListCategoryState) {
        firstWidgetList = makeImageContainerList(queryWidth,
            state.imageListCategoryModel.firstImageList);
        secondWidgetList = makeImageContainerList(queryWidth,
            state.imageListCategoryModel.secondImageList);
        thirdWidgetList = makeImageContainerList(queryWidth,
            state.imageListCategoryModel.thirdImageList);

        return SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                singleColumnImageWidget(queryWidth, firstWidgetList),
                singleColumnImageWidget(queryWidth, secondWidgetList),
                singleColumnImageWidget(queryWidth, thirdWidgetList)
              ],
            )
        );
      } else{
        return Container();
      }
    });
  }

  List<Container> makeImageContainerList(width, iidList){
    List<Container> imageList = [];

    for ( Map image in iidList){
      Container container = Container(
        padding: const EdgeInsets.all(4),
        width: width * 0.3,
        child : Image.network("http://223.130.157.23/images/${image['iid']}.jpg", fit: BoxFit.fitHeight)
      );
      imageList.add(container);
    }
    return imageList;
  }


  Container singleColumnImageWidget(width, List<Widget>imageList){
    return Container(
      padding: EdgeInsets.all(3),
      width: width * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: imageList,
      )
    );
  }
}





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

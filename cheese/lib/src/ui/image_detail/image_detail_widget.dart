import 'package:cheese/src/ui/image_detail/original_image.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/image_detail_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';



class ImageDetailWidget extends StatefulWidget {
  const ImageDetailWidget({super.key});

  @override
  State<ImageDetailWidget> createState() => _ImageDetailWidgetState();
}

class _ImageDetailWidgetState extends State<ImageDetailWidget> {
  var _style = ImageDetailTheme(); // 테마
  final maxWidth = 400.0;
  final maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정

    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop){
        BlocProvider.of<CoreBloc>(context).add(LoadBackwardEvent());
      },
      child: const Scaffold(
        body: Stack(
          children: [
            DetailBodyWidget(),
            TopBarWidget(),
          ],
        )
      )
    );


  }
}

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({super.key});

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  var _style = ImageDetailTheme();
  final maxWidth = 400.0;
  final maxHeight = 900.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }
    
    
    return BlocBuilder<CoreBloc, CoreState>(
      builder: (context, state){
        if ( state is DetailImageState){
          return Container(
            child: Column(
              children: [
                Container(
                  height: queryHeight * 0.03,
                  color: Colors.white,
                ),
                Container(
                  height: queryHeight * 0.07,
                  color: _style.mainWhiteColor,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(state.detailImageModel.bias_name,style: _style.idolNameText,),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: (){
                            BlocProvider.of<CoreBloc>(context).add(LoadBackwardEvent());
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.chevron_left),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else{
          return Container(
            child : Text("로딩중")
            );
        }
       }
    );
  }
}

class DetailBodyWidget extends StatefulWidget {
  const DetailBodyWidget({super.key});

  @override
  State<DetailBodyWidget> createState() => _DetailBodyWidgetState();
}

class _DetailBodyWidgetState extends State<DetailBodyWidget> {
  var _style = ImageDetailTheme();
  final maxWidth = 400.0;
  final maxHeight = 900.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return SingleChildScrollView(
      child: Column(
        children: [
          TopDetailWidget(),
          MiddleDetailWidget(),
          BottomDetailWidget(),
        ],
      ),
    );
  }
}

class TopDetailWidget extends StatefulWidget {
  const TopDetailWidget({super.key});

  @override
  State<TopDetailWidget> createState() => _TopDetailWidgetState();
}

class _TopDetailWidgetState extends State<TopDetailWidget> {
  var _style = ImageDetailTheme();
  final maxWidth = 400.0;
  final maxHeight = 900.0;
  bool _threeDot = false;

  void clickedDot(){
    setState(() {
      _threeDot = !_threeDot;
    });
  }

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) {queryWidth = maxWidth;}
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight > maxHeight) {queryHeight = maxHeight;}

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state){
      if ( state is DetailImageState){
        return Column(
          children: [
            Container(
              height: queryHeight * 0.1,
            ),
            Container(
              height: 0.5,
              color: Colors.grey,
            ),
            Container(
              color: _style.mainWhiteColor,
              width: queryWidth,
              height: 100,
              child: Stack(
                children: [
                  userProfileArea(queryWidth, queryHeight,),
                  dataViewArea(queryWidth, queryHeight, state),
                  threeDotArea(queryWidth, queryHeight),
                  imageDetailArea(queryWidth, queryHeight, state),
                  listOptionArea(queryWidth, queryHeight),
                ],
              ),
            )
          ],
        );
      } else{
        return Container();
      }
    });
  }

  Widget imageDetailArea(width, height, state){
    var model = state.detailImageModel;

    return Column(
      children: [
        Container(
          height: 60
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: 40,
          color: _style.scheduleTitleColor,
          child: Center(
            child: Text('${model.schedule_date} | ${model.schedule_name}',
              style: _style.scheduleTitleText,),
          ),
        )
      ],
    );
  }

  Widget userProfileArea(width, height) {
    return Container(
      width: width * 0.17,
      height: height * 0.058,
      margin: EdgeInsets.only(top: 4),
      child: InkWell(
          onTap: () {},
          child: Container(
            decoration: _style.profileDecoration,
          )
      ),
    );
  }

  Widget dataViewArea(width, height, state){
    var model = state.detailImageModel;

    return Container(
      alignment: Alignment.centerLeft,
      height: height * 0.07,
      child: Row(
        children: [
          SizedBox(width: width * 0.17,),
          Container(
            width: width * 0.43,
            child: Text(model.user_name, style: _style.nickNameText,),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: width * 0.3,
            child: Text(model.upload_date, style: _style.dateText,),
          ),
        ],
      )
    );
  }

  Widget threeDotArea(width, height){
    return Container(
      height: height * 0.07,
      child: Row(
        children: [
          Container(
            width: width * 0.877,
          ),
          IconButton(
            onPressed: (){
              clickedDot();
            },
            icon: Icon(Icons.more_vert,color: _style.threeDotColor,),
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      )
    );
  }

  Widget listOptionArea(width, height){
    return Row(
      children: [
        Container(
          width: width*0.77,
        ),
        Column(
          children: [
            Container(
              height: height * 0.055,
              width: width * 0.2,
            ),
            Container(
              height: _threeDot ? height * 0.061 : 0,
              width: width * 0.16,
              decoration: _style.listOptionDecoration,
              child: Column(
                children: [
                  Container(
                    height: height * 0.028,
                    width: width * 0.16,
                    decoration: _style.divideLineDecoration,
                    child: Center(
                      child: Text('수정하기',style: _style.optionText,),
                    ),
                  ),
                  Container(
                    height: height * 0.028,
                    width: width * 0.16,
                    child: Center(
                      child: Text('삭제하기',style: _style.optionText),
                    ),
                  ),
                ],
              )

            ),
          ],
        )
      ],
    );
  }
}

class MiddleDetailWidget extends StatefulWidget {
  const MiddleDetailWidget({super.key});

  @override
  State<MiddleDetailWidget> createState() => _MiddleDetailWidgetState();
}

class _MiddleDetailWidgetState extends State<MiddleDetailWidget> {
  var _style = ImageDetailTheme();
  final maxWidth = 400.0;
  final maxHeight = 900.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state){
      if (state is DetailImageState) {
        return Column(
          children: [
            //imageDetailArea(queryWidth, queryHeight, state),
            imageViewArea(queryWidth, queryHeight, state),
          ],
        );
      } else{
        return Container();
      }
    });
  }

  Widget imageViewArea(width, height, state){
    var model = state.detailImageModel;
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OriginalImage(iid: model.iid))
        );
      },
      child: Container(
        width: width,
        child:Image.network("https://kr.object.ncloudstorage.com/cheese-images/O${model.iid}.jpg", fit:BoxFit.cover)
      )
    );
  }
}

class BottomDetailWidget extends StatefulWidget {
  const BottomDetailWidget({super.key});

  @override
  State<BottomDetailWidget> createState() => _BottomDetailWidgetState();
}

class _BottomDetailWidgetState extends State<BottomDetailWidget> {
  var _style = ImageDetailTheme();
  final maxWidth = 400.0;
  final maxHeight = 900.0;
  bool likeState = false;
  bool bookMarkState = false;

  void clickLike(){
    setState(() {
      likeState = !likeState;
    });
  }

  void clickBookmark(){
    setState(() {
      bookMarkState = !bookMarkState;
    });
  }
  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state){
      if (state is DetailImageState) {
        return Column(
          children: [
            //Container(
             // height: queryHeight * 0.88),
            upperArea(queryWidth, queryHeight,state),
            Container(height: 1, color: Colors.grey),
            lowerArea(queryWidth, queryHeight,state),
          ],
        );
      }else{
        return Container();
      }
    });
  }

  Widget upperArea(width, height, state){
    return Container(
      //height: height * 0.05,
      height : 52,
      color: _style.mainWhiteColor,
      child: Row(
        children: [
          locationArea(width, height, state),
          likeViewArea(width, height),
          SizedBox(width: 13,),
          actionButtonArea(width, height),
        ],
      ),
    );
  }

  Widget lowerArea(width, height, state){
    var model = state.detailImageModel;
    return Container(
      alignment: Alignment.centerLeft,
      height: 52,
      width: width,
      color: _style.mainWhiteColor,
      padding: EdgeInsets.only(left: 20),
      child: Text(model.image_detail,style: _style.infoText,),
    );
  }

  Widget locationArea(width, height, state){
    var model = state.detailImageModel;
    return Container(
      width: width * 0.3,
      padding: EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.fmd_good_outlined,
                  size: 20,),
                Text(model.location,style: _style.locationText,)
              ],
            )
          ),

        ],
      )
    );
  }

  Widget likeViewArea(width, height){
    return Container(
      alignment: Alignment.centerRight,
      width: width * 0.42,
      child: Text('좋아요 1,234개',style: _style.likeText),
    );
  }

  Widget actionButtonArea(width, height){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: (){
            setState(() {
              clickLike();
            });
          },
          icon: Icon(
            likeState ? Icons.favorite : Icons.favorite_border,
            color: likeState ? Colors.red : Colors.black,),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          visualDensity: VisualDensity(horizontal: -4),
        ),
        IconButton(
          onPressed: (){
            clickBookmark();
          },
          icon: Icon(
            bookMarkState ? Icons.bookmark : Icons.bookmark_border,
            color: bookMarkState ? Colors.green : Colors.black),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          visualDensity: VisualDensity(horizontal: -4),
        ),
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.share),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          visualDensity: VisualDensity(horizontal: -4),
        )
      ],
    );
  }
}


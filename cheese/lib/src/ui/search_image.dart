import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cheese/src/ui/styles/image_category_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/ui/image_list/image_list_category_widget.dart' hide TopBarWidget;

final _formKey = GlobalKey<FormState>();

class SearchImagePage extends StatefulWidget {
  const SearchImagePage({super.key});

  @override
  State<SearchImagePage> createState() => _SearchImagePageState();
}

class _SearchImagePageState extends State<SearchImagePage> {
  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;
    return PopScope(
        canPop: true,
        onPopInvoked: (bool didPop){
          BlocProvider.of<CoreBloc>(context).add(CoreRefreshEvent());
        },
        child: const Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              TopBarWidget(),
              SearchBodyWidget(),
              BottomBarWidget()
            ],
          ),
        )
    );
  }
}

class SearchBodyWidget extends StatefulWidget {
  const SearchBodyWidget({super.key});

  @override
  State<SearchBodyWidget> createState() => _SearchBodyWidgetState();
}

class _SearchBodyWidgetState extends State<SearchBodyWidget> {
  final _style = ImageCategoryTheme();

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SearchInputWidget(),
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
            height: queryHeight * 0.88 - 150, child: ImageListWidget(),
          )
        ],
      ),
    );
  }
}

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({super.key});

  @override
  State<SearchInputWidget> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInputWidget> {
  final _style = ImageCategoryTheme();
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;
  TextEditingController searchInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          height: 40,
          width: queryWidth * 0.8,
          child: TextFormField(
            key: _formKey,
            controller: searchInputController,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                  onTap: (){
                    searchInputController.text = "";
                  },
                  child: Icon(Icons.close,size: 20,),
              ),
            ),
          )
        ),
        InkWell(
          onTap: (){
            BlocProvider.of<CoreBloc>(context).
            add(ImageSearchEvent(searchInputController.text, "like"));
          },
          child: Container(
              alignment: Alignment.center,
              height: 40,
              width: queryWidth * 0.2 - 11,
              child: const Text("검색")
          ),
        )
      ],
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
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          height: queryHeight * 0.02,
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: queryHeight * 0.1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: (){
                      BlocProvider.of<CoreBloc>(context).add(LoadBackwardEvent());
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.chevron_left),
                  )
              ),
              Container(
                alignment: Alignment.center,
                width: queryWidth * 0.75,
                child: Text("검색",
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
        )
      ],
    );

  }
}

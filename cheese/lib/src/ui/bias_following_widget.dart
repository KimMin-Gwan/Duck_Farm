import 'package:cheese/src/ui/styles/bias_following_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';

class BiasFollowingWidget extends StatefulWidget {
  const BiasFollowingWidget({super.key});

  @override
  State<BiasFollowingWidget> createState() => _BiasFollowingWidgetState();
}

class _BiasFollowingWidgetState extends State<BiasFollowingWidget> {
  final BiasFollowingTheme _style = BiasFollowingTheme(); // 테마
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBarWidget(),
            Container(
              height: queryHeight,
              child: BiasListWidget(),
            ),
            // AddButtonWidget(),
          ],
        ),
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
  final BiasFollowingTheme _style = BiasFollowingTheme(); // 테마
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
      height: queryHeight * 0.08,
      child: Row(
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
            width: queryWidth * 0.6,
            child: Text('목록', style: _style.titleTextStyle,),
          ),
          InkWell(
            onTap: (){},
            child: Container(
              width: queryWidth * 0.1,
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){},
                  child: Text('추가',style: _style.addSaveTextStyle,),
                )
            ),
          ),
          InkWell(
            onTap: (){},
            child: Container(
              width: queryWidth * 0.1,
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){},
                  child: Text('저장',style: _style.addSaveTextStyle,),
                )
            ),
          )
        ],
      ),
    );
  }
}

class BiasListWidget extends StatefulWidget {
  const BiasListWidget({super.key});

  @override
  State<BiasListWidget> createState() => _BiasListWidgetState();
}

class _BiasListWidgetState extends State<BiasListWidget> {
  final BiasFollowingTheme _style = BiasFollowingTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;
  List<String> items = ["one","one4","one5","one6","one7","two","two3", "three", "four", "five"];

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return ReorderableListView(
      buildDefaultDragHandles: false,
      children: [
        for(int index =0; index<items.length; index++)
          Container(
            height: 100,
            key: Key('$index'),
            decoration: _style.listBoxDecoration,
            child: Row(
              children: [
                Container(
                  width: 50,
                  child: ReorderableDragStartListener(
                      child: Icon(Icons.menu, size: 16,),
                      index: index
                  ),
                ),
                Container(
                    width: 70,
                    height: 70,
                    margin: EdgeInsets.only(right: 15),
                    decoration: _style.profileImageBoxDecoration
                ),
                Container(
                  width: queryWidth * 0.55,
                  child: Text(items[index], style:_style.idolNameTextStyle),
                ),
                Container(
                  width: 32,
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    onPressed: (){},
                    icon: Icon(Icons.close, size: 15,),
                  ),
                )
              ],
            ),
          )
      ],
      onReorder: (oldIndex, newIndex){
          setState(() {
            if(oldIndex < newIndex){
              newIndex -= 1;
            }
            final String item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
        },
    );
  }
}

class AddButtonWidget extends StatefulWidget {
  const AddButtonWidget({super.key});

  @override
  State<AddButtonWidget> createState() => _AddButtonWidgetState();
}

class _AddButtonWidgetState extends State<AddButtonWidget> {
  final BiasFollowingTheme _style = BiasFollowingTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) { queryWidth = maxWidth; }

    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) { queryHeight = maxHeight; }

    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(0),
            ),
            child: Icon(Icons.add)
        ),
      )
    );
  }
}


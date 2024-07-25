import 'package:cheese/src/ui/styles/bias_following_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/data_domain/data_domain.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/ui/home_widget/bias_add_widget.dart';

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
    double queryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            topBarWidget(context),
            Container(
              height: queryHeight,
              child: const BiasListWidget(),
            ),
            // AddButtonWidget(),
          ],
        ),
      )
    );
  }

  @override
  Widget topBarWidget(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;

    double queryHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          height: queryHeight * 0.03,
          color: Colors.white
        ),
        Container(
          width: queryWidth,
          height: queryHeight * 0.07,
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
                onTap: () => _showModalBottomSheet(context),
                child: Container(
                    width: queryWidth * 0.1,
                    alignment: Alignment.centerRight,
                    child: Text('추가',style: _style.addSaveTextStyle,),
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
        )
      ],
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimatedScrollableBottomSheet(); // 제작한 바텀 시트 반환한다
      },
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
  //List<String> items = ["one","one4","one5","one6","one7","two","two3", "three", "four", "five"];

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    double queryHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
          if (state is BiasListState) {
            return ReorderableListView(
              buildDefaultDragHandles: false,
              children: [
                for(int index =0; index<state.biasListModel.biasList.length; index++)
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
                            decoration: _style.profileImageBoxDecoration,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/T${state.biasListModel.biasList[index].bid}.jpg")
                          ),
                        ),
                        Container(
                          width: queryWidth * 0.55,
                          child: Text(state.biasListModel.biasList[index].bname, style:_style.idolNameTextStyle),
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
                  final Bias item = state.biasListModel.biasList.removeAt(oldIndex);
                  state.biasListModel.biasList.insert(newIndex, item);
                });
              },
            );
        } else{
            return Container();
        }
      }
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


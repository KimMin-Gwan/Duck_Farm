import 'package:cheese/src/model/utility_model.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/bloc/utility_bloc/utility_bloc.dart';
import 'package:cheese/src/bloc/utility_bloc/utility_event.dart';
import 'package:cheese/src/bloc/utility_bloc/utility_state.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';

import 'package:cheese/src/ui/styles/bias_add_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/data_domain/data_domain.dart' hide Image;

/*

class BiasAddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 텍스트필드로 인해 키보드 올라올때 메인화면 움직이지X.
      body: Center(
        // 추후 버튼 바꾸기, 버튼 누르면 -> 모달바텀시트 나온다.
        child: ElevatedButton(
          onPressed: () => _showModalBottomSheet(context),
          child: Text('새 창 열기'),
        ),
      ),
    );
  }

  // 모달 바텀 시트 표시 함수
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

 */

// 바텀 시트 위젯.
class AnimatedScrollableBottomSheet extends StatefulWidget {
  @override
  _AnimatedScrollableBottomSheetState createState() =>
      _AnimatedScrollableBottomSheetState();
}

class _AnimatedScrollableBottomSheetState
    extends State<AnimatedScrollableBottomSheet> with WidgetsBindingObserver {
  double _height = 400.0; // 초기 높이
  final double _minHeight = 400.0; // 최소 높이
  final double _maxHeight = 600.0; // 최대 높이
  final FocusNode _focusNode = FocusNode(); // 포커스 노드 생성
  final ScrollController _scrollController = ScrollController(); // 스크롤 컨트롤러 생성
  final TextEditingController _textController = TextEditingController(); // 텍스트 컨트롤러 생성


  // 변경 리스너 등록
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusNode.addListener(_onFocusChange);
    _scrollController.addListener(_onScroll);
  }

  // 해제
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  // 포커스 변경되면 호출
  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        _height = _maxHeight;
      });
    }
  }

  // 스크롤되면 높이 변환
  void _onScroll() {
    if (_scrollController.position.pixels == 0) {
      setState(() {
        _height = _minHeight;
      });
    } else {
      setState(() {
        _height = _maxHeight;
      });
    }
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0.0) {
      setState(() {
        _height = _maxHeight;
      });
    } else if (!_focusNode.hasFocus) {
      setState(() {
        _height = _minHeight;
      });
    }
  }

  List<bool> _isFollowing = List.generate(20, (index) => false);
  SearchBiasModel _searchBiasModel = SearchBiasModel(stateCode: "500", biasList: []);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UtilityBloc, UtilityState>(
        listener: (context, state) {
          if (state is InitUtilityState) {
            BlocProvider.of<UtilityBloc>(context).add(SearchBiasEvent(_textController.text));
          }else if(state is SearchBiasState){
            setState(() {
              _searchBiasModel = state.searchBiasModel;
            });
          }
        },
      child : AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        height: _height,
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: Text(
                      '취소',
                      style: BiasAddTheme().cancelText
                  ),
                ),
                const Text(
                  '최애 추가하기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: onSave,
                  child: Text(
                      '저장',
                      style: BiasAddTheme().saveText
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
              child: TextField(
                focusNode: _focusNode,
                controller: _textController,
                onChanged: (String keyword){
                  BlocProvider.of<UtilityBloc>(context).add(SearchBiasEvent(keyword));
                },
                decoration: InputDecoration(
                  // labelText: '최애입력',
                  suffixIcon: Transform.translate(
                    offset: Offset(0, 10),
                    child: IconButton(
                      icon: Icon(Icons.clear, size: 20),
                      onPressed: () {
                        _textController.clear();
                      },
                    ),
                  ),
                  focusedBorder: BiasAddTheme().focusUnderLine,
                  enabledBorder: BiasAddTheme().basicUnderLine,
                ),
              ),
            ),

            Container(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0), // 수평 방향으로만 패딩 추가
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _searchBiasModel.biasList.length,
                    itemBuilder: (context, index) {
                      Bias bias = _searchBiasModel.biasList[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), // ListTile의 패딩 조정
                        leading: CircleAvatar(
                          radius: 13.0,
                          backgroundImage: NetworkImage("https://kr.object.ncloudstorage.com/cheese-images/T${bias.bid}.jpg")
                        ),
                        title: Text(bias.bname),
                        trailing: TextButton(
                          onPressed: () {
                            BlocProvider.of<UtilityBloc>(context)
                            .add(FollowBiasEvent(bias.bid, _textController.text));
                            BlocProvider.of<CoreBloc>(context)
                            .add(CoreRefreshEvent());
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: _searchBiasModel.followedBidList[index] ? BiasAddTheme().mainWhiteColor : BiasAddTheme().mainPurpleColor// 텍스트 색상
                          ),
                          child: Text(_searchBiasModel.followedBidList[index] ? '팔로잉' : '팔로우'),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Column(
              children: [
                Container(
                  height: 55,
                  child: Image.asset("images/assets/add_bias.png")
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0), // 버튼 밖에 패딩 추가
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BiasAddTheme().mainPurpleColor, // 버튼 배경색
                      foregroundColor: BiasAddTheme().mainWhiteColor, // 버튼 텍스트 색상
                      minimumSize: const Size(double.infinity, 45), // 가로는 화면 전체, 세로는 45으로 설정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // 모서리를 둥글게
                      ),
                    ),
                    child: const Text('요청하러 가기'),
                  ),
                ),
              ],
            ),

          ],
        ),
      )
    );
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

  void onSave() {
    // 저장 로직 구현
    Navigator.of(context).pop();
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MainTheme {
  // 색상 확인하고 추후 옮길것
  Color mainWhiteColor = Color(0xFFFFFFFF);
  Color mainPurpleColor=Color(0xFF5941DA);
  Color mainGreyColor=Color(0xFF595959);
}

class HomeTheme extends MainTheme {
  // BiasWidget
  BoxDecoration mainBoxDecoration = BoxDecoration();
  TextStyle saveText = TextStyle();
  TextStyle cancelText = TextStyle();
  UnderlineInputBorder focusUnderLine=UnderlineInputBorder();
  UnderlineInputBorder basicUnderLine=UnderlineInputBorder();
  CircleAvatar biasImage= CircleAvatar();


  HomeTheme() {
    saveText = TextStyle(
      color: mainPurpleColor,
      fontSize: 16,
    );

    cancelText=TextStyle(
      color: mainGreyColor,
      fontSize: 16,
    );

    focusUnderLine=UnderlineInputBorder(
      borderSide: BorderSide(color: mainGreyColor), // 포커스 밑줄 색상
    );

    basicUnderLine=UnderlineInputBorder(
      borderSide: BorderSide(color: mainGreyColor), // 기본 밑줄 색상
    );

    biasImage=CircleAvatar(
      radius: 13.0,
      backgroundColor:mainPurpleColor, // 원형 도형 색상(임시. 삭제할 것)
      // backgroundImage: AssetImage('assets/images/person.png'), // 추후 이미지 넣을 것!
    );
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // *No MaterialLocalizations found 발생으로 인해 HomePage() 따로 생성!
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
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
        return _AnimatedScrollableBottomSheet(); // 제작한 바텀 시트 반환한다
      },
    );
  }
}

// 바텀 시트 위젯.
class _AnimatedScrollableBottomSheet extends StatefulWidget {
  @override
  __AnimatedScrollableBottomSheetState createState() =>
      __AnimatedScrollableBottomSheetState();
}

class __AnimatedScrollableBottomSheetState
    extends State<_AnimatedScrollableBottomSheet> with WidgetsBindingObserver {
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

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
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
                    style: HomeTheme().cancelText
                ),
              ),
              Text(
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
                    style: HomeTheme().saveText
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            child: TextField(
              focusNode: _focusNode,
              controller: _textController,
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
                focusedBorder: HomeTheme().focusUnderLine,
                enabledBorder: HomeTheme().basicUnderLine,
              ),
            ),
          ),

          Container(
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0), // 수평 방향으로만 패딩 추가
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // ListTile의 패딩 조정
                      leading: HomeTheme().biasImage,
                      title: Text('Item $index'),
                      trailing: TextButton(
                        onPressed: () {
                          setState(() {
                            _isFollowing[index] = !_isFollowing[index];
                          });
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: _isFollowing[index] ? HomeTheme().mainWhiteColor : HomeTheme().mainPurpleColor// 텍스트 색상
                        ),
                        child: Text(_isFollowing[index] ? '팔로잉' : '팔로우'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          Column(
            children: [
              Icon(
                Icons.chat_bubble_outline,
                color: HomeTheme().mainPurpleColor, // 아이콘 색상
                size: 50.0, // 아이콘 크기
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0), // 버튼 밖에 패딩 추가
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('요청하러 가기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HomeTheme().mainPurpleColor, // 버튼 배경색
                    foregroundColor: HomeTheme().mainWhiteColor, // 버튼 텍스트 색상
                    minimumSize: Size(double.infinity, 45), // 가로는 화면 전체, 세로는 45으로 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 모서리를 둥글게
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
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

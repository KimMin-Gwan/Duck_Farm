import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/sign_widget/login_try_widget.dart ';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MemberInfoWidget extends StatefulWidget {
  const MemberInfoWidget({super.key});

  @override
  State<MemberInfoWidget> createState() => _MemberInfoWidgetState();
}

class _MemberInfoWidgetState extends State<MemberInfoWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;
  String yourInfo = '반갑습니다! \n회원님의 정보를 입력해주세요.';

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
      body: SafeArea(
        child: Column(
          children: [
            TopBarWidget(),
            BodyWidget().titleArea(queryWidth, queryHeight, yourInfo),
            InputInfoWidget(),
            SizedBox(
              height: 20,
            ),
            BodyWidget().functionButton(queryWidth, queryHeight, '다음'),
          ],
        ),
      ),
    );
  }
}

class InputInfoWidget extends StatefulWidget {
  const InputInfoWidget({super.key});

  @override
  State<InputInfoWidget> createState() => _InputInfoWidgetState();
}

class _InputInfoWidgetState extends State<InputInfoWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;
  final maskedFormatter = MaskTextInputFormatter(
    mask: '###### - #######',
    filter: {'#': RegExp(r'[0-9]')},
  );

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

    return Column(
      children: [
        nameInputArea(queryWidth, queryHeight),
        birthInputArea(queryWidth, queryHeight),
      ],
    );
  }

  Widget nameInputArea(width, height) {
    return Container(
      height: height * 0.1,
      width: width * 0.8,
      child: TextFormField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          label: Text('이름'),
          suffixIcon: Icon(Icons.close),
        ),
      ),
    );
  }

  Widget birthInputArea(width, height) {
    return Container(
      height: height * 0.1,
      width: width * 0.8,
      child: TextFormField(
        inputFormatters: [maskedFormatter],
        keyboardType: TextInputType.number,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          label: Text('생년월일'),
          suffixIcon: Icon(Icons.close),
        ),
      ),
    );
  }
}

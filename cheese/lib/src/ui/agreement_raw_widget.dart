import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:cheese/src/ui/login_widget.dart';
import 'package:cheese/src/ui/login_try_widget.dart';

class AgreementRawWidget extends StatefulWidget {
  const AgreementRawWidget({super.key});

  @override
  State<AgreementRawWidget> createState() => _AgreementRawWidgetState();
}

class _AgreementRawWidgetState extends State<AgreementRawWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

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
            mainTitleArea(queryWidth, queryHeight),
            SizedBox(
              height: 20,
            ),
            Text('치즈의 이용 약관에 동의해주세요.'),
            SizedBox(
              height: 40,
            ),

          ],
        ),
      ),
    );
  }
}

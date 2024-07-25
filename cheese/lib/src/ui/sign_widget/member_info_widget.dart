import 'package:flutter/material.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';
//import 'package:cheese/src/ui/sign_widget/login_try_widget.dart ';

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({super.key});

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
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

    return Container(
      height: queryHeight * 0.1,
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.chevron_left,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class TitleArea extends StatelessWidget {
  final double width;
  final double height;
  final String text;

  const TitleArea({super.key, required this.width,
    required this.height,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: height * 0.1,
      width: width * 0.8,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }
}

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
  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  bool flag = false;

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
            TitleArea(
                width:queryWidth,
                height:queryHeight,
                text:yourInfo),
            inputInfoArea(),
            const SizedBox(height: 20,),
            functionButton(queryWidth,
                queryHeight, '다음', context)
          ],
        ),
      ),
    );
  }

  Widget functionButton(width, height, text, context) {
    return InkWell(
      onTap: () {
        print(birthdayController.text.length);
        if (birthdayController.text.length == 16){
          BlocProvider.of<SignBloc>(context).add(
              NameBirthdayInputEvent(
                  nameController.text,
                  birthdayController.text
              )
          );
        }
      },
      child: Container(
        width: width * 0.8,
        height: height * 0.05,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  final maskedFormatter = MaskTextInputFormatter(
    mask: '###### - #######',
    filter: {'#': RegExp(r'[0-9]')},
  );


  @override
  Widget inputInfoArea() {
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
        controller: nameController,
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
        controller: birthdayController,
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

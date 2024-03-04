import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/models/user_model.dart';
import 'package:cheese/src/bloc/user_bloc.dart';
import 'package:cheese/src/ui/sign/style.dart';

// OTPPASSWORDWIDGET
import 'package:cheese/src/ui/sign/sign_up_widget.dart';


class FindEmailWidget extends StatefulWidget {
  const FindEmailWidget({super.key});

  @override
  State<FindEmailWidget> createState() => _FindEmailWidgetState();
}

class _FindEmailWidgetState extends State<FindEmailWidget> {
  final FindEmailBloC findEmailBloC = FindEmailBloC();
  var _style = SignInWidgetTheme();
  final maxWidth = 400.0;
  final maxHeight = 1200.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) {
      queryWidth = maxWidth;
    }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryWidth > maxHeight) {
      queryWidth = maxHeight;
    }
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: _style.getGray(),
            child: Container(
              alignment: Alignment.center,
              width: queryWidth,
              height: queryHeight,
              padding: EdgeInsets.all(40),
              decoration: _style.getMainBoxTheme(),
              child: EmailWidget(queryWidth, queryHeight),
            )
        )
    );
  }

  final _formKey = GlobalKey<FormState>(); // 폼스테이트 관리
  TextEditingController emailController = TextEditingController();
  bool _isEmailVisible = true;
  bool _buttonColor = false;

  Widget EmailWidget(width, height){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          alignment: Alignment.centerLeft,
          width: width,
          height: 100,
          child: Text("ID 찾기", style: _style.getMainText()),
        ),
        Container(
            width: width,
            height: 140,
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () => emailController.clear(),
                      icon: Icon(Icons.clear)),
                  hintText: _isEmailVisible? '이메일 주소를 입력해 주세요': '',
                  hintStyle: _style.getTextFieldLabelTextStyle(),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.fromLTRB(0,24,0,0),
                  focusedBorder: UnderlineInputBorder(
                    borderSide : _style.getTextFieldBorder(),
                  ),
                ),
                style: _style.getTextFieldLabelTextStyle(),
                onTap: () {
                    _isEmailVisible= false;
                },
                onChanged: (value){
                  setState(() {
                    if(emailController.text.length > 0){
                      _buttonColor = true;
                    }else{
                      _buttonColor = false;
                    }
                  });
                },
              )
            )
        ),
        Container(
          margin :EdgeInsets.fromLTRB(0, 20, 0, 20),
          width: width * 0.7,
          height: 30,
          child: ElevatedButton(
            style: _buttonColor? _style.getLoginButtonTheme(): _style.getLoginButtonDarkTheme(),
            child: Text('ID 찾기', style: _style.getLoginButtonText()),
            onPressed: ()async{
              // _emailValidation 체크하고 넘어가야됨
              findEmailBloC.setEmail(emailController.text);
              FindEmailModel findEmailModel = await findEmailBloC.fetchEmail();
              if (findEmailModel.getResult()){
                // 이곳에 Email 결과에 따른 창을 작성
                print("존재하는 Email 입니다");
              }else{
                print("존재하지 않는 Email 입니다");
              }
            },
          )
        )
      ],
    );
  }
}


class FindPasswordWidget extends StatefulWidget {
  const FindPasswordWidget({super.key});

  @override
  State<FindPasswordWidget> createState() => _FindPasswordWidget();
}

class _FindPasswordWidget extends State<FindPasswordWidget> {
  final FindEmailBloC findEmailBloC = FindEmailBloC();
  final SignUpBloC signUpBloC = SignUpBloC();
  var _style = SignInWidgetTheme();
  final maxWidth = 400.0;
  final maxHeight = 1200.0;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth) {
      queryWidth = maxWidth;
    }
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryWidth > maxHeight) {
      queryWidth = maxHeight;
    }
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: _style.getGray(),
            child: Container(
              alignment: Alignment.center,
              width: queryWidth,
              height: queryHeight,
              padding: EdgeInsets.all(40),
              decoration: _style.getMainBoxTheme(),
              child: EmailWidget(queryWidth, queryHeight),
            )
        )
    );
  }

  final _formKey = GlobalKey<FormState>(); // 폼스테이트 관리
  TextEditingController emailController = TextEditingController();
  bool _isEmailVisible = true;
  bool _buttonColor = false;

  Widget EmailWidget(width, height){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          alignment: Alignment.centerLeft,
          width: width,
          height: 100,
          child: Text("비밀번호 찾기", style: _style.getMainText()),
        ),
        Container(
            width: width,
            height: 140,
            child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => emailController.clear(),
                        icon: Icon(Icons.clear)),
                    hintText: _isEmailVisible? '이메일 주소를 입력해 주세요': '',
                    hintStyle: _style.getTextFieldLabelTextStyle(),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.fromLTRB(0,24,0,0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide : _style.getTextFieldBorder(),
                    ),
                  ),
                  style: _style.getTextFieldLabelTextStyle(),
                  onTap: () {
                    _isEmailVisible= false;
                  },
                  onChanged: (value){
                    setState(() {
                      if(emailController.text.length > 0){
                        _buttonColor = true;
                      }else{
                        _buttonColor = false;
                      }
                    });
                  },
                )
            )
        ),
        Container(
            margin :EdgeInsets.fromLTRB(0, 20, 0, 20),
            width: width * 0.7,
            height: 30,
            child: ElevatedButton(
              style: _buttonColor? _style.getLoginButtonTheme(): _style.getLoginButtonDarkTheme(),
              child: Text('비밀번호 찾기', style: _style.getLoginButtonText()),
              onPressed: ()async{
                // _emailValidation 체크하고 넘어가야됨
                //findEmailBloC.setEmail(emailController.text);
                //FindEmailModel findEmailModel = await findEmailBloC.fetchEmail();
                /*
                if (findEmailModel.getResult()){
                  // 이곳에 Email 결과에 따른 창을 작성
                  print("존재하는 Email 입니다");
                  //signUpBloC.setEmail(emailController.text);
                }else{
                  print("존재하지 않는 Email 입니다");
                }
                 */
                //Navigator는 위의 조건문으로 올라가야함
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OTPnPasswordWidget(signUpBloC: signUpBloC)),
                );
              },
            )
        )
      ],
    );
  }
}

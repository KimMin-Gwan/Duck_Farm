//import 'package:flutter/cupertino.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/models/user_model.dart';
import 'package:cheese/src/bloc/user_bloc.dart';
import 'package:cheese/src/ui/style.dart';


class SignInWidget extends StatefulWidget {
  SignInWidget({Key? key}) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final SignInBloC signInBloC = SignInBloC();
  var _style = SignInWidgetTheme();
  final maxWidth = 400.0;
  final maxHeight = 1200.0;


  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    // 가로 최대 길이를 400으로 한정
    if (queryWidth > maxWidth){queryWidth = maxWidth;}
    double queryHeight = MediaQuery.of(context).size.height;
    // 세로 최대 길이를 1200으로  한정
    if (queryWidth > maxHeight){queryWidth = maxHeight;}

    // 좌우 여백을 위해 0.8 만큼을 사용하려고 시도했음
    //double mainContainerWidth = queryWidth * 0.8;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: queryHeight * 0.03
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0,20,0,0),
              width: queryWidth,
              height: queryHeight * 0.07,
              child: Text("로그인",
                style: _style.getMainText(),
              ),
            ),
            Container(
              child: LoginForm(queryWidth, queryHeight),
            ),
            Container(
              child: SimpleLoginForm(queryWidth, queryHeight),
            ),
          ],
        ),
        ),
        )
      );
    }

    // 간편로그인 위젯
    Widget SimpleLoginForm(width, height){
      return Column(
        children:[
          Container(
            // 겹쳐 올리기 위해서 Stack구조 사용
            child: Stack(
            alignment: Alignment.center,
              children: [
                // 기다란 가로줄(하얀색)
                Container(
                    width: width,
                    height: 0.5,
                    color: _style.getWhite()
                ),
                Container(
                    width: 120,
                    height: 40,
                    color: _style.getBoxColor(),
                    alignment: Alignment.center,
                    child: Text("간편 로그인", style: _style.getSimpleLoginText()))
              ]
              )
            ),
          Container(
            alignment: Alignment.center,
            width: width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  // 간편로그인 API 호출 위치
                  onPressed: (){},
                  icon: Image.asset('kakao.png',
                  width: 80,
                  height: 30)
                ),
                IconButton(
                  // 간편로그인 API 호출 위치
                    onPressed: (){},
                    icon: Image.asset('naver.png',
                        width: 80,
                        height: 30)
                ),
              ],
            )
          )

          ]
          );
    }

    final _formKey = GlobalKey<FormState>(); // 폼스테이트 관리
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Widget LoginForm(width, height) {
      bool _isEmailVisible = true; //텍스트가 적혔는지 확인
      bool _isPasswordVisible = true; //비밀번호가 적혔는지 확인
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin :EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => emailController.clear(), // 지우기 버튼
                    icon: Icon(Icons.clear)),
                  hintText: _isEmailVisible ? '이메일 주소': '', // 텍스트 적으면 지워지기
                  hintStyle: _style.getTextFieldLabelTextStyle(),
                  isCollapsed: true, // 내부 텍스트 띄우기위해
                  contentPadding: EdgeInsets.fromLTRB(0,24,0,0), //내부 텍스트 마진
                  focusedBorder: UnderlineInputBorder( // 밑줄?
                    borderSide : _style.getTextFieldBorder(),
                  ),
                ),
                style: _style.getTextFieldLabelTextStyle(),
                onTap: () {
                  _isEmailVisible = false; //적히면 내부 내용 지워야됨
                },
                onChanged: (value) {
                  setState(() => signInBloC.setEmail(emailController.text));
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '적절한 Email 주소를 입력해주세요.';
                  }
                  return null;
                }
              ),
            ),
            Container(
            margin :EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () => passwordController.clear(),
                    icon: Icon(Icons.clear)),
                hintText: _isPasswordVisible? '비밀번호': '',
                hintStyle: _style.getTextFieldLabelTextStyle(),
                isCollapsed: true,
                contentPadding: EdgeInsets.fromLTRB(0,24,0,0),
                focusedBorder: UnderlineInputBorder(
                  borderSide : _style.getTextFieldBorder(),
                ),
              ),
              style: _style.getTextFieldLabelTextStyle(),
              onTap: () {
                _isPasswordVisible = false;
              },
              onChanged: (value) {
                setState(() => signInBloC.setPassword(passwordController.text));
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요.';
                }
                  return null;
                },
              )
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextButton(
                        onPressed: () {
                          //새로운 화면으로 이동(새 화면 푸쉬)
                          //Navigator.push(
                          //context,
                          //MaterialPageRoute(builder: (context) => find.FindIDPW()),
                          //); //아이디/비밀번호 찾는 화면으로 빌드
                        },
                        child: Text('아이디를 잃어버리셨나요?',
                            style: _style.getOptionText())),

                  ),
                  Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextButton(
                    onPressed: () {
                    //새로운 화면으로 이동(새 화면 푸쉬)
                    //Navigator.push(
                    //context,
                    //MaterialPageRoute(builder: (context) => find.FindIDPW()),
                    //); //아이디/비밀번호 찾는 화면으로 빌드
                    },
                    child: Text('비밀번호를 잃어버리셨나요?',
                    style: _style.getOptionText())),
                  )
                ]
              )
            ),
            Container(
              margin :EdgeInsets.fromLTRB(0, 20, 0, 20),
              width: width * 0.7,
              height: 30,
              child: ElevatedButton(
                style: _style.getLoginButtonTheme(),
                child: Text('로그인', style: _style.getLoginButtonText()),
                onPressed: (){
                  if (_formKey.currentState!.validate()){
                    signInButtonBuild(context);
                    signInBloC.fetchSignIn();
                  };
                },
              )
            )
          ]
        )
      );

    }

  Widget signInButtonBuild(BuildContext context) {
    print("sign in try");
    return StreamBuilder(
        stream: signInBloC.signInModel,
        builder: (BuildContext context, AsyncSnapshot<SignInModel> snapshot){
          if (snapshot.hasData){
            return signInBuild(snapshot);
          } else if(snapshot.hasError) {
            print("sign in error");
            return Text(snapshot.error.toString());
          }
          print("sign in deny");
          return Center(child: CircularProgressIndicator());
        },
    );
  }

  Widget signInBuild(AsyncSnapshot<SignInModel> snapshot){
    var data = snapshot.data;
    // 홈화면으로 넘어가야하는데 snapshot.data == _User데이터이기 때문에 이를 활용해야함
    return Text("Login Success");
  }
}








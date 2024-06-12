import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/models/user_model.dart';
import 'package:cheese/src/bloc/user_bloc.dart';
import 'package:cheese/src/ui/sign/style.dart';

import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:convert';

class TermWidget extends StatefulWidget {
  const TermWidget({super.key});

  @override
  State<TermWidget> createState() => _TermWidgetState();
}

class _TermWidgetState extends State<TermWidget> {
  final SignUpBloC signUpBloC = SignUpBloC();
  var _style = SignUpWidgetTheme();
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
              child: termWidget(queryWidth, queryHeight),
            )
        )
    );
  }

  Widget termWidget(width, height){
    bool value = true;
    return Column(
        children:[
          Container(
            width: width,
            height : 30,
            child: Text('약관 동의', style: _style.getMainText())
          ),
          Container(
            alignment: Alignment.center,
            width: width * 0.8,
            height : height* 0.6,
            color: _style.getWhiteGray(),
            child: Text('약관')
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              width: width,
              height: 30,
              child: ElevatedButton(
                  style: _style.getButtonAsOption(value),
                  // 모두 동의했다면 value값을 변경해서 버튼을 활성화
                  //style: _style.getLoginButtonTheme(value),
                  child: Text('다음', style: _style.getSimpleButtonText()),
                  onPressed: (){
                    /*
            if (_formKey.currentState!.validate()){
              signInButtonBuild(context);
              signInBloC.fetchSignIn();
             */
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpWidget()),
                    );
                  }
              )
          )
        ]
    );
  }
}





class SignUpWidget extends StatefulWidget {
  SignUpWidget({Key? key}) : super(key: key);
  //const Sign_Up_Widget({super.key});

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
//State<Sign_Up_Widget> createState() => _Sign_Up_WidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final SignUpBloC signUpBloC = SignUpBloC();
  var _style = SignUpWidgetTheme();
  final maxWidth = 400.0;
  final maxHeight = 1200.0;
  bool _genderInputChecker = false;
  bool _birthdayInputChecker= false;
  bool _emailInputChecker= false;
  Duration _duration = Duration(milliseconds: 400);
  bool _animationEnd = false;  // 날짜 입력칸 애니메이션 확인용
  bool _animationEnd2 = false; // 이메일 입력칸 애니메이션 확인용
  String _emailValidation = '';
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool _isEmailVisible = false;

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
              child: signUpWidget(queryWidth, queryHeight),
            )
        )
    );
  }

  Widget signUpWidget(width, height){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child:SingleChildScrollView(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  width: width,
                  height: _birthdayInputChecker? 150 : 0,
                  child: _animationEnd2? getEmailWidget(width, height) : SizedBox(),
                  onEnd:() {
                    setState(() {
                      _animationEnd2 = true;
                    });
                  },
                ),
                AnimatedContainer(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  width: width,
                  height: _genderInputChecker? 150 : 0,
                  child: _animationEnd? getBirthdayWidget(width, height): SizedBox(),
                  onEnd:() {
                    setState(() {
                      _animationEnd = true;
                    });
                    },
                ),
                AnimatedContainer(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  width: width,
                  height: 150,
                  child: getGenderWidget(width, height),
                ),
              ]
            )
          )
        ),
        SizedBox(
          width: width,
          height: _emailInputChecker? 50 : 0,
          child: ElevatedButton(
            style: _style.getSimpleButton(),
            child: Text('이메일 인증하기', style: _style.getSimpleButtonText()),
            onPressed: (){
              // _emailValidation 체크하고 넘어가야됨
              if(signUpBloC.validEmail(emailController.text)){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OTPnPasswordWidget(signUpBloC: signUpBloC))
                );
              }else{
                setState(() {
                  _emailValidation = '잘못된 이메일 형식입니다.';
                });
              }
            },
          )
        )
      ],
    );
  }



  Widget getEmailWidget(width, height){
    return Column(
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        alignment: Alignment.centerLeft,
        width: width,
        height: 70,
        child: Text('이메일을 알려주세요', style: _style.getMainText()),
      ),
      Container(
        width: width,
        height: 40,
        child: Form(
          key: _formKey2,
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () => emailController.clear(),
                  icon: Icon(Icons.clear)),
              hintText: _isEmailVisible? 'email00@email.com': '',
              hintStyle: _style.getEmailTextFieldLabelTextStyle(),
              isCollapsed: true,
              contentPadding: EdgeInsets.fromLTRB(0,10,0,0),
              focusedBorder: UnderlineInputBorder(
                borderSide : _style.getBirthdayTextFieldBorder(),
              ),
            ),
            style: _style.getEmailTextFieldLabelTextStyle(),
            onTap: () {
              _isEmailVisible= false;
              _emailValidation = '';
            },
            onChanged: (value) {
              setState((){
                if (emailController.text.length > 0)
                  _emailInputChecker = true;
                else
                  _emailInputChecker = false;
              });
            },
          )
        )
      ),
      Container(
          width: width,
          height: 20,
          child: Text(_emailValidation, style: _style.getValidationTextStyle())
      )
      ]
    );
  }



  final _formKey = GlobalKey<FormState>(); // 폼스테이트 관리
  TextEditingController yearController= TextEditingController();
  bool _isYearVisible = true;
  TextEditingController monthController= TextEditingController();
  bool _isMonthVisible = true;
  TextEditingController dayController= TextEditingController();
  bool _isDayVisible = true;
  String validation= '';

  Widget getBirthdayWidget(width, height){

    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          alignment: Alignment.centerLeft,
          width: width,
          height: 70,
          child: Text('생년월일을 알려주세요', style: _style.getMainText()),
        ),
        Container(
          width: width,
          height: 40,
          child: Form(
            key: _formKey,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: width * 0.16,
                  height: 40,
                  child: TextFormField(
                  controller: yearController,
                  decoration: InputDecoration(
                  hintText: _isYearVisible? '0000': '',
                  hintStyle: _style.getBirthdayTextFieldLabelTextStyle(),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.fromLTRB(0,0,0,5),
                  focusedBorder: UnderlineInputBorder(
                    borderSide : _style.getBirthdayTextFieldBorder(),
                    ),
                  ),
                  style: _style.getBirthdayTextFieldLabelTextStyle(),
                  onTap: () {
                    _isYearVisible= false;
                  },
                  onChanged: (value) {
                    if (yearController.text.length == 4) {
                      setState(() {
                        print(int.parse(yearController.text));
                        if (value == null || value.isEmpty) {
                          validation= '날짜를 입력해 주세요';
                        } else if (1900 > int.parse(yearController.text) ||
                            int.parse(yearController.text) > 2020) {
                          validation= '올바른 날짜를 입력해 주세요';
                        } else {
                          signUpBloC.setYear(yearController.text);
                          validation= '';
                        }
                      }
                      );
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    Utf8LengthLimitingTextInputFormatter(4)
                    ],
                  keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: width * 0.12,
                  height: 43,
                  child:Text('년', style: _style.getBirthdayTextFieldLabelTextStyle())
                ),
                Container(
                    alignment: Alignment.center,
                    width: width * 0.08,
                    height: 40,
                    child: TextFormField(
                      controller: monthController,
                      decoration: InputDecoration(
                        hintText: _isMonthVisible? '00': '',
                        hintStyle: _style.getBirthdayTextFieldLabelTextStyle(),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.fromLTRB(0,0,0,5),
                        focusedBorder: UnderlineInputBorder(
                          borderSide : _style.getBirthdayTextFieldBorder(),
                        ),
                      ),
                      style: _style.getBirthdayTextFieldLabelTextStyle(),
                      onTap: () {
                        _isMonthVisible= false;
                      },
                      onChanged: (value) {
                        if (monthController.text.length == 2) {
                          setState(() {
                          if (value == null || value.isEmpty) {
                            validation= '날짜를 입력해 주세요';
                          }else if(1 > int.parse(monthController.text) ||
                              int.parse(monthController.text) > 12) {
                            validation= '올바른 날짜를 입력해 주세요';
                          }else{
                            signUpBloC.setMonth(monthController.text);
                            validation= '';
                          }
                          }
                        );
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        Utf8LengthLimitingTextInputFormatter(2)
                      ],
                      keyboardType: TextInputType.number,
                    )
                ),
                Container(
                    alignment: Alignment.bottomLeft,
                    width: width * 0.12,
                    height: 43,
                    child:Text('월', style: _style.getBirthdayTextFieldLabelTextStyle())
                ),
                Container(
                    alignment: Alignment.center,
                    width: width * 0.08,
                    height: 40,
                    child: TextFormField(
                      controller: dayController,
                      decoration: InputDecoration(
                        hintText: _isDayVisible? '00': '',
                        hintStyle: _style.getBirthdayTextFieldLabelTextStyle(),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.fromLTRB(0,0,0,5),
                        focusedBorder: UnderlineInputBorder(
                          borderSide : _style.getBirthdayTextFieldBorder(),
                        ),
                      ),
                      style: _style.getBirthdayTextFieldLabelTextStyle(),
                      onTap: () {
                        _isDayVisible= false;
                      },
                      onChanged: (value) {
                        if (dayController.text.length == 2) {
                          setState(() {
                            if (value == null || value.isEmpty) {
                              validation= '날짜를 입력해 주세요';
                            }else if(1 > int.parse(dayController.text) ||
                                int.parse(dayController.text) > 31) {
                              validation= '올바른 날짜를 입력해 주세요';
                            }else{
                              signUpBloC.setDay(dayController.text);
                              validation= '';
                              _birthdayInputChecker = true;
                              //_animationEnd = false;
                            }
                          }
                          );
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        Utf8LengthLimitingTextInputFormatter(2)
                      ],
                      keyboardType: TextInputType.number,
                    )
                ),
                Container(
                    alignment: Alignment.bottomLeft,
                    width: width * 0.12,
                    height: 55,
                    child:Text('일', style: _style.getBirthdayTextFieldLabelTextStyle())
                )
              ]
            )
          )
        ), //validaton 글자를 출력하는 부분
        Container(
          width: width,
          height: 20,
          child: Text(validation, style: _style.getValidationTextStyle())
        )


      ]
    );
  }

    bool male = false;
    bool female = false;
    bool genderSelected = false;
    Widget getGenderWidget(width, height){
    ButtonStyle _maleButtonStyle = _style.getGenderButton(male);
    ButtonStyle _femaleButtonStyle = _style.getGenderButton(female);

      return Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            alignment: Alignment.centerLeft,
            width: width,
            height: 70,
            child: Text('성별을 알려주세요', style: _style.getMainText()),
          ),
          Container(
            width: width,
            height: 60,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: width,
                  height: genderSelected? 0 : 25,
                  color: _style.getWhiteGray(),
                ),
                Container(
                  width: width * 0.7,
                  height: 60,
                  color: _style.getBoxColor(),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:[
                        ElevatedButton(
                          style: _maleButtonStyle,
                          child: Text('남성', style: _style.getGenderButtonText()),
                          onPressed: (){
                            // 이곳에 비지니스 로직 도입 필요
                            setState((){
                              if (female)
                                female = false;
                              male = true;
                              genderSelected = true;
                            });
                            signUpBloC.setSex('male');
                            _genderInputChecker = true;
                          },
                        ),
                        ElevatedButton(
                            style: _femaleButtonStyle,
                            child: Text('여성', style: _style.getGenderButtonText()),
                            onPressed: (){
                              // 이곳에 비지니스 로직 도입 필요
                              setState((){
                                if (male)
                                  male = false;
                                female = true;
                                genderSelected = true;
                              });
                              signUpBloC.setSex('female');
                              _genderInputChecker = true;
                            }
                        )
                      ]
                  )
                )
              ]
            )
          )
        ]
      );
    }
  }


  class OTPnPasswordWidget extends StatefulWidget {
    const OTPnPasswordWidget({Key? key, required this.signUpBloC}) : super(key:key);

    final SignUpBloC signUpBloC;


    @override
    State<OTPnPasswordWidget> createState() => _OTPnPasswordWidgetState();
  }

  class _OTPnPasswordWidgetState extends State<OTPnPasswordWidget> {

    SignUpBloC _signUpBloC = SignUpBloC();

    @override
    void initState(){
      super.initState();
      _signUpBloC = widget.signUpBloC;
    }



    var _style = SignUpWidgetTheme();
    final maxWidth = 400.0;
    final maxHeight = 1200.0;
    Duration _duration = Duration(milliseconds: 400); //애니메이션 동작 시간
    bool _passwordInputChecker= false; //password가 입력되면  true;
    bool _passwordValidChecker= false; //password가 정상적이면 true;
    bool _otpInputChecker = false; // otp에 정상적인 otp가 들어오면 true
    String _buttonText = '다음'; // 버튼에 출력될 글자
    bool _animationEnd = false; // 비밀번호 애니메이션이 종료되면 true
    bool _animationEnd2 = false; // 컨펌 애니메이션이 종료되면 true
    bool _buttonColorSwitch = false; // 버튼의 색깔을 결정
    bool _confirmValidChecker = false; // 모든 입력이 완벽하면 true


    String _confirmValidation = '';
    String _passwordValidation = '';
    String _otpValidation = '';

    // password
    final _formKey1 = GlobalKey<FormState>();
    // confirm
    final _formKey2 = GlobalKey<FormState>();
    // otp
    final _formKey3 = GlobalKey<FormState>();

    TextEditingController confirmController = TextEditingController();
    TextEditingController otpController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

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
                child: OTPWidget(queryWidth, queryHeight),
              )
          )
      );
    }


    Widget OTPWidget(width, height){
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child:SingleChildScrollView(
                    child: Column(
                        children: [
                          AnimatedContainer(
                            duration: _duration,
                            curve: Curves.easeInOut,
                            width: width,
                            height: _passwordValidChecker? 150 : 0,
                            child: _animationEnd2? getConfirmWidget(width, height) : SizedBox(),
                            onEnd:() {
                              setState(() {
                                // 애니메이션이 끝나고나면 창을 생성하기위해
                                _animationEnd2 = true;
                              });
                            },
                          ),
                          AnimatedContainer(
                            duration: _duration,
                            curve: Curves.easeInOut,
                            width: width,
                            height: _otpInputChecker? 150 : 0,
                            child: _animationEnd? getPasswordWidget(width, height): SizedBox(),
                            onEnd:() {
                              setState(() {
                                // 애니메이션이 끝나고나면 창을 생성하기위해
                                _animationEnd = true;
                              });
                            },
                          ),
                          AnimatedContainer(
                            duration: _duration,
                            curve: Curves.easeInOut,
                            width: width,
                            height: 150,
                            child: getOTPWidget(width, height),
                          ),
                        ]
                    )
                )
            ),
            SizedBox(
                width: width,
                // otp가 입력되고 나면 버튼이 보이도록
                height: _otpInputChecker? 50 : 0,
                child: ElevatedButton(
                  style: _style.getGenderButton(_buttonColorSwitch),
                  child: Text(_buttonText, style: _style.getSimpleButtonText()),
                  onPressed: (){
                    // 다음 화면이 나오게 해야함
                    setState(() {
                      if(passwordController.text.length > 0){
                        //_buttonColorSwitch = true;
                        // 비밀번호 입력 단계에서 입력한 비밀번호가 정규식과 맞을 때
                        // _passwordValidChecker를 true로 바꾸어 다음 단계로 진입
                        _passwordValidChecker = _signUpBloC.validPassword(passwordController.text);
                        print(passwordController.text);
                        print(_passwordValidChecker);
                        if (_passwordValidChecker){
                          // 버튼 색을 다시 끄고
                          _buttonColorSwitch = false;
                          // 버튼에 출력할 글자를 완료로 바꾸어줌
                          _buttonText = '완료';
                          // 컨펌 입력단계에서 입력한 글자가 있다면 버튼색을 바꿔야함
                          if(confirmController.text.length > 0){
                            _buttonColorSwitch = true;
                            // 컨펌결과가 일치하면 로그인을 시도해야함
                            if(passwordController.text == confirmController.text){
                              _confirmValidChecker = true;
                              print('회원가입에 성공하였습니다.');
                              // 회원가입 시도
                              //_signUpBloC.fetchOTP();
                            }else{
                              _confirmValidation = '비밀번호가 일치하지 않습니다';
                            }
                          }
                        }
                        else{ //비밀번호 입력 단계에서 입력한 비밀번호가 정규식에서 어긋났을때
                          _buttonText = '다음';
                          _passwordValidation = '영어 대,소문자 및 숫자를 포함하여 8~16자로 설정해 주세요';
                        }
                      }
                    });
                  },
                )
            )
          ],
        );
      }

      Widget getConfirmWidget(width, height){
        return Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                alignment: Alignment.centerLeft,
                width: width,
                height: 70,
                child: Text('비밀번호를 다시 입력해 주세요', style: _style.getMainText()),
              ),
              Container(
                  width: width,
                  height: 40,
                  child: Form(
                      key: _formKey2,
                      child: TextFormField(
                        obscureText: true,
                        controller: confirmController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => confirmController.clear(),
                              icon: Icon(Icons.clear)),
                          hintStyle: _style.getEmailTextFieldLabelTextStyle(),
                          isCollapsed: true,
                          contentPadding: EdgeInsets.fromLTRB(0,10,0,0),
                          focusedBorder: UnderlineInputBorder(
                            borderSide : _style.getBirthdayTextFieldBorder(),
                          ),
                        ),
                        style: _style.getEmailTextFieldLabelTextStyle(),
                        onChanged: (value) {
                          setState((){
                            // 글자가 들어오면 버든 색을 바꿔야해서
                            _confirmValidation = '';
                            if(passwordController.text.length > 0)
                              if(confirmController.text.length > 0){
                                _buttonColorSwitch = true;
                              }else{
                                _buttonColorSwitch = false;
                              }
                            else{
                              confirmController.clear();
                              _buttonColorSwitch = false;
                              _confirmValidChecker = false;
                              _passwordValidChecker = false;
                            }
                          });
                        },
                      )
                  )
              ),
              Container(
                  width: width,
                  height: 20,
                  child: Text(_confirmValidation, style: _style.getValidationTextStyle())
              )
            ]
        );
      }

    Widget getPasswordWidget(width, height){
      return Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              alignment: Alignment.centerLeft,
              width: width,
              height: 70,
              child: Text('비밀번호를 설정해 주세요', style: _style.getMainText()),
            ),
            Container(
                width: width,
                height: 40,
                child: Form(
                    key: _formKey1,
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: (){passwordController.clear(); _passwordValidation = '';},
                            icon: Icon(Icons.clear)),
                        hintStyle: _style.getEmailTextFieldLabelTextStyle(),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.fromLTRB(0,10,0,0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide : _style.getBirthdayTextFieldBorder(),
                        ),
                      ),
                      style: _style.getEmailTextFieldLabelTextStyle(),
                      onChanged: (value) {
                        setState((){
                        if(passwordController.text.length > 0){
                          _passwordValidation = '';
                          _buttonColorSwitch = true;
                          if (_passwordValidChecker){
                            // 만약 비밀번호를 다시 적으면 컨펌창이 닫겨야함
                            if(_signUpBloC.checkState(passwordController.text)) {
                              passwordController.clear();
                              _passwordValidChecker = false;
                              _animationEnd2 = false;
                            }
                          }
                        }else
                        {
                          _passwordValidation = '';
                          _buttonColorSwitch = false;
                        }
                      });
                    },
                  )
                )
            ),
            // 비밀번호에 문제가 있다면 _passwordValidation에 글자를 출력해야함
            Container(
                width: width,
                height: 20,
                child: Text(_passwordValidation, style: _style.getValidationTextStyle())
            )
          ]
      );
    }

    Widget getOTPWidget(width, height){
      return Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              alignment: Alignment.centerLeft,
              width: width,
              height: 70,
              child: Text('인증번호를 입력해 주세요', style: _style.getMainText()),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              width: width,
              height :  40,
              child: Form(
                  key: _formKey3,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    width: width * 0.16,
                    height: 40,
                    child: TextFormField(
                      controller: otpController,
                      decoration: InputDecoration(
                        hintStyle: _style.getBirthdayTextFieldLabelTextStyle(),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.fromLTRB(0,0,0,5),
                        focusedBorder: UnderlineInputBorder(
                          borderSide : _style.getBirthdayTextFieldBorder(),
                        ),
                      ),
                      style: _style.getBirthdayTextFieldLabelTextStyle(),
                      onChanged: (value) {
                        if (otpController.text.length == 4) {
                          setState(() {
                            // otp를 확인해서 동일하면 비밀번호창이 열리도록 설정
                            if(!_signUpBloC.setOTP(otpController.text))
                            {
                              _otpValidation = '인증번호를 확인해 주세요';
                              _otpInputChecker = false;
                            } else{
                              _otpValidation = '';
                              _otpInputChecker = true;
                            }
                          }
                          );
                        }
                      },
                      inputFormatters: [
                        // 숫자 키배열
                        FilteringTextInputFormatter.digitsOnly,
                        // 4글자까지만 입력가능하도록 허용
                        Utf8LengthLimitingTextInputFormatter(4)
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                )
            ),
            // OTP 가 이상하면 _ootpValidation을 출력해야함
            Container(
                width: width,
                height: 20,
                child: Text(_otpValidation, style: _style.getValidationTextStyle())
            )
          ]
      );
    }
  }


class Utf8LengthLimitingTextInputFormatter extends TextInputFormatter {
  Utf8LengthLimitingTextInputFormatter(this.maxLength)
      : assert(maxLength == null || maxLength == -1 || maxLength > 0);

  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (maxLength != null &&
        maxLength > 0 &&
        bytesLength(newValue.text) > maxLength) {
      // If already at the maximum and tried to enter even more, keep the old value.
      if (bytesLength(oldValue.text) == maxLength) {
        return oldValue;
      }
      return truncate(newValue, maxLength);
    }
    return newValue;
  }
  static TextEditingValue truncate(TextEditingValue value, int maxLength) {
    var newValue = '';
    if (bytesLength(value.text) > maxLength) {
      var length = 0;

      value.text.characters.takeWhile((char) {
        var nbBytes = bytesLength(char);
        if (length + nbBytes <= maxLength) {
          newValue += char;
          length += nbBytes;
          return true;
        }
        return false;
      });
    }
    return TextEditingValue(
      text: newValue,
      selection: value.selection.copyWith(
        baseOffset: min(value.selection.start, newValue.length),
        extentOffset: min(value.selection.end, newValue.length),
      ),
      composing: TextRange.empty,
    );
  }

  static int bytesLength(String value) {
    return utf8.encode(value).length;
  }
}
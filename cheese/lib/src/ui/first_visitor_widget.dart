import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cheese/src/ui/login_try_widget.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';

class FirstVisitorWidget extends StatefulWidget {
  const FirstVisitorWidget({super.key});

  @override
  State<FirstVisitorWidget> createState() => _FirstVisitorWidgetState();
}

class _FirstVisitorWidgetState extends State<FirstVisitorWidget> {
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
            SignUpEmailWidget(),
          ],
        ),
      ),
    );
  }
}

class SignUpEmailWidget extends StatefulWidget {
  const SignUpEmailWidget({super.key});

  @override
  State<SignUpEmailWidget> createState() => _SignUpEmailWidgetState();
}

class _SignUpEmailWidgetState extends State<SignUpEmailWidget> {
  final LoginTheme _style = LoginTheme(); // 테마
  final double maxWidth = 400.0;
  final double maxHeight = 900.0;
  bool interaction = false;

  String firstVisit = '치즈가 처음이시군요! \n이메일 인증을 해주세요.';
  BodyWidget bodyWidget = BodyWidget();

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
        bodyWidget.titleArea(queryWidth, queryHeight, firstVisit),
        infoCheckEmail(queryWidth, queryHeight),
        timeArea(queryWidth, queryHeight),
        SizedBox(
          height: 20,
        ),
        ReTransmitEmailWidget(),
      ],
    );
  }

  Widget infoCheckEmail(width, height) {
    return Container(
      height: height * 0.15,
      alignment: Alignment.center,
      child: Text(
        '입력하신 주소로 본인인증 메일이 발송되었어요.\n     '
        '이메일 인증 후 이 페이지로 돌아와주세요.',
        style: _style.emailTransmitText,
      ),
    );
  }

  Widget timeArea(width, height) {
    return Center(
      child: Text('유효 시간 03:00',
      style: _style.remainTimeText,),
    );
  }

  // Widget emailReTransmit(width, height) {
  //   return Container(
  //     width: width * 0.8,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('메일이 오지 않았나요?',
  //           style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
  //         Text(
  //           '  ● 스팸 메일을 확인해보세요.',
  //           style: TextStyle(fontSize: 12),
  //         ),
  //         RichText(
  //           text: TextSpan(
  //             children: [
  //               TextSpan(
  //                 text: '  ● ',
  //                 style: TextStyle(fontSize: 12, color: Colors.black),
  //               ),
  //               WidgetSpan(
  //                 child: MouseRegion(
  //                   cursor: SystemMouseCursors.click,
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       showDialog(
  //                         context: context,
  //                         builder: (BuildContext context){
  //                           return AlertDialog(
  //                             content: Text('이메일 인증이 성공적으로 \n완료되었습니다.'),
  //                             actions: [
  //                               Center(
  //                                 child: InkWell(
  //                                   onTap: (){},
  //                                   child: Container(
  //                                     child: Text('확인'),
  //                                   ),
  //                                 ),
  //                               )
  //                             ],
  //                           );
  //                         }
  //                       );
  //                       print('클릭됨');
  //                     },
  //                     child: Text(
  //                       '이메일 재전송',
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         color: Colors.black,
  //                         decoration: TextDecoration.underline,
  //                         fontWeight: FontWeight.w700,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               TextSpan(
  //                 text: '을 눌러 다시 인증메일을 보내주세요.',
  //                 style: TextStyle(fontSize: 12, color: Colors.black),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class ReTransmitEmailWidget extends StatefulWidget {
  const ReTransmitEmailWidget({super.key});

  @override
  State<ReTransmitEmailWidget> createState() => _ReTransmitEmailWidgetState();
}

class _ReTransmitEmailWidgetState extends State<ReTransmitEmailWidget> {
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
      width: queryWidth * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('메일이 오지 않았나요?',
            style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
          Text(
            '  ● 스팸 메일을 확인해보세요.',
            style: TextStyle(fontSize: 12),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '  ● ',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                WidgetSpan(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                content: Text('이메일 인증이 성공적으로 \n완료되었습니다.'),
                                actions: [
                                  Center(
                                    child: InkWell(
                                      onTap: (){},
                                      child: Container(
                                        child: Text('확인'),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                        );
                        print('클릭됨');
                      },
                      child: Text(
                        '이메일 재전송',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: '을 눌러 다시 인증메일을 보내주세요.',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

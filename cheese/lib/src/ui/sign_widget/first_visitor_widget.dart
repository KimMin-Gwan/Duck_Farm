import 'package:flutter/material.dart';
import 'package:cheese/src/ui/sign_widget/login_try_widget.dart';
import 'package:cheese/src/ui/styles/login_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cheese/src/bloc/sign_bloc/sign_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';


class FirstVisitorWidget extends StatelessWidget {
  final bool state;
  FirstVisitorWidget({super.key, required this.state});

  final LoginTheme _style = LoginTheme(); // 테마
  bool interaction = false;

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;

    double queryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                TopBarWidget(),
                SignUpEmailWidget(),
              ],
            ),
            state ? Container(
              color: Colors.black87.withOpacity(0.3),
              width: queryWidth,
              height: queryHeight,
            ) : Container(),
            state ? Container(
                alignment: Alignment.center,
                width: queryWidth,
                height: queryHeight,
                child: Container(
                    alignment: Alignment.center,
                    width: 350,
                    height: 180,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("이메일 인증이 성공적으로.",
                            style: TextStyle(fontSize:22, fontWeight: FontWeight.w700)
                        ),
                        Text("완료되었습니다.",
                            style: TextStyle(fontSize:22, fontWeight: FontWeight.w700)
                        ),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<SignBloc>(context).add(SendEmailConfirmEvent());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "확인",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )
                )
            ) : Container(),
          ],
        )
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

  TextEditingController emailTextController = TextEditingController();

  String firstVisit = '치즈가 처음이시군요! \n이메일 인증을 해주세요.';

  @override
  Widget build(BuildContext context) {
    BodyWidget bodyWidget = BodyWidget(
      emailEditingController: emailTextController,
    );
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
        TitleArea(
            width: queryWidth,
            height: queryHeight,
            text: firstVisit),
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

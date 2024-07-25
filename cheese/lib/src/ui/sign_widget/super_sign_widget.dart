import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cheese/src/bloc/sign_bloc/sign_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_state.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';
import 'package:cheese/src/ui/sign_widget/login_try_widget.dart';
import 'package:cheese/src/ui/sign_widget/login_widget.dart';
import 'package:cheese/src/ui/sign_widget/first_visitor_widget.dart';
import 'package:cheese/src/ui/sign_widget/password_create_widget.dart';
import 'package:cheese/src/ui/sign_widget/member_info_widget.dart';
import 'package:cheese/src/ui/sign_widget/member_login_widget.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';

//import 'package:cheese/src/ui/sign_widget/';

class SuperSignWidget extends StatefulWidget {
  const SuperSignWidget({super.key});

  @override
  State<SuperSignWidget> createState() => _SuperSignWidgetState();
}

class _SuperSignWidgetState extends State<SuperSignWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignBloc, SignState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          BlocProvider.of<CoreBloc>(context).add(StartMainServiceEvent());
          //BlocProvider.of<CoreBloc>(context).add(NoneBiasHomeDataEvent.none_date());
          //Navigator.pop(context);  // 뒤로 가기
        }
      },
      child: BlocBuilder<SignBloc, SignState>(
        builder: (context, state) {
          if (state is InitSignState) {
            return const LoginWidget();
          } else if (state is EmailInputState) {
            return const LoginTryWidget();
          } else if (state is TrySendEmailState) {
            return FirstVisitorWidget(state: state.state);
          } else if (state is PasswordInputState) {
            return const PasswordCreateWidget();
          } else if (state is NameBirthdayInputState) {
            return const MemberInfoWidget();
          } else if (state is TryLoginState) {
            return MemberLoginWidget(tryLoginModel: state.tryLoginModel);
          } else {
            return Container(
              child: Text("상태 오류"),
            );
          }
        },
      ),
    );
  }
}



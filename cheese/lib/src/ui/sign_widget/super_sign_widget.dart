import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cheese/src/bloc/sign_bloc/sign_bloc.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_state.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_event.dart';
import 'package:cheese/src/ui/sign_widget/login_try_widget.dart';
import 'package:cheese/src/ui/sign_widget/login_widget.dart';

class SuperSignWidget extends StatefulWidget {
  const SuperSignWidget({super.key});

  @override
  State<SuperSignWidget> createState() => _SuperSignWidgetState();
}

class _SuperSignWidgetState extends State<SuperSignWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignBloc, SignState>(
        builder: (context, state){
      if (state is InitSignState) {
        return const LoginWidget();
      }else if(state is EmailInputState){
        return const LoginTryWidget();
      }
      else{
        return Container(
          child: Text("꺼저")
        );
      }
    });
  }
}






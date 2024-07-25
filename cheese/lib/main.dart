import 'package:cheese/src/bloc/image_upload/image_upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
//import 'package:cheese/src/ui/home_widget_sample.dart';
import 'package:cheese/src/resources/repository/user_repository.dart';
import 'package:cheese/src/resources/repository/core_repository.dart';
import 'package:cheese/src/resources/repository/utility_repository.dart';
import 'package:cheese/src/bloc/core_bloc/core_state.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/bloc/sign_bloc/sign_bloc.dart';
import 'package:cheese/src/bloc/utility_bloc/utility_state.dart';
import 'package:cheese/src/bloc/utility_bloc/utility_event.dart';
import 'package:cheese/src/bloc/utility_bloc/utility_bloc.dart';
import 'package:cheese/src/ui/home_widget/home_widget.dart';
import 'package:cheese/src/ui/sign_widget/super_sign_widget.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});
  final UserRepository userRepository = UserRepository();
  final CoreRepository coreRepository = CoreRepository();
  final UtilityRepository utilityRepository = UtilityRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CoreBloc>(
            create: (BuildContext context) => CoreBloc(userRepository, coreRepository),
          ),
          BlocProvider<ImageUploadBloc>(
            create: (BuildContext context) => ImageUploadBloc(),
          ),
          BlocProvider<SignBloc>(
            create: (BuildContext context) => SignBloc(userRepository),
          ),
          BlocProvider<UtilityBloc>(
            create: (BuildContext context) => UtilityBloc(userRepository, utilityRepository),
          ),
        ],
        child: const MaterialApp(
          title: 'Cheese_proto',
          home: StartCheese()
        ));
  }
}

class StartCheese extends StatelessWidget {
  const StartCheese({super.key});

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<CoreBloc, CoreState>(
        builder: (context, state) {
          if (state is InitCoreState) {
            return SuperSignWidget();
          }
          else if(state is StartMainServiceState) {
            BlocProvider.of<CoreBloc>(context).add(NoneBiasHomeDataEvent.none_date());
            return Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 300,
                  child: Text("치즈를 준비합니다!")
              )
            );
          }else if(state is NoneBiasState){
            return PopScope(
              canPop: false,
              onPopInvoked: (bool didPop){
                  print("qwer");
                  BlocProvider.of<CoreBloc>(context).add(LoadBackwardEvent());
              },
              child: Scaffold(
                  body: HomePage()
              )
            );
          }else{
            return Container(
              alignment: Alignment.center,
              width: 300,
              height: 300,
              child: Text("치즈에 문제가 있나봅니다!")
            );
          }
        },
    );
  }
}

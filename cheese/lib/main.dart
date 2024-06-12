import 'package:cheese/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
import 'package:cheese/src/ui/home_widget.dart';
import 'package:cheese/src/resources/user_repository.dart';
import 'package:cheese/src/resources/core_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final UserRepository userRepository = UserRepository();
  final CoreRepository coreRepository = CoreRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CoreBloc>(
            create: (BuildContext context) => CoreBloc(userRepository, coreRepository),
          ),
        ],
        child: MaterialApp(
          title: 'Cheese_proto',
          home: HomePage()
        ));
  }
}

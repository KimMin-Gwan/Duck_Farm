import 'package:cheese/src/bloc/image_upload/image_upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheese/src/bloc/core_bloc/core_bloc.dart';
//import 'package:cheese/src/ui/home_widget_sample.dart';
import 'package:cheese/src/resources/user_repository.dart';
import 'package:cheese/src/resources/core_repository.dart';
import 'package:cheese/src/bloc/core_bloc/core_event.dart';
import 'package:cheese/src/ui/home_widget/home_widget.dart';

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
          BlocProvider<ImageUploadBloc>(
            create: (BuildContext context) => ImageUploadBloc(),
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
    BlocProvider.of<CoreBloc>(context).add(NoneBiasHomeDataEvent.none_date());
    return HomePage();
  }
}


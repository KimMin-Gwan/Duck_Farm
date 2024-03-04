import 'package:flutter/material.dart';
import 'package:cheese/src/ui/sign/sign_widget.dart';
import 'package:flutter/services.dart';
import 'package:cheese/src/ui/home_widget.dart';
//import 'package:cheese/src/ui/sign_in_widget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheese_Demo',
      theme: ThemeData(
        primaryColor: Color(0xff181420),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: Sign_Widget(),
      home: HomeWidget(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_app/src/pattern_home.dart';
import 'package:get/get.dart';


import 'package:test_app/src1/ui/bloc_display_widget.dart';

void main() {
  runApp(MyApp());
}
/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is
        primarySwatch: Colors.blue,
      ),
      home: const PatternHome(),
    );
  }
}
 */



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ElevatedButton(
                child: Text("bloc 패턴"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return BlocDisplayWidget();
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
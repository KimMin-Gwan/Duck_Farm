import 'package:test_app/src/views/mvc_view.dart';
import 'package:test_app/src/normal_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PatternHome extends StatelessWidget {
  const PatternHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('패턴')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NormalView()));
                },
                child: const Text('NO PATTERN')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MVCView()));
                },
                child: const Text('MVC PATTERN')),
          ],
        ),
      ),
    );
  }
}
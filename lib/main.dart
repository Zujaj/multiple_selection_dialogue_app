import 'package:flutter/material.dart';
import 'package:multiple_selection_dialogue_app/pages/demo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: DemoPage(),
        ),
      ),
    );
  }
}

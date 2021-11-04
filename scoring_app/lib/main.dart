import 'package:flutter/material.dart';

import 'homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qualification Scoring',
      home: MyHomePage(
        title: 'Client Engineering Engagement Scoring',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

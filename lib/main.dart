import 'package:flutter/material.dart';

import 'RandomWords.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "StartUp Names",
      theme: ThemeData(
        primaryColor: Colors.red),
      home: RandomWords(),
      debugShowCheckedModeBanner: false,
    );
  }
}


import 'package:flutter/material.dart';
import 'package:recipe_project/screen/home.dart';
import 'package:recipe_project/widget/splashscreen.dart';

// Sandy Putra Pratama

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_project/pages/home.dart';
import 'dart:async';
import 'package:recipe_project/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    splashscreenStart();
  }
  
  splashscreenStart() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  Color primaryColor = Color(0xFF010324);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pattern.png'),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.school,
            //   size: 100.0,
            //   color: Colors.white
            // ),
            Image.asset(
              'assets/images/logo_putih.png',
              width: 200.0,
              height: 200.0,
            )
          ],
        ),
      ) 
    );
  }
}

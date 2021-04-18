import 'package:flutter/material.dart';
import 'package:recipe_project/components/mydrawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Testing')
      ),
      body: Center(
        child: Text('Testing'),
      ),
    );
  }
}

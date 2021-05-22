import 'package:flutter/material.dart';

class DetailRecipe extends StatefulWidget {
  @override
  _DetailRecipeState createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [                         
          Image.asset(
            'assets/images/logo.png',
            width: 60.0,
            height: 10.0,
            scale: 8,
          )
        ],
        title: Text("Detail Resep"),
      ),
    );
  }
}

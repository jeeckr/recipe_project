import 'package:flutter/material.dart';
import 'package:recipe_project/service/api_service.dart';
import 'package:recipe_project/model/responseDetailRecipe.dart';

class DetailRecipe extends StatefulWidget {
  final String keyRecipe;
  // constructor
  DetailRecipe({@required this.keyRecipe});

  @override
  _DetailRecipeState createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {

  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {

    final double headerTop = MediaQuery.of(context).size.height * 0.40;

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
      body: ListView(
        children: [
          FutureBuilder<Results>(
            future:  ApiService.getRecipeById(widget.keyRecipe),
            builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 
                 return CircularProgressIndicator();
               } else {
                 Results data = snapshot.data;

                 return ListView(
                   children: [
                    ListTile(
                      leading: Icon(Icons.account_box),
                      title: Text(data.title ?? "Test"),
                      subtitle: const Text('Nama'),
                    ),
                   ],
                 );
               }
            }
          )
        ],
      )
    );
  }
}

 

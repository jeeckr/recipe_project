import 'package:flutter/material.dart';
import 'package:recipe_project/model/responseRecipes.dart';

class DetailRecipe extends StatefulWidget {
  static const String id = "halamandetail";
  // final Result recipesss;

  // HalamanTambahEdit({this.recipe});

  @override
  _DetailRecipeState createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {
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
          Container(
            width: double.infinity,
            height: headerTop,
            child: Image.network(
              "https://picsum.photos/id/237/200/300", 
              fit: BoxFit.cover
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rendang Paha Ayam",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Rendang adalah masakan padang",
                  style: TextStyle(
                    fontSize: 15.0
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              "Bahan-Bahan : ",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          Container(
            color: Colors.amber[100],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("- 4 Paha Ayam"),
                  Text("- 2 Buah Kentang"),
                  Text("- 2 Telur Rebus")
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

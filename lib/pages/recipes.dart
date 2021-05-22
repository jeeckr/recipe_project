import 'package:flutter/material.dart';
import 'dart:math';
import 'package:recipe_project/components/mydrawer.dart';
import 'package:recipe_project/data/recipe.dart';
import 'package:recipe_project/components/myrecipe.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {

  double value = 0;
  Color primaryColor = Color(0xFF010324);
  Color backgroundColor = Color(0xFFB5B5B5); 

  List<RecipeData> recipes = [
    new RecipeData(
      "https://picsum.photos/seed/picsum/200/300",
      "Resep 1",
      "Makanan",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    ),
    new RecipeData(
      "https://picsum.photos/seed/picsum/200/300",
      "Resep 2",
      "Makanan",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    ),
    new RecipeData(
      "https://picsum.photos/seed/picsum/200/300",
      "Resep 3",
      "Makanan",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    ),
    new RecipeData(
      "https://picsum.photos/seed/picsum/200/300",
      "Resep 4",
      "Makanan",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: primaryColor,
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pattern.png'),
                  fit: BoxFit.cover,
                )
              ),
              child: null,
            ) 
          ),
          MyDrawer(),
          TweenAnimationBuilder(
              tween: Tween<double>(
                begin: 0,
                end: value,
              ),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              builder: (_, double val, __) {
                return (
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200 * val)
                    ..rotateY((pi / 12) * val),
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        leading: Icon(
                          Icons.list_outlined,
                        ),
                        actions: [                         
                          Image.asset(
                            'assets/images/logo.png',
                            width: 60.0,
                            height: 10.0,
                            scale: 8,
                          )
                        ],
                        title: Text("Resep"),
                      ),
                      body: Container(
                        constraints: BoxConstraints.expand(),
                        decoration: BoxDecoration(),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                    prefixIcon: Icon(Icons.search),
                                    contentPadding: EdgeInsets.all(8.0),
                                    hintText: "Search..",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide.none
                                    )
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("List Resep",
                                  style: TextStyle(
                                    fontSize: 20.0
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 600.0,
                                  child: ListView(
                                    children: [
                                      myRecipe(context, recipes[0]),
                                      myRecipe(context, recipes[1]),
                                      myRecipe(context, recipes[2]),
                                      myRecipe(context, recipes[3])
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        )
                      ),
                    ),
                  )
                );
              }
            ),
          GestureDetector(
              onHorizontalDragUpdate: (e) {
                if (e.delta.dx > 0) {
                  setState(() {
                    value = 1;
                  });
                } else {
                  setState(() {
                    value = 0;
                  });
                }
              },
            )  
        ],
      ),
    );
  }
}

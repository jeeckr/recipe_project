import 'package:flutter/material.dart';
import 'dart:math';

import 'package:recipe_project/core/model/recipe.dart';
import 'package:recipe_project/core/service/api_service.dart';
import 'package:recipe_project/screen/detail_recipe.dart';
import 'package:recipe_project/screen/home.dart';
import 'package:recipe_project/widget/mydrawer.dart';

class RecipesScreen extends StatefulWidget {
  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  BuildContext context;
  ApiService _apiService;

  double value = 0;
  Color primaryColor = Color(0xFF010324);
  Color backgroundColor = Color(0xFFB5B5B5); 

  @override
  void initState() {
    _apiService = ApiService();
    super.initState();
  }

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

              var size = MediaQuery.of(context).size;
              return (
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val)
                  ..rotateY((pi / 12) * val),
                  child: Scaffold(
                    body: Container(
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Container(
                              height: size.height * .45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),
                                color: Color(0xFFB39AFD),                          
                              ),
                            ),
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Material(
                                          type: MaterialType.transparency,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Home()
                                                )
                                              );
                                            },
                                            child: Icon(
                                              Icons.home,
                                              size: 31.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Resep",
                                          style: TextStyle(
                                            fontSize: 23.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                          ),
                                        ),
                                        Text("        ")
                                      ],
                                    ),
                                    SizedBox(height: 20.0,),
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
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image(
                                        width: 220,
                                        image: AssetImage('assets/images/food-3.png'),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    FutureBuilder(
                                      future: _apiService.getRecipes(),
                                      builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
                                        if (snapshot.hasData) {
                                          List<Recipe> recipes = snapshot.data;
                                          return SingleChildScrollView(
                                            child: _recipeListView(recipes),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }
                                        return Container(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
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

  ListView _recipeListView(List<Recipe> recipes) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
      Recipe recipe = recipes[index];
        return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          width: MediaQuery.of(context).size.width * 0.90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: Colors.grey[300]
              )
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailRecipe(recipe: recipe)
                )
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      recipe.thumb,
                      width: 100,
                      height: 100,
                      fit:BoxFit.cover
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      right: 10.0,
                      bottom: 10.0
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 80.0,
                          child: Text(
                            recipe.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(
                              "lihat detail..",
                              textAlign: TextAlign.right,
                            ),
                          )
                        )
                      ],
                    )
                  )
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

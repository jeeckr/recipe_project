import 'package:flutter/material.dart';
import 'dart:math';

import 'package:recipe_project/core/service/api_service.dart';
import 'package:recipe_project/core/model/recipe.dart';
import 'package:recipe_project/screen/detail_recipe.dart';
import 'package:recipe_project/widget/mydrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BuildContext context;
  ApiService apiService;

  // variable
  double value = 0; 
  Color primaryColor = Color(0xFF010324);
  Color backgroundColor = Color(0xFFB5B5B5);

  @override
  void initState() {
    apiService = ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            // background gradient
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

            // menu navigasi
            MyDrawer(),

            // main screen
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
                        title: Text("Home"),
                      ),
                      body: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(color: backgroundColor),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
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
                                SizedBox(height: 20.0,),
                                // menu kategori
                                Text("Kategori",
                                  style: TextStyle(
                                    fontSize: 20.0
                                  ),
                                ),
                                SizedBox(height: 12.0,),
                                Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      // myCategory(categories[0]),
                                      // myCategory(categories[1])
                                    ],
                                  ),
                                ),
                                SizedBox(height: 13.0,),
                                // menu resep
                                Text("List Resep",
                                  style: TextStyle(
                                    fontSize: 20.0
                                  ),
                                ),
                                SizedBox(height: 12.0,),
                                FutureBuilder(
                                  future: apiService.getRecipes(),
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
                      )
                    )
                  )
                );
              }
            ),

            // membuat gestur saat membuka drawer
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
                color: Colors.red
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
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  child: Image.network(
                      recipe.thumb,
                      width: 150,
                      height: 150,
                      fit:BoxFit.cover
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      recipe.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

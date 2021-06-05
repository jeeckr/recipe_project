import 'package:flutter/material.dart';
import 'package:recipe_project/core/model/category.dart';
import 'dart:math';

import 'package:recipe_project/core/service/api_service.dart';
import 'package:recipe_project/core/model/recipe.dart';
import 'package:recipe_project/screen/all_category.dart';
import 'package:recipe_project/screen/all_recipe.dart';
import 'package:recipe_project/screen/detail_category.dart';
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
              backgroundColor: Color(0xFF714CFE),
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
                                  // image: DecorationImage(
                                  //   alignment: Alignment.centerLeft,
                                  //   image: AssetImage("assets/images/undraw_pilates_gpdb.png")
                                  // )
                                ),
                              ),
                              SafeArea(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.home,
                                            size: 31.0,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Homepage",
                                            style: TextStyle(
                                              fontSize: 35.0,
                                              fontFamily: 'Actonia',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                            ),
                                          ),
                                          Icon(
                                            Icons.list,
                                            size: 31.0,
                                            color: Colors.white,
                                          ),
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
                                      SizedBox(height: 230.0,),
                                      // menu kategori
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Kategori",
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Amplify',
                                            ),
                                          ),
                                          Material(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => CategoryScreen()
                                                  )
                                                );
                                              },
                                              child: Text("lihat semua"),
                                            ),
                                          )
                                        ],
                                      ),
                                      // Container(
                                      //   child: FutureBuilder(
                                      //     future: apiService.getCategories(),
                                      //     builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                                      //       if (snapshot.hasData) {
                                      //         List<Category> categories = snapshot.data;
                                      //         return ListView.builder(
                                      //           itemCount: categories.length,
                                      //           itemBuilder: (context, index) {
                                      //             // Category category = snapshot.data[index];
                                      //             return ListTile(
                                      //                title: Text(categories[index].key),
                                      //             );
                                      //           }
                                      //         );
                                      //       } else if (snapshot.hasError) {
                                      //         return Text("${snapshot.error}");
                                      //       }
                                      //       return Container(
                                      //         child: Center(
                                      //           child: CircularProgressIndicator(),
                                      //         ),
                                      //       );
                                      //     },
                                      //   ),
                                      // ),
                                      // SizedBox(height: 12.0,),
                                      // Container(
                                      //   width: double.infinity,
                                      //   height: 100.0,
                                      //   child: ListView(
                                      //     scrollDirection: Axis.horizontal,
                                      //     children: [
                                      //       // myCategory(categories[0]),
                                      //       // myCategory(categories[1])
                                      //     ],
                                      //   ),
                                      // ),
                                      SizedBox(height: 13.0,),
                                      // menu resep
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Resep",
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Amplify',
                                            ),
                                          ),
                                          Material(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => RecipesScreen()
                                                  )
                                                );
                                              },
                                              child: Text("lihat semua"),
                                            ),
                                          )
                                        ],
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
                              ),
                            ],
                          ),
                        ),
                      ),
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

  ListView _categoryListView(List<Category> categories) {
    return ListView.builder(
      // shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      itemCount: categories.length,
      itemBuilder: (context, index) {
      Category category = categories[index];
      return Container(
        width: 50,
        height: 50,
        child: InkWell(
          child: Icon(Icons.home),
        ),
      );
        // return Container(
        //   margin: EdgeInsets.only(bottom: 10.0),
        //   width: MediaQuery.of(context).size.width * 0.10,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(13),
        //     // boxShadow: [
        //     //   BoxShadow(
        //     //     offset: Offset(0, 17),
        //     //     blurRadius: 23,
        //     //     spreadRadius: -13,
        //     //     color: Colors.grey
        //     //   )
        //     // ],
        //   ),
        //   child: InkWell(
        //     onTap: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => DetailCategory(category: category,)
        //         )
        //       );
        //     },
        //     child: Icon(Icons.home),
        //   ),
        // );
      }
    );
  }
}

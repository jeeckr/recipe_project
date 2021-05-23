import 'package:flutter/material.dart';
import 'dart:math';
import 'package:recipe_project/components/mydrawer.dart';
import 'package:recipe_project/model/responseRecipes.dart';
import 'package:recipe_project/service/api_service.dart';
import 'package:recipe_project/components/item_recipe.dart';
import 'package:recipe_project/screen/detailRecipe.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // membuat varibale
  double value = 0; 
  Color primaryColor = Color(0xFF010324);
  Color backgroundColor = Color(0xFFB5B5B5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            // membuat background gradient
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

            // membuat main screen
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
                      body: Container(
                        constraints: BoxConstraints.expand(),
                        decoration: BoxDecoration(color: backgroundColor),
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
                                Text("Kategori",
                                  style: TextStyle(
                                    fontSize: 20.0
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                // Container(
                                //   width: double.infinity,
                                //   height: 100.0,
                                //   child: ListView(
                                //     scrollDirection: Axis.horizontal,
                                //     children: [
                                //       myCategory(categories[0]),
                                //       myCategory(categories[1])
                                //     ],
                                //   ),
                                // ),
                                SizedBox(
                                  height: 13.0,
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
                                  child: FutureBuilder<List<Result>>(
                                    future: ApiService.getAllRecipe(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {

                                        return CircularProgressIndicator();

                                      } else {
                                        List<Result> listRecipe = snapshot.data;

                                        return ListView.builder(
                                          itemCount: listRecipe?.length ?? 0,
                                          itemBuilder: (BuildContext context, int index) {
                                            return InkWell(
                                              splashColor: Colors.indigo,
                                              borderRadius: BorderRadius.circular(8.0),
                                              child: itemRecipe(listRecipe[index]),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DetailRecipe(),
                                                  )
                                                );
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
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
}

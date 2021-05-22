import 'package:flutter/material.dart';
import 'package:recipe_project/components/myrecipe.dart';
import 'package:recipe_project/components/mycategory.dart';
import 'dart:math';
import 'package:recipe_project/components/splashscreen.dart';
import 'package:recipe_project/data/recipe.dart';
import 'package:recipe_project/data/category.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // membuat varibale
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

  List<CategoryData> categories = [
    new CategoryData(
      "assets/images/logo.png",
      "Makanan",
    ),
    new CategoryData(
      "assets/images/logo.png",
      "Minuman",
    ),
  ];

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

            // membuat menu navigasi
            SafeArea(
              child: Container(
                width: 200.0,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo_putih.png',
                            width: 100.0,
                            height: 100.0,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Home",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.list,
                              color: Colors.white,
                            ),
                            title: Text(
                              "List",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.category,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Kategori",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Keluar",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

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
                                    fillColor: backgroundColor,
                                    prefixIcon: Icon(Icons.search),
                                    contentPadding: EdgeInsets.all(8.0),
                                    hintText: "Search..",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
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
                                Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      myCategory(categories[0]),
                                      myCategory(categories[1])
                                    ],
                                  ),
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
                                      myRecipe(recipes[0]),
                                      myRecipe(recipes[1]),
                                      myRecipe(recipes[2]),
                                      myRecipe(recipes[3])
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
              // onTap: () {
              //   setState(() {
              //     value == 0 ? value = 1 : value = 0;
              //   });
              // },
            )  

          ],
        ),
      );
  }
}

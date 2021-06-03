import 'package:flutter/material.dart';
import 'dart:math';
import 'package:recipe_project/core/model/category.dart';
import 'package:recipe_project/core/service/api_service.dart';
import 'package:recipe_project/screen/detail_category.dart';
import 'package:recipe_project/screen/home.dart';
import 'package:recipe_project/widget/mydrawer.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
                                color: Color(0xFFF5CEB8),
                                image: DecorationImage(
                                  alignment: Alignment.centerLeft,
                                  image: AssetImage("assets/images/undraw_pilates_gpdb.png")
                                )
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
                                          "Kategori",
                                          style: TextStyle(
                                            fontSize: 23.0,
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
                                    SizedBox(height: 300.0,),
                                    FutureBuilder(
                                      future: _apiService.getCategories(),
                                      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                                        if (snapshot.hasData) {
                                          List<Category> categories = snapshot.data;
                                          return SingleChildScrollView(
                                            child: _categoryListView(categories),
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

   ListView _categoryListView(List<Category> categories) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
      Category category = categories[index];
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
                color: Colors.grey
              )
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailCategory(category: category,)
                )
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Icon(
                      Icons.emoji_food_beverage,
                      size: 30,
                    )
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      category.category,
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

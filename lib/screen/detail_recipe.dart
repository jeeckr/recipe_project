import 'package:flutter/material.dart';
import 'package:recipe_project/core/model/recipe.dart';
import 'package:recipe_project/core/service/api_service.dart';
import 'dart:async';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class DetailRecipe extends StatefulWidget {
  Recipe recipe;

  DetailRecipe({ this.recipe });

  @override
  _DetailRecipeState createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {

  ApiService _apiService = ApiService();
  BuildContext context;

  Future<Recipe> futureRecipe;

  String _title;
  String _thumb;
  String _times;
  String _dificulty;
  String _key;
  String _desc;


  @override
  void initState() {
    // Mengecek jika data jurnal yang dikirim dari home tidak kosong
    if (widget.recipe != null) {
      
      // memberikan nilai pada judul controller
      _title = widget.recipe.title;
      _thumb = widget.recipe.thumb;
      _dificulty = widget.recipe.dificulty;
      _key = widget.recipe.key;
      _desc = widget.recipe.desc;
    }

    _apiService = ApiService();
    futureRecipe = _apiService.getRecipeById(_key);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldState,
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * .40,
              decoration: BoxDecoration(
                color: Color(0xFFF5CEB8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.centerLeft,
                  image: NetworkImage(_thumb)
                )
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 280, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      width: MediaQuery.of(context).size.width * 0.90,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 17),
                            blurRadius: 23,
                            spreadRadius: -13,
                            // color: color
                          )
                        ]
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            margin: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              // color: color,
                              shape: BoxShape.circle
                            ),
                            child: Icon(
                              Icons.note,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _title,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0,),
                    Text("Bahan-Bahan"),
                    Center(
                      child: FutureBuilder<Recipe>(
                        future: futureRecipe,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data.ingredient);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      )
                    )
                    // Text(_desc),
                    // FutureBuilder(
                    //   future: _apiService.getRecipeById(_key),
                    //   builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
                    //     if (snapshot.hasData) {
                    //       List<Recipe> ingredients = snapshot.data;
                    //       return SingleChildScrollView(
                    //         child: ListView.builder(
                    //           shrinkWrap: true,
                    //           physics: NeverScrollableScrollPhysics(),
                    //           Map<String, dynamic> data = ingredients[index];
                    //           itemCount: ingredients.length,
                    //           itemBuilder: (context, index) {
                    //             Recipe ingredient = ingredients[index];
                    //             return (Text("haloo"));
                    //           }
                    //         ),
                    //       );
                    //     } else if (snapshot.hasError) {
                    //       return Text("${snapshot.error}");
                    //     }
                    //     return Container(
                    //       child: Center(
                    //         child: CircularProgressIndicator(),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


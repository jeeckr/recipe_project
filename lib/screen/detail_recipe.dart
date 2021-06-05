import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_project/core/model/recipe.dart';
import 'package:recipe_project/core/service/api_service.dart';
import 'dart:async';

import 'package:recipe_project/widget/logger.dart';

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
  final log = logger;

  String _title;
  String _thumb;
  String _times;
  String _dificulty;
  String _key;
  // String _desc;

  @override
  void initState() {
    // Mengecek jika data jurnal yang dikirim dari home tidak kosong
    if (widget.recipe != null) {
      
      // memberikan nilai pada judul controller
      _title = widget.recipe.title;
      _thumb = widget.recipe.thumb;
      _dificulty = widget.recipe.dificulty;
      _key = widget.recipe.key;
      // _desc = widget.recipe.desc;
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                // color: Color(0xFFF5CEB8),
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(30.0),
                //   bottomRight: Radius.circular(30.0),
                // ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.centerLeft,
                  image: NetworkImage(_thumb)
                )
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                child: Column(
                  children: [
                    // button cek log
                    RaisedButton(
                      onPressed: () => log.d(widget.recipe),
                      child: Text("log"),
                    ),
                    FutureBuilder<Recipe>(
                      future: _apiService.getRecipeById(_key),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Recipe recipe = snapshot.data;
                          return Container(
                            child: Text("test")
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        // By default, show a loading spinner
                        return CircularProgressIndicator();
                      },
                    )
                  ],
                ),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Material(
                //           type: MaterialType.transparency,
                //           child: InkWell(
                //             onTap: () {
                //               Navigator.pop(context);
                //             },
                //             child: Icon(
                //               Icons.home,
                //               size: 31.0,
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //         Text(
                //           "Resep",
                //           style: TextStyle(
                //             fontSize: 23.0,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white
                //           ),
                //         ),
                //         Icon(
                //           Icons.list,
                //           size: 31.0,
                //           color: Colors.white,
                //         ),
                //       ],
                //     ),
                //     SizedBox(height: 230,),
                //     Container(
                //       margin: EdgeInsets.only(bottom: 10.0),
                //       width: MediaQuery.of(context).size.width * 0.90,
                //       padding: EdgeInsets.all(16),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(13),
                //         boxShadow: [
                //           BoxShadow(
                //             offset: Offset(0, 17),
                //             blurRadius: 23,
                //             spreadRadius: -13,
                //             // color: color
                //           )
                //         ]
                //       ),
                //       child: Text(
                //         _title,
                //         textAlign: TextAlign.center,
                //         // maxLines: 3,
                //         // overflow: TextOverflow.ellipsis,
                //         style: TextStyle(
                //           fontSize: 25.0,
                //           fontWeight: FontWeight.bold,
                //           fontFamily: 'Actonia'
                //         )
                //       )
                //     ),
                //     SizedBox(height: 12.0,),
                //     Text(
                //       "Tingkat Kesulitan",
                //       style: TextStyle(
                //         fontSize: 30.0,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: 'Amplify',
                //       ),
                //     ),
                //     Container(
                //       child: Text(
                //         widget.recipe.dificulty ,
                //         style: TextStyle(
                //           fontSize: 15.0,
                //           // fontWeight: FontWeight.bold,
                //           // fontFamily: 'Amplify',
                //         ),
                //       ),
                //     ),
                //     SizedBox(height: 12.0,),
                //     Text(
                //       "Deskripsi",
                //       style: TextStyle(
                //         fontSize: 30.0,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: 'Amplify',
                //       ),
                //     ),
                //     Container(
                //       child: Text(
                //         widget.recipe.dificulty ,
                //         style: TextStyle(
                //           fontSize: 15.0,
                //           // fontWeight: FontWeight.bold,
                //           // fontFamily: 'Amplify',
                //         ),
                //       ),
                //     ),
                //     SizedBox(height: 12.0,),
                //     Text(
                //       "Bahan-Bahan",
                //       style: TextStyle(
                //         fontSize: 30.0,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: 'Amplify',
                //       ),
                //     ),
                //     Center(
                //       child: FutureBuilder<Recipe>(
                //         future: futureRecipe,
                //         builder: (context, snapshot) {
                //           if (snapshot.hasData) {
                //             return Text(snapshot.data.ingredient);
                //           } else if (snapshot.hasError) {
                //             return Text("${snapshot.error}");
                //           }

                //           // By default, show a loading spinner.
                //           return CircularProgressIndicator();
                //         },
                //       )
                //     ),
                //     // Text(_desc),
                //     // FutureBuilder(
                //     //   future: _apiService.getRecipeById(_key),
                //     //   builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
                //     //     if (snapshot.hasData) {
                //     //       List<Recipe> ingredients = snapshot.data;
                //     //       return SingleChildScrollView(
                //     //         child: ListView.builder(
                //     //           shrinkWrap: true,
                //     //           physics: NeverScrollableScrollPhysics(),
                //     //           Map<String, dynamic> data = ingredients[index];
                //     //           itemCount: ingredients.length,
                //     //           itemBuilder: (context, index) {
                //     //             Recipe ingredient = ingredients[index];
                //     //             return (Text("haloo"));
                //     //           }
                //     //         ),
                //     //       );
                //     //     } else if (snapshot.hasError) {
                //     //       return Text("${snapshot.error}");
                //     //     }
                //     //     return Container(
                //     //       child: Center(
                //     //         child: CircularProgressIndicator(),
                //     //       ),
                //     //     );
                //     //   },
                //     // ),
                //   ],
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


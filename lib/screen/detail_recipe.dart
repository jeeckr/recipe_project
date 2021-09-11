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
      // _desc = widget.re  cipe.desc;
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
                    // RaisedButton(
                    //   onPressed: () => log.d(widget.recipe),
                    //   child: Text("log"),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
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
                    SizedBox(height: 230,),
                    FutureBuilder<Recipe>(
                      future: _apiService.getRecipeById(_key),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Recipe recipe = snapshot.data;
                          return Column(
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
                                    )
                                  ]
                                ),
                                child: Text(
                                  recipe.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Actonia'
                                  )
                                )
                              ),
                              SizedBox(height: 12.0,),
                              Text(
                                "Tingkat Kesulitan",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Amplify',
                                ),
                              ),
                              SizedBox(height: 5.0,),
                              Container(
                                child: Text(
                                  recipe.dificulty ,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.0,),
                              Text(
                                "Deskripsi",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Amplify',
                                ),
                              ),
                              SizedBox(height: 5.0,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color(0xFFBBC8DE),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 17),
                                      blurRadius: 23,
                                      spreadRadius: -13,
                                      // color: color
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(
                                    recipe.desc ,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey[800]
                                    ),
                                  ),
                                )
                              ),
                              SizedBox(height: 10.0,),
                            ],
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
              ),
            )
          ],
        ),
      ),
    );
  }
}


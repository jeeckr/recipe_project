import 'package:flutter/material.dart';
import 'package:recipe_project/core/model/category.dart';
import 'package:recipe_project/core/model/recipe.dart';
import 'package:recipe_project/core/service/api_service.dart';
import 'package:recipe_project/screen/detail_recipe.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class DetailCategory extends StatefulWidget {
  Category category;

  DetailCategory({ this.category });

  @override
  _DetailCategoryState createState() => _DetailCategoryState();
}

class _DetailCategoryState extends State<DetailCategory> {
  ApiService _apiService = ApiService();
  BuildContext context;

  String _key;

  @override
  void initState() {
    // Mengecek jika data jurnal yang dikirim dari home tidak kosong
    if (widget.category != null) {
      _key = widget.category.key;
    }

    _apiService = ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
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
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                Icons.arrow_back,
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
                          Icon(
                            Icons.list,
                            size: 31.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      // Container(
                      //   alignment: Alignment.center,
                      //   child: Text(
                      //     "\"I cook, I create, I really enjoy what I do, I still have a lot to achieve\"",
                      //     style: TextStyle(
                      //       fontSize: 25,
                      //       fontWeight: FontWeight.w900,
                      //       color: Colors.white,
                      //       fontStyle: FontStyle.italic
                      //     ),
                      //     textAlign: TextAlign.right,
                      //   ),
                      // ),
                      Container(
                        alignment: Alignment.center,
                        child: Image(
                          width: 220,
                          image: AssetImage('assets/images/food-4.png'),
                        ),
                      ),
                      SizedBox(height: 200.0,),
                      FutureBuilder(
                        future: _apiService.getRecipeByCategory(_key),
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
                  )
                ),
              )
            ],
          )
        ),
      )
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

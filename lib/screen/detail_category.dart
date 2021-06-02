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
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              children: [
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

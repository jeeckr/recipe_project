import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_project/core/model/category.dart';
import 'package:recipe_project/core/model/recipe.dart';

class ApiService {
  static final String url = "https://masak-apa.tomorisakura.vercel.app";
  var client = http.Client();

  Future<List<Recipe>> getRecipes() async {
    final response = await client.get(
      Uri.parse("$url/api/recipes"),
      headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((item) => new Recipe.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  Future<Recipe> getRecipeById(String key) async {
    final response =
        await client.get(Uri.parse("$url/api/recipe/$key"));

    if (response.statusCode == 200) {
      // var ingredientJson = jsonDecode(response.body)['results'][0]['ingredient'];
      // List<String> ingredient = ingredientJson != null ? List.from(ingredientJson) : null;

      return Recipe.fromJson(jsonDecode(response.body)['results']);
      // List jsonResponse = json.decode(response.body)['results'];
      // return jsonResponse.map((job) => new Recipe.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  Future<List<Recipe>> getRecipeByCategory(String key) async {
    final response =
        await client.get(Uri.parse("$url/api/categorys/recipes/$key"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((item) => new Recipe.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load category');
    }
  }

  Future<List<Category>> getCategories() async {
    final response = await client.get(
      Uri.parse("$url/api/categorys/recipes"),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, HEAD"
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((item) => new Category.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load category');
    }
  }

}

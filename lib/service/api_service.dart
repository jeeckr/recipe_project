import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_project/model/responseRecipes.dart';
import 'package:recipe_project/model/responseDetailRecipe.dart';

class ApiService {
  static final String _url = 'https://masak-apa.tomorisakura.vercel.app';

  static Future<List<Result>> getAllRecipe() async {
    List<Result> listRecipe = [];
    final response = await http.get(Uri.parse('$_url/api/recipes'));

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseRecipe respRecipe = ResponseRecipe.fromJson(json);

      respRecipe.results.forEach((item) {
        listRecipe.add(item);
      });

      return listRecipe;
    } else {
      return [];
    }
  }

  static Future<Results> getRecipeById(String key) async {
    final response = await http.get(Uri.parse('$_url/api/recipe/$key'));

    if (response.statusCode == 200) {
      final data = Results.fromJson(json.decode(response.body));

      return data;
    } else {
      throw Exception('Failed to load a result');
    }
  }
}

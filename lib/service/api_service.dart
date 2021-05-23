import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_project/model/responseRecipes.dart';

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
}

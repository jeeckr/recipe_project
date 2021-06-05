import 'dart:convert';
import 'dart:collection';

class Recipe {
  String title;
  String thumb;
  String key;
  String times;
  String portion;
  String dificulty;
  String desc;
  // String ingredient;
  // List<Ingredient> ingredient;
  // List<String> ingredient;
  // String step;
  //  List<String> step;

  Recipe({
    this.title,
    this.thumb,
    this.key,
    this.times,
    this.portion,
    this.dificulty,
    this.desc,
    // this.ingredient,
    // this.step
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json["title"], 
      thumb: json["thumb"], 
      key: json["key"], 
      times: json["times"], 
      portion: json["portion"],
      dificulty: json["dificulty"],
      desc: json["desc"],
      // ingredient: json["ingredient"],
      // ingredient: List<Ingredient>.from(json["translations"].map((x) => Ingredient.fromJson(x))),
      // ingredient: List<String>.from(json["ingredient"].map((x) => x)),
      // step: json["step"]
      // step: List<String>.from(json["step"].map((x) => x)),
      
    );
  }

  Map<String, dynamic> toJson() {
    return 
    {
      "title": title, 
      "thumb": thumb, 
      "key": key, 
      "times": times, 
      "portion": portion, 
      "dificulty": dificulty, 
      "desc": desc, 
      // "ingredient": ingredient, 
      // "ingredient": List<dynamic>.from(ingredient.map((x) => x)),
      // "step": step
      // "step": List<dynamic>.from(ingredient.map((x) => x)),
    };
  }

  @override
  String toString() {
    return 'Recipe{title: $title, thumb: $thumb, key: $key, times: $times, portion: $portion, dificulty: $dificulty, desc: $desc,}';
  }
}

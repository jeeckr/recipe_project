import 'dart:convert';

class Recipe {
  String title;
  String thumb;
  String key;
  String times;
  String portion;
  String dificulty;
  String desc;
  String ingredient;
  String step;

  Recipe({
    this.title,
    this.thumb,
    this.key,
    this.times,
    this.portion,
    this.dificulty,
    this.desc,
    this.ingredient,
    this.step
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
      ingredient: json["ingredient"],
      step: json["step"]
    );
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "thumb": thumb, "key": key, "times": times, "portion": portion, "dificulty": dificulty, "desc": desc, "ingredient": ingredient, "step": step};
  }

  @override
  String toString() {
    return 'Recipe{title: $title, thumb: $thumb, key: $key, times: $times, portion: $portion, dificulty: $dificulty, desc: $desc, ingredient: $ingredient, step: $step}';
  }
}

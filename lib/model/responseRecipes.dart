// To parse this JSON data, do
//
//     final responseRecipe = responseRecipeFromJson(jsonString);

import 'dart:convert';

ResponseRecipe responseRecipeFromJson(String str) => ResponseRecipe.fromJson(json.decode(str));

String responseRecipeToJson(ResponseRecipe data) => json.encode(data.toJson());

class ResponseRecipe {
    ResponseRecipe({
        this.method,
        this.status,
        this.results,
    });

    String method;
    bool status;
    List<Result> results;

    factory ResponseRecipe.fromJson(Map<String, dynamic> json) => ResponseRecipe(
        method: json["method"],
        status: json["status"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "status": status,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.title,
        this.thumb,
        this.key,
        this.times,
        this.portion,
        this.dificulty,
    });

    String title;
    String thumb;
    String key;
    String times;
    Portion portion;
    Dificulty dificulty;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        thumb: json["thumb"],
        key: json["key"],
        times: json["times"],
        portion: portionValues.map[json["portion"]],
        dificulty: dificultyValues.map[json["dificulty"]],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "thumb": thumb,
        "key": key,
        "times": times,
        "portion": portionValues.reverse[portion],
        "dificulty": dificultyValues.reverse[dificulty],
    };
}

enum Dificulty { CUKUP_RUMIT, MUDAH }

final dificultyValues = EnumValues({
    "Cukup Rumit": Dificulty.CUKUP_RUMIT,
    "Mudah": Dificulty.MUDAH
});

enum Portion { THE_4_PORSI, THE_5_PORSI, THE_6_PORSI }

final portionValues = EnumValues({
    "4 Porsi": Portion.THE_4_PORSI,
    "5 Porsi": Portion.THE_5_PORSI,
    "6 Porsi": Portion.THE_6_PORSI
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}

import 'package:flutter/material.dart';
import 'package:recipe_project/data/recipe.dart';

Widget myRecipe(RecipeData recipe) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 121.66,
          height: 180.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(recipe.image),
              fit: BoxFit.cover,
            )
          ),
        )
      ],
    )
  );
}
 
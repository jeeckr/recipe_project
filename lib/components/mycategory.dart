import 'package:flutter/material.dart';
import 'package:recipe_project/data/category.dart';

Widget myCategory(CategoryData category) {
  return Container(
    width: 100.0,
    margin: EdgeInsets.only(right: 12.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            // image: DecorationImage(
              
            //   image: NetworkImage(category.icon),
            //   fit: BoxFit.cover,
            // )
            image: DecorationImage(
              alignment: Alignment.center,
              scale: 6.0,
              image: AssetImage(
                category.icon,
                )
            )
          ),
        )
      ],
    )
  );
}

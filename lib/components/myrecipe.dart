import 'package:flutter/material.dart';
import 'package:recipe_project/data/recipe.dart';

Widget myRecipe(RecipeData recipe) {
  return Container(
    width: double.infinity,
    height: 150.0,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      elevation: 10,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 8.0),
          width: 150.5,
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: NetworkImage(recipe.image),
              fit: BoxFit.cover,
            )
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  recipe.category,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  recipe.description,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.red,
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                      splashColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                      child: Text(
                        "Detail Resep",
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   // style: ButtonStyle(
                    //   //   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    //   //   backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    //   //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //   //     RoundedRectangleBorder(
                    //   //       borderRadius: BorderRadius.circular(8.0)
                    //   //     )
                    //   //   )
                    //   // ),
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.red,
                    //     padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        
                    //   ),
                    //   child: Text(
                    //     "Detail Resep",
                    //     style: TextStyle(
                    //       fontSize: 10.0,
                    //     ),
                    //     ),
                    // )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
    )
  );
}
 
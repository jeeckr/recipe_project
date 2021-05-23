import 'package:flutter/material.dart';
import 'package:recipe_project/data/recipe.dart';
import 'package:recipe_project/pages/detailRecipe.dart';

Widget myRecipe(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 150.0,
    margin: EdgeInsets.only(bottom: 8.0),
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
          width: 120.0,
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: null,
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
                  "test",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                // SizedBox(
                //   height: 8.0,
                // ),
                // Text(
                //   recipe.category,
                //   style: TextStyle(
                //     fontSize: 15.0,
                //   ),
                // ),
                SizedBox(
                  height: 8.0,
                ),
                Flexible(
                  child: Text(
                    "test", 
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailRecipe()
                          )
                        );
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
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
 
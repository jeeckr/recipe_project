import 'package:flutter/material.dart';
import 'package:recipe_project/screen/all_category.dart';
import 'package:recipe_project/screen/home.dart';
import 'package:recipe_project/screen/all_recipe.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
        width: 200.0,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_putih.png',
                    width: 100.0,
                    height: 100.0,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home()
                        )
                      );
                    },
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Actonia',
                        fontSize: 22.0,
                      ),
                    )
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipesScreen()
                        )
                      );
                    },
                    leading: Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Resep",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Actonia',
                        fontSize: 22.0,
                      ),
                    )
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen()
                        )
                      );
                    },
                    leading: Icon(
                      Icons.category,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Kategori",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Actonia',
                        fontSize: 22.0,
                      ),
                    )
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Keluar",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Actonia',
                        fontSize: 22.0,
                      ),
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

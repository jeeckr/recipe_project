import 'package:flutter/material.dart';
import 'package:recipe_project/main.dart';
import 'package:recipe_project/pages/recipes.dart';

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
                          builder: (context) => HomePage()
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
                      ),
                    )
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Recipes()
                        )
                      );
                    },
                    leading: Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    title: Text(
                      "List",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ),
                  ListTile(
                    onTap: () {
                      
                    },
                    leading: Icon(
                      Icons.category,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Kategori",
                      style: TextStyle(
                        color: Colors.white,
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

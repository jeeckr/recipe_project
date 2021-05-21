import 'package:flutter/material.dart';
import 'dart:math';
import 'package:recipe_project/components/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // membuat varibale
  double value = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            // membuat background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[400],
                    Colors.blue[400],
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: NetworkImage(
              //       'https://cdn.pixabay.com/photo/2015/03/26/09/41/phone-690091_960_720.jpg',
              //     ),
              //   )
              // ),
            ),

            // membuat menu navigasi
            SafeArea(
              child: Container(
                width: 200.0,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(
                              "https://www.gstatic.com/webp/gallery/4.sm.jpg"
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            "Sandy",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {},
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
                            onTap: () {},
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
                            onTap: () {},
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
            ),

            // membuat main screen
            TweenAnimationBuilder(
              tween: Tween<double>(
                begin: 0,
                end: value,
              ),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              builder: (_, double val, __) {
                return (
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200 * val)
                    ..rotateY((pi / 12) * val),
                    child: Scaffold(
                      appBar: AppBar(
                        leading: Icon(
                          Icons.list_outlined,
                        ),
                        actions: [                         
                          Image.asset(
                            'assets/images/logo.png',
                            width: 60.0,
                            height: 10.0,
                            scale: 8,
                          )
                        ],
                        title: Text("Home"),
                      ),
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Test"),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("Tombol"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                );
              }
            ),

            // membuat gestur saat membuka drawer
            GestureDetector(
              onHorizontalDragUpdate: (e) {
                if (e.delta.dx > 0) {
                  setState(() {
                    value = 1;
                  });
                } else {
                  setState(() {
                    value = 0;
                  });
                }
              },
              // onTap: () {
              //   setState(() {
              //     value == 0 ? value = 1 : value = 0;
              //   });
              // },
            )  

          ],
        ),
      );
  }
}

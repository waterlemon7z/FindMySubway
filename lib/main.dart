import 'package:flutter/material.dart';
import 'package:find_my_subway/home_screen_navi.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MySubway",
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeScr(),
    );
  }
}


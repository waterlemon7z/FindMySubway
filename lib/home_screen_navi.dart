import 'package:flutter/material.dart';
import 'package:find_my_subway/pages/page_favorite.dart';
import 'package:find_my_subway/pages/page_main.dart';
import 'package:find_my_subway/pages/page_option.dart';

class HomeScr extends StatefulWidget {
  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  @override
  int _curPage = 0;
  final List<Widget> _widgetPages = [
    MainPage(),
    FavoritePage(),
    OptionPage(),
  ];

  void _onTapPageChange(int index)
  {
    setState(() {
      _curPage = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetPages[_curPage],
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Star",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _curPage,
        selectedItemColor: Colors.orange,
        onTap: _onTapPageChange,
      ),
    );
  }
}
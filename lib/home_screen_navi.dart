import 'package:flutter/material.dart';
import 'package:find_my_subway/pages/page_favorite.dart';
import 'package:find_my_subway/pages/page_search.dart';
import 'package:find_my_subway/pages/page_option.dart';

class HomeScr extends StatefulWidget {
  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  @override
  int _curPage = 0;
  final List<Widget> _widgetPages = [
    FavoritePage(),
    MainPage(),
    OptionPage(),
  ];

  void _onTapPageChange(int index) {
    setState(() {
      _curPage = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetPages[_curPage],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xff353535), width: 0.3),
          ),
        ),
        child: BottomNavigationBar(
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          currentIndex: _curPage,
          selectedItemColor: Color(0xffDD8D54),
          unselectedItemColor: Color(0xff353535),
          backgroundColor: Color(0xff000000),
          onTap: _onTapPageChange,
          elevation: 1,
          items: <BottomNavigationBarItem>[
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
        ),
      ),
    );
  }
}

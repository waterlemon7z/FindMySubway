import 'package:find_my_subway/main.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/pages/page_favorite.dart';
import 'package:find_my_subway/pages/page_search.dart';
import 'package:find_my_subway/pages/page_option.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          onTap: _onTapPageChange,
          elevation: 1,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Star",
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
  @override
  void initState() {
    super.initState();
    loadTheme();

  }
  void loadTheme()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt("Theme", 1);
    if(prefs.getInt("Theme") == 0)
      {
        MyApp.themeNotifier.value = ThemeMode.light;
      }
    else
      {
        MyApp.themeNotifier.value = ThemeMode.dark;
      }
  }
}

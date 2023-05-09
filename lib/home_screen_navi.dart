import 'package:find_my_subway/main.dart';
import 'package:find_my_subway/pages/page_timer.dart';
import 'package:find_my_subway/pages/page_whereAmI.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/pages/page_favorite.dart';
import 'package:find_my_subway/pages/page_option.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class HomeScr extends StatefulWidget {
  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  @override
  int _curPage = 0;
  final List<Widget> _widgetPages = [
    FavoritePage(),
    WhereAmI(),
    SubwayTimer(),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,(kIsWeb ? 20 : 0)),
        child: Container(
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
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.live_help_rounded),
                label: "WhereAmI",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: "Timer",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
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
    /*Initializing for new user*/
    if(!prefs.containsKey("Theme"))
      prefs.setInt("Theme", 1);
    if(!prefs.containsKey("Location"))
      prefs.setInt("Location", 1);
    if(!prefs.containsKey("AutoTimer"))
      prefs.setInt("AutoTimer", 1);
    if(!prefs.containsKey("Times"))
      prefs.setStringList("Times", []);
    if(!prefs.containsKey("StartTime"))
      prefs.setInt("StartTime", -1);
    if(!prefs.containsKey("TimeState"))
      prefs.setBool("TimeState", false);
    if(!prefs.containsKey("CurrentTrain"))
      prefs.setInt("CurrentTrain", 6160);
    if(!prefs.containsKey("FriendCode"))
      prefs.setInt("FriendCode", -1);
    if(!prefs.containsKey("FriendFunc"))
      prefs.setBool("FriendFunc", false);
    if(!prefs.containsKey("FriendList"))
      prefs.setStringList("FriendList", []);

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

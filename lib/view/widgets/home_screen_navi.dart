import 'package:find_my_subway/view/page_favorite.dart';
import 'package:find_my_subway/view/page_option.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _curPage = 0;
  final List<Widget> _widgetPages = [
    FavoritePage(),
    // WhereAmI(),
    // SubwayTimer(),
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
        padding: const EdgeInsets.fromLTRB(0, 0, 0, (kIsWeb ? 20 : 0)),
        child: Container(
          decoration: const BoxDecoration(
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: "Favorites",
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.live_help_rounded),
              //   label: "WhereAmI",
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.timer),
              //   label: "Timer",
              // ),
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
}

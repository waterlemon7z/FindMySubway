import 'package:find_my_subway/data/database.dart';
import 'package:find_my_subway/main.dart';
import 'package:find_my_subway/widgets/widget_appbar.dart';
import 'package:find_my_subway/widgets/widget_showToast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum ThemeItem { lightTheme, darkTheme, systemDefault }

class OptionPage extends StatefulWidget {
  @override
  State<OptionPage> createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  @override
  ThemeItem? selectedMenu = ThemeItem.darkTheme;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars(titleName: "설정"),
      body: Column(
        children: [
          ListTile(
            title: Text("테마 변경 하기"),
            trailing: Text("라이트테마 <-> 다크테마"),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              if(MyApp.themeNotifier.value == ThemeMode.light)
                {
                  MyApp.themeNotifier.value = ThemeMode.dark;
                  await prefs.setInt("Theme", 1);
                }
              else
                {
                  MyApp.themeNotifier.value = ThemeMode.light;
                  await prefs.setInt("Theme", 0);

                }
            },
          ),
          ListTile(
            title: Text("데이터 초기화"),
            // trailing: Text("라이트테마 <-> 다크테마"),
            onTap: (){
              UsrDataProvider myDb = new UsrDataProvider();
              myDb.reset();
              showToast("초기화 되었습니다", true);
            },
          ),
        ],
      ),

    );
  }
}

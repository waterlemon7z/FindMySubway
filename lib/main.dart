import 'package:find_my_subway/firebase_options.dart';
import 'package:find_my_subway/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/home_screen_navi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  @override
  ThemeColors themeDatas = new ThemeColors();

  Widget build(BuildContext ctx) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "MySubway",
          theme: themeDatas.light,
          darkTheme: themeDatas.dark,
          themeMode: currentMode,
          home: HomeScr(),
        );
      },
    );
  }
}
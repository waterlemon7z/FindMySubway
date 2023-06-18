import 'package:find_my_subway/firebase_options.dart';
import 'package:find_my_subway/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/home_screen_navi.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/userData.dart';

void main() async {
  // init();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('Preferences');
  Hive.registerAdapter(UserDataAdapter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firstTime();

  runApp(MyApp());
}
void firstTime() async
{
  if(!await Hive.boxExists("Preferences"))
  {
    var box = Hive.box("Preferences");
    box.put("Theme",1);
    box.put("Location", 1);
    box.put("AutoTimer", 1);
    box.put("Times", []);
    box.put("StartTime", -1);
    box.put("TimeState", false);
    box.put("CurrentTrain", 6160);
    box.put("FriendCode", -1);
    box.put("FriendFunc", false);
    box.put("FriendList", []);
  }
}
class MyApp extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeColors themeDatas = new ThemeColors();
  @override
  void initState() {
    super.initState();
    if(Hive.box("Preferences").get("Theme") == 0)
    {
      MyApp.themeNotifier.value = ThemeMode.light;
    }
    else
    {
      MyApp.themeNotifier.value = ThemeMode.dark;
    }
  }
  Widget build(BuildContext ctx) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: MyApp.themeNotifier,
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
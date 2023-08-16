import 'package:find_my_subway/data/data_hive.dart';
import 'package:find_my_subway/data/get_data.dart';
import 'package:find_my_subway/theme.dart';
// import 'package:find_my_subway/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:find_my_subway/home_screen_navi.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/userData.dart';

void main() async {
  // init();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // reset();
  DataFromAPI.initStationData();
  await Hive.openBox('Preferences');
  // Hive.deleteBoxFromDisk("userData");
  Hive.registerAdapter(UserDataAdapter());
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  firstTime();
  runApp(MyApp());
}
void userDataBaseTest() async
{
  HiveProvider mainHive = new HiveProvider();
  List<UserData> dataFromDb = await mainHive.getUserDataFromHive();
  for (int i = 0; i < dataFromDb.length; i++) {
    print((i + 1).toString() + ": " +dataFromDb[i].stName+ "역 " + dataFromDb[i].line + "선" + "id : " + dataFromDb[i].id.toString());
  }
}
void reset() async
{
  if(await Hive.boxExists("Preferences"))
  {
    Hive.deleteBoxFromDisk("Preferences");
    var box = Hive.box("Preferences");
    box.put("Theme",0);
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
void firstTime() async
{
  if(!await Hive.boxExists("Preferences"))
  {
    var box = Hive.box("Preferences");
    box.put("Theme",0);
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
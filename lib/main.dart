import 'package:find_my_subway/data/api/get_data.dart';
import 'package:find_my_subway/data/di.dart';
import 'package:find_my_subway/data/theme.dart';
import 'package:find_my_subway/entity/UserSettingsEntity.dart';
import 'package:find_my_subway/entity/UserSubwayDataEntity.dart';
import 'package:find_my_subway/service/UserSettingsService.dart';
import 'package:find_my_subway/view/widgets/home_screen_navi.dart';
// import 'package:find_my_subway/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

void dbSet() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserSubwayDataEntityAdapter());
  Hive.registerAdapter(UserSettingsEntityAdapter());
  if (!await Hive.boxExists("userSettingData")) {
    var box = Hive.box<UserSettingsEntity>("userSettingData");
    UserSettingsEntity entity = UserSettingsEntity(0, true, "-1", 01, false, [], true);
    box.put("setting", entity);
  }
  // await Hive.openBox('Preferences');
  // Hive.deleteBoxFromDisk("userData");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dbSet();
  DataFromAPI.initStationData();
  setupLocator();
  runApp(const FindMySubwayApp());
}

class FindMySubwayApp extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  const FindMySubwayApp({super.key});
  @override
  State<FindMySubwayApp> createState() => _FindMySubwayAppState();
}

class _FindMySubwayAppState extends State<FindMySubwayApp> {
  ThemeColors themeData = ThemeColors();
  final _userSettingService = GetIt.I<UserSettingsService>();
  @override
  void initState() {
    super.initState();
    var settingData = _userSettingService.getSettingData();
    if (settingData.theme == 0) {
      FindMySubwayApp.themeNotifier.value = ThemeMode.light;
    } else {
      FindMySubwayApp.themeNotifier.value = ThemeMode.dark;
    }
  }

  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: FindMySubwayApp.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "FindMySubway",
          theme: themeData.light,
          darkTheme: themeData.dark,
          themeMode: currentMode,
          home: const HomeScreen(),
        );
      },
    );
  }
}

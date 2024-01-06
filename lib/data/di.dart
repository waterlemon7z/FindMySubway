import 'package:find_my_subway/entity/UserSubwayDataEntity.dart';
import 'package:find_my_subway/service/UserSettingsService.dart';
import 'package:find_my_subway/service/UserSubwayService.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../entity/UserSettingsEntity.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => UserSubwayService());
  locator.registerLazySingleton(() => UserSettingsService());
  // locator.registerLazySingleton(() => Hive.box<UserSubwayDataEntity>("userSubwayData"));
  // locator.registerLazySingleton(() => Hive.box<UserSettingsEntity>("userSettingData"));
}

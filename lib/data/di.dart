import 'package:find_my_subway/service/UserSettingsService.dart';
import 'package:find_my_subway/service/UserSubwayService.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => UserSubwayService());
  locator.registerLazySingleton(() => UserSettingsService());
}

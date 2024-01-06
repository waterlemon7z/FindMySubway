import 'package:find_my_subway/entity/UserSettingsEntity.dart';
import 'package:find_my_subway/entity/UserSubwayDataEntity.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

class UserSettingsRepository {
  // ignore: prefer_typing_uninitialized_variables
  var _box;

  UserSettingsRepository() {
    _box = Hive.box("userSettingEntity");
  }


  UserSettingsEntity findAll() {
      return _box.get("setting");
  }

  Future<void> update(UserSettingsEntity entity) async {
    // _box.delete("setting");
    _box.put("setting", entity);
  }

  Future<void> reset() async {
    UserSettingsEntity entity = UserSettingsEntity(0, true, "-1", 01, false, [], true);
    _box.put("setting", entity);
  }
  bool isContains()
  {
    return _box.containsKey("setting");
  }

}

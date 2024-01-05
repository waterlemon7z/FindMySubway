import 'package:find_my_subway/entity/UserSubwayDataEntity.dart';
import 'package:hive/hive.dart';

class UserSubwayRepository {
  // ignore: prefer_typing_uninitialized_variables
  var _box;

  UserSubwayRepository() {
    _openbox();
  }

  void _openbox() async {
    _box = await Hive.openBox<UserSubwayDataEntity>("userSubwayData");
  }

  Future<List<UserSubwayDataEntity>> findAll() async {
    // var box = await Hive.openBox<UserSubwayDataEntity>("userSubwayData");
    List<UserSubwayDataEntity> rst = [];
    for (var cur in _box.values) {
      rst.add(cur);
    }
    return rst;
  }

  Future<void> insertByData(UserSubwayDataEntity data) async {
    _box.put(data.id, data);
  }

  Future<void> deleteById(int id) async {
    _box.delete(id);
  }

  Future<void> reset() async {
    _box.deleteAll(_box.keys);
  }
}

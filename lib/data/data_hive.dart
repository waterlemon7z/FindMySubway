import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:find_my_subway/data/userData.dart';
import 'package:hive/hive.dart';

class HiveProvider {
  Future<List<UserData>> getUserDataFromHive() async {
    var box = await Hive.openBox<UserData>("userData");
    List<UserData> rst = [];
    for (var cur in box.values) {
      rst.add(cur);
    }
    return rst;
  }

  Future<List<Pair<String, String>>> getListFromHive() async {
    var box = await Hive.openBox<UserData>("userData");
    List<Pair<String, String>> rst = [];
    for (var cur in box.values) {
      rst.add(Pair(cur.stName, cur.line));
    }
    return rst;
  }

  Future<void> insert(UserData data) async {
    var box = await Hive.openBox<UserData>("userData");
    box.put(data.id, data);
  }

  Future<void> delete(int id) async {
    var box = await Hive.openBox<UserData>("userData");
    box.delete(id);
  }

  Future<void> reset() async {
    var box = await Hive.openBox<UserData>("userData");
    box.deleteAll(box.keys);
  }
}

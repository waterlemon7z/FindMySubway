import 'package:find_my_subway/data/userData.dart';
import 'package:firebase_auth/firebase_auth.dart';
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


  Future<List<String>> getListFromHive() async {
    var box = await Hive.openBox<UserData>("userData");
    List<String> rst = [];
    for (var cur in box.values) {
      rst.add(cur.stName);
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

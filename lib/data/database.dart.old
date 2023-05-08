import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserData {
  int id;
  String stName;

  UserData({required this.id, required this.stName});

  Map<String, dynamic> toMap() {
    return {
      'stName': stName,
      'id': id,
    };
  }
}
class UsrDataProvider {
  late Database _database;
  final String tableName = "Userdata";

  Future<Database?> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'userSubwayData.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
            CREATE TABLE $tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              stName TEXT NOT NULL)''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  Future<List<UserData>> getDB() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);
    if (maps.isEmpty) return [];
    List<UserData> list = List.generate(maps.length, (index) {
      return UserData(id: maps[index]["id"], stName: maps[index]["stName"]);
    });
    return list;
  }

  Future<List<String>> getListFromDB() async
  {
    List<String>rst = [];
    List<UserData> dataFromDb = await this.getDB();
    for(int i = 0; i < dataFromDb.length; i++) {
      rst.add(dataFromDb[i].stName);
    }
    return rst;
  }

  Future<void> insert(UserData data) async {
    final db = await database;
    Map<String, dynamic> row = {
      "stName" : data.stName,
      "id"  : data.id
    };
    data.id = (await db?.insert(tableName, row))!;
  }

  Future<void> update(UserData data) async {
    final db = await database;
    await db?.update(
      tableName,
      data.toMap(),
      where: "id = ?",
      whereArgs: [data.id],
    );
  }

  Future<void> delete(UserData data) async {
    final db = await database;
    await db?.delete(
      tableName,
      where: "id = ?",
      whereArgs: [data.id],
    );
  }
  Future<void> reset() async {
    List list = await getDB();
    for(int index = 0; index < list.length; index++)
      {
        await delete(list[index]);
      }
  }
}
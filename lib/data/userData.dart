import 'package:hive/hive.dart';
part 'userData.g.dart';

@HiveType(typeId : 0)
class UserData {
  @HiveField(0)
  int id;
  @HiveField(1)
  String stName;

  UserData({required this.id, required this.stName});
}
import 'package:hive/hive.dart';

part 'UserSubwayDataEntity.g.dart';

@HiveType(typeId: 0)
class UserSubwayDataEntity {
  @HiveField(0)
  int idx;
  @HiveField(1)
  int id;
  @HiveField(2)
  String stName;
  @HiveField(3)
  String line;

  UserSubwayDataEntity({required this.idx, required this.id, required this.stName, required this.line});
}

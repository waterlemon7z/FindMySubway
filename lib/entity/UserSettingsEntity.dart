import 'package:hive/hive.dart';

part 'UserSettingsEntity.g.dart';

@HiveType(typeId: 1)
class UserSettingsEntity {
  @HiveField(0)
  int theme;
  @HiveField(1)
  bool location;
  @HiveField(2)
  String currentTrain;
  @HiveField(3)
  int friendCode;
  @HiveField(4)
  bool friendFunc;
  @HiveField(5)
  List<int> friendList;
  @HiveField(6)
  bool autoTimer;

  UserSettingsEntity(this.theme, this.location, this.currentTrain, this.friendCode, this.friendFunc, this.friendList, this.autoTimer);
}

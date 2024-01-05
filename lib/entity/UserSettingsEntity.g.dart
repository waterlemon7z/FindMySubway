// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserSettingsEntity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingsEntityAdapter extends TypeAdapter<UserSettingsEntity> {
  @override
  final int typeId = 1;

  @override
  UserSettingsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSettingsEntity(
      fields[0] as int,
      fields[1] as bool,
      fields[2] as String,
      fields[3] as int,
      fields[4] as bool,
      (fields[5] as List).cast<int>(),
      fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserSettingsEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.theme)
      ..writeByte(1)
      ..write(obj.location)
      ..writeByte(2)
      ..write(obj.currentTrain)
      ..writeByte(3)
      ..write(obj.friendCode)
      ..writeByte(4)
      ..write(obj.friendFunc)
      ..writeByte(5)
      ..write(obj.friendList)
      ..writeByte(6)
      ..write(obj.autoTimer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

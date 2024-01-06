// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserSubwayDataEntity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSubwayDataEntityAdapter extends TypeAdapter<UserSubwayDataEntity> {
  @override
  final int typeId = 0;

  @override
  UserSubwayDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSubwayDataEntity(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserSubwayDataEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idx)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.stName)
      ..writeByte(3)
      ..write(obj.line);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSubwayDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveAccountAdapter extends TypeAdapter<HiveAccount> {
  @override
  final int typeId = 1;

  @override
  HiveAccount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAccount(
      coin: fields[0] as String,
      balance: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HiveAccount obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.coin)
      ..writeByte(1)
      ..write(obj.balance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveAccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

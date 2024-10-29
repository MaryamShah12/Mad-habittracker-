// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapterAdapter extends TypeAdapter<HabitAdapter> {
  @override
  final int typeId = 0;

  @override
  HabitAdapter read(BinaryReader reader) {
    return HabitAdapter();
  }

  @override
  void write(BinaryWriter writer, HabitAdapter obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

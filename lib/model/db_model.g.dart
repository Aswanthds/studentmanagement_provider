// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      gender: fields[4] as String?,
      age: fields[2] as String,
      grade: fields[3] as String,
      id: fields[5] as String,
      name: fields[1] as String,
      imgPath: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(6)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.grade)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.imgPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

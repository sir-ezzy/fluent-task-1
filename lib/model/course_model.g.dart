// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 0;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      instructor: fields[3] as String,
      instructorAvatar: fields[4] as String,
      category: fields[5] as String,
      level: fields[6] as String,
      duration: fields[7] as String,
      price: fields[8] as double,
      rating: fields[9] as double,
      students: fields[10] as int,
      image: fields[11] as String,
      tags: (fields[12] as List).cast<String>(),
      createdAt: fields[13] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.instructor)
      ..writeByte(4)
      ..write(obj.instructorAvatar)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.level)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.rating)
      ..writeByte(10)
      ..write(obj.students)
      ..writeByte(11)
      ..write(obj.image)
      ..writeByte(12)
      ..write(obj.tags)
      ..writeByte(13)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

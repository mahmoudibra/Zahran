// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalizedNameAdapter extends TypeAdapter<LocalizedName> {
  @override
  final int typeId = 1;

  @override
  LocalizedName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalizedName(
      ar: fields[0] as String?,
      en: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalizedName obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ar)
      ..writeByte(1)
      ..write(obj.en);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalizedNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 2;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      sabNumber: fields[2] as String,
      phone: fields[3] as String,
      media: fields[4] as String,
      lastVisit: fields[5] as DateTime,
      target: fields[6] as Target,
      id: fields[0] as int,
      name: fields[1] as LocalizedName,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sabNumber)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.media)
      ..writeByte(5)
      ..write(obj.lastVisit)
      ..writeByte(6)
      ..write(obj.target);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TargetAdapter extends TypeAdapter<Target> {
  @override
  final int typeId = 3;

  @override
  Target read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Target(
      totalSellOut: fields[0] as double,
      target: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Target obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.totalSellOut)
      ..writeByte(1)
      ..write(obj.target);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TargetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LoginModelAdapter extends TypeAdapter<LoginModel> {
  @override
  final int typeId = 4;

  @override
  LoginModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginModel(
      authToken: fields[0] as String,
      userProfile: fields[1] as UserModel,
    );
  }

  @override
  void write(BinaryWriter writer, LoginModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.authToken)
      ..writeByte(1)
      ..write(obj.userProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

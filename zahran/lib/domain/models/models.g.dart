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

class MediaAdapter extends TypeAdapter<Media> {
  @override
  final int typeId = 0;

  @override
  Media read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Media(
      id: fields[0] as int,
      mediaPath: fields[1] as String,
      type: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Media obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mediaPath)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 7;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as int,
      moduleNum: fields[1] as int,
      serialNum: fields[2] as int,
      name: fields[3] as LocalizedName,
      media: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.moduleNum)
      ..writeByte(2)
      ..write(obj.serialNum)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.media);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CommentModelAdapter extends TypeAdapter<CommentModel> {
  @override
  final int typeId = 5;

  @override
  CommentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentModel(
      comment: fields[0] as String,
      media: (fields[1] as List?)?.cast<Media>(),
    );
  }

  @override
  void write(BinaryWriter writer, CommentModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.comment)
      ..writeByte(1)
      ..write(obj.media);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReportItemAdapter extends TypeAdapter<ReportItem> {
  @override
  final int typeId = 20;

  @override
  ReportItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReportItem(
      product: fields[0] as Product,
      comment: fields[1] as CommentModel?,
      count: fields[3] as int?,
      price: fields[4] as double?,
      reasonOfReaturn: fields[2] as String?,
      createdAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ReportItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.comment)
      ..writeByte(2)
      ..write(obj.reasonOfReaturn)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReportTypesAdapter extends TypeAdapter<ReportTypes> {
  @override
  final int typeId = 70;

  @override
  ReportTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReportTypes.Comment;
      case 1:
        return ReportTypes.Problem;
      case 2:
        return ReportTypes.Competition_Sell_OUT;
      case 3:
        return ReportTypes.Competition_Stock_Count;
      case 4:
        return ReportTypes.Sell_OUT;
      case 5:
        return ReportTypes.Stock_Count;
      case 6:
        return ReportTypes.Return;
      case 7:
        return ReportTypes.Supply_Order;
      default:
        return ReportTypes.Comment;
    }
  }

  @override
  void write(BinaryWriter writer, ReportTypes obj) {
    switch (obj) {
      case ReportTypes.Comment:
        writer.writeByte(0);
        break;
      case ReportTypes.Problem:
        writer.writeByte(1);
        break;
      case ReportTypes.Competition_Sell_OUT:
        writer.writeByte(2);
        break;
      case ReportTypes.Competition_Stock_Count:
        writer.writeByte(3);
        break;
      case ReportTypes.Sell_OUT:
        writer.writeByte(4);
        break;
      case ReportTypes.Stock_Count:
        writer.writeByte(5);
        break;
      case ReportTypes.Return:
        writer.writeByte(6);
        break;
      case ReportTypes.Supply_Order:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SeverityAdapter extends TypeAdapter<Severity> {
  @override
  final int typeId = 71;

  @override
  Severity read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Severity.Low;
      case 1:
        return Severity.Medium;
      case 2:
        return Severity.High;
      default:
        return Severity.Low;
    }
  }

  @override
  void write(BinaryWriter writer, Severity obj) {
    switch (obj) {
      case Severity.Low:
        writer.writeByte(0);
        break;
      case Severity.Medium:
        writer.writeByte(1);
        break;
      case Severity.High:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeverityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReportModelAdapter extends TypeAdapter<ReportModel> {
  @override
  final int typeId = 41;

  @override
  ReportModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReportModel(
      type: fields[0] as ReportTypes,
      items: (fields[1] as List?)?.cast<ReportItem>(),
      comment: fields[2] as CommentModel?,
      problem: fields[3] as ProblemDetailsModel?,
      competitionName: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReportModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.items)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.problem)
      ..writeByte(4)
      ..write(obj.competitionName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProblemDetailsModelAdapter extends TypeAdapter<ProblemDetailsModel> {
  @override
  final int typeId = 42;

  @override
  ProblemDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProblemDetailsModel(
      problemTitle: fields[0] as String?,
      problemType: fields[1] as String?,
      severity: fields[2] as Severity?,
    );
  }

  @override
  void write(BinaryWriter writer, ProblemDetailsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.problemTitle)
      ..writeByte(1)
      ..write(obj.problemType)
      ..writeByte(2)
      ..write(obj.severity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProblemDetailsModelAdapter &&
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
      notificationEnabled: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.target)
      ..writeByte(7)
      ..write(obj.notificationEnabled);
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
      userProfile: fields[1] as UserModel?,
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

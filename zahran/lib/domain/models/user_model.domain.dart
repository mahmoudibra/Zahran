part of 'models.dart';

@HiveType(typeId: 2)
class UserModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final LocalizedName name;
  @HiveField(2)
  final String sabNumber;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String media;
  @HiveField(5)
  final DateTime lastVisit;
  @HiveField(6)
  final Target target;
  @HiveField(7)
  final String avatar;
  UserModel({
    this.sabNumber,
    this.avatar,
    this.phone,
    this.media,
    this.lastVisit,
    this.target,
    this.id,
    this.name,
  });
}

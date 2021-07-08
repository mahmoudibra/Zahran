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

@HiveType(typeId: 3)
class Target {
  @HiveField(0)
  double totalSellOut;
  @HiveField(1)
  double target;

  Target({this.totalSellOut, this.target});

  Target.fromJson(Map<String, dynamic> json) {
    totalSellOut =
        double.tryParse(json['total_sell_out']?.toString() ?? '0') ?? 0;
    target = double.tryParse(json['target']?.toString() ?? '0') ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_sell_out'] = this.totalSellOut;
    data['target'] = this.target;
    return data;
  }
}

@HiveType(typeId: 3)
class LoginModel {
  @HiveField(0)
  String authToken;
  @HiveField(1)
  UserModel userProfile;

  LoginModel({this.authToken, this.userProfile});
}

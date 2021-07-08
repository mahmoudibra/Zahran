part of 'models.dart';

class UserModel {
  final int id;
  final LocalizedName name;
  final String sabNumber;
  final String phone;
  final String media;
  final DateTime lastVisit;
  final Target target;
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

class Target {
  double totalSellOut;
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

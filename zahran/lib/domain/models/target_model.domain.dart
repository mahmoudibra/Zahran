import 'package:hive/hive.dart';

part 'models.g.dart';
part 'user_model.domain.dart';

@HiveType(typeId: 3)
class Target {
  @HiveField(0)
  double totalSellOut;
  @HiveField(1)
  double target;

  Target({this.totalSellOut, this.target});

  Target.fromJson(Map<String, dynamic> json) {
    totalSellOut = double.tryParse(json['total_sell_out']?.toString() ?? '0') ?? 0;
    target = double.tryParse(json['target']?.toString() ?? '0') ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_sell_out'] = this.totalSellOut;
    data['target'] = this.target;
    return data;
  }
}

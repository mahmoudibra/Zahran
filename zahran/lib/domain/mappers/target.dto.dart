part of 'domain_mapper.dart';

class TargetDto implements DtoToDomainMapper<Target> {
  double? totalSellOut;
  double? target;

  TargetDto.fromJson(Map<String, dynamic> json) {
    totalSellOut = json['total_sell_out']?.toString().toDouble();
    target = json['target']?.toString().toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_sell_out'] = this.totalSellOut;
    data['target'] = this.target;
    return data;
  }

  @override
  Target dtoToDomainModel() {
    return Target(totalSellOut: totalSellOut ?? 0, target: target ?? 0);
  }
}

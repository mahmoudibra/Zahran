part of 'domain_mapper.dart';

class ProductDto extends DtoToDomainMapper<Product> {
  int? id;
  int? moduleNum;
  int? serialNum;
  LocalizedNameDto? name;
  String? media;

  ProductDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleNum = int.tryParse(json['module_num']?.toString() ?? "");
    serialNum = int.tryParse(json['serial_num']?.toString() ?? "");
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    media = json['media'];
  }
  ProductDto.fromReportJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleNum = int.tryParse(json['module_num']?.toString() ?? "");
    serialNum = int.tryParse(json['serial_num']?.toString() ?? "");
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_num'] = this.moduleNum;
    data['serial_num'] = this.serialNum;
    data['name'] = this.name?.tojson();
    data['media'] = this.media;
    return data;
  }

  @override
  Product dtoToDomainModel() {
    return Product(
        id: id!,
        moduleNum: moduleNum ?? 0,
        serialNum: serialNum ?? 0,
        name: name?.dtoToDomainModel() ?? LocalizedName(),
        media: media ?? "");
  }
}

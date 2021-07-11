import 'package:zahran/domain/models/models.dart';
import 'package:zahran/domain/models/product.dart';

import 'domain_mapper.dart';

class ProductDto extends DtoToDomainMapper<Product> {
  int? id;
  int? moduleNum;
  int? serialNum;
  LocalizedNameDto? name;
  String? media;

  ProductDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleNum = json['module_num'];
    serialNum = json['serial_num'];
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    media = json['media'];
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
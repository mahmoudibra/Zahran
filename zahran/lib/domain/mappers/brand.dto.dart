part of 'domain_mapper.dart';

class BrandDto implements DtoToDomainMapper<BrandModel> {
  int? id;
  LocalizedNameDto? name;
  String? mediaPath;
  List<ProductDto>? products;

  BrandDto.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    mediaPath = json["media_path"];
    products = (json["products"] as List?)?.map((e) => ProductDto.fromJson(e)).toList() ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name?.tojson(),
      'media_path': mediaPath,
      "product": products?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  BrandModel dtoToDomainModel() {
    return BrandModel(
      id: id!,
      name: name?.dtoToDomainModel() ?? LocalizedName(),
      mediaPath: mediaPath ?? '',
      products: products?.map((e) => e.dtoToDomainModel()).toList() ?? [],
    );
  }
}

part of 'domain_mapper.dart';

class BrandDto implements DtoToDomainMapper<BrandModel> {
  int id;
  LocalizedNameDto name;
  String mediaPath;

  BrandDto.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    mediaPath = json["media_path"];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name?.tojson(),
      'media_path': mediaPath,
    };
  }

  @override
  BrandModel dtoToDomainModel() {
    return BrandModel(
        id: id, name: name?.dtoToDomainModel(), mediaPath: mediaPath);
  }
}

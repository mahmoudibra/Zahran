part of 'domain_mapper.dart';

class ChainDto implements DtoToDomainMapper<ChainModel> {
  int? id;
  LocalizedNameDto? title;
  String? media;

  ChainDto.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = LocalizedNameDto.fromJson(json["title"] ?? {});
    media = json["media"];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title?.tojson(),
      'media': media,
    };
  }

  @override
  ChainModel dtoToDomainModel() {
    return ChainModel(
      id: id!,
      title: title?.dtoToDomainModel() ?? LocalizedName(),
      media: media ?? '',
    );
  }
}

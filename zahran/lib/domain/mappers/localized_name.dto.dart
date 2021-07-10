part of 'domain_mapper.dart';

class LocalizedNameDto implements DtoToDomainMapper<LocalizedName> {
  String ar;
  String en;
  LocalizedNameDto.fromJson(Map<String, dynamic> json) {
    ar = json["ar"];
    en = json["en"];
  }

  Map<String, dynamic> tojson() {
    return {
      "ar": ar,
      "en": en,
    };
  }

  @override
  LocalizedName dtoToDomainModel() {
    return LocalizedName(ar: ar, en: en);
  }
}

part of 'domain_mapper.dart';

class OptionDto implements DtoToDomainMapper<Option> {
  int? id;
  String? value;

  OptionDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "value": value,
    };
  }

  @override
  Option dtoToDomainModel() {
    return Option(id: id!, value: value ?? "");
  }
}

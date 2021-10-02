part of 'domain_mapper.dart';

class SelectItemDto implements DtoToDomainMapper<SelectItem> {
  int? id;
  LocalizedNameDto? name;

  SelectItemDto.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = LocalizedNameDto.fromJson(json['name'] ?? {});
  }

  @override
  SelectItem dtoToDomainModel() {
    return SelectItem(
      id: id!,
      name: name!.dtoToDomainModel(),
    );
  }
}

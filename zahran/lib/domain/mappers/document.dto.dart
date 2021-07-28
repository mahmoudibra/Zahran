part of 'domain_mapper.dart';

class DocumentDto extends DtoToDomainMapper<Document> {
  int? id;
  LocalizedNameDto? name;
  String? type;
  String? documentUrl;

  DocumentDto({required this.id, required this.name, required this.type, required this.documentUrl});

  DocumentDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    type = json['type'];
    documentUrl = json['document_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name?.tojson();
    data['type'] = this.type;
    data['document_url'] = this.documentUrl;
    return data;
  }

  @override
  Document dtoToDomainModel() {
    return Document(
        id: id!, type: type ?? "", name: name?.dtoToDomainModel() ?? LocalizedName(), documentUrl: documentUrl ?? "");
  }
}

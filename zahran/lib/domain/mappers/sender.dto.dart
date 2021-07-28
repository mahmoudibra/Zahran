part of 'domain_mapper.dart';

class SenderDto implements DtoToDomainMapper<Sender> {
  String? name;
  String? avatar;

  SenderDto({this.name, this.avatar});

  SenderDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }

  @override
  Sender dtoToDomainModel() {
    return Sender(name: name ?? "", avatar: avatar ?? "");
  }
}

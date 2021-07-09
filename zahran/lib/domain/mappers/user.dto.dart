part of 'domain_mapper.dart';

class UserDto implements DtoToDomainMapper<UserModel> {
  int id;
  LocalizedNameDto name;
  String sabNumber;
  String phone;
  String media;
  DateTime lastVisit;
  TargetDto target;
  String avatar;
  UserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    sabNumber = json['sab_number'];
    avatar = json['avatar'] ?? '';
    media = json['media'] ?? '';
    lastVisit = DateTime.tryParse(json['last_visit'] ?? '');
    phone = json['phone'];
    target = json['target'] != null ? new TargetDto.fromJson(json['target']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name?.toJson(),
      "sab_number": sabNumber,
      "phone": phone,
      "media": media,
      "last_visit": lastVisit?.toIso8601String(),
      "target": target?.toJson(),
    };
  }

  @override
  UserModel dtoToDomainModel() {
    return UserModel(
      id: id,
      name: name.dtoToDomainModel(),
      sabNumber: sabNumber,
      phone: phone,
      media: media,
      lastVisit: lastVisit,
      target: target.dtoToDomainModel(),
    );
  }
}

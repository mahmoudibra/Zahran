part of 'domain_mapper.dart';

class UserDto implements DtoToDomainMapper<UserModel> {
  int id;
  LocalizedName name;
  String sabNumber;
  String phone;
  String media;
  DateTime lastVisit;
  Target target;
  String avatar;
  UserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LocalizedName.fromJson(json["name"] ?? {});
    sabNumber = json['sab_number'];
    avatar = json['avatar'] ?? '';
    media = json['media'] ?? '';
    lastVisit = DateTime.tryParse(json['last_visit'] ?? '');
    phone = json['phone'];
    target =
        json['target'] != null ? new Target.fromJson(json['target']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name?.tojson(),
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
      name: name,
      sabNumber: sabNumber,
      phone: phone,
      media: media,
      lastVisit: lastVisit,
      target: target,
    );
  }
}

class LoginDto implements DtoToDomainMapper<LoginModel> {
  String authToken;
  UserDto userProfile;

  LoginDto({this.authToken, this.userProfile});

  LoginDto.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    userProfile = json['user_profile'] != null
        ? new UserDto.fromJson(json['user_profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_token'] = this.authToken;
    if (this.userProfile != null) {
      data['user_profile'] = this.userProfile.toJson();
    }
    return data;
  }

  @override
  LoginModel dtoToDomainModel() {
    return LoginModel(
        userProfile: userProfile.dtoToDomainModel(), authToken: authToken);
  }
}

part of 'domain_mapper.dart';

class UserDto implements DtoToDomainMapper<UserModel> {
  int? id;
  LocalizedNameDto? name;
  String? sabNumber;
  String? phone;
  String? media;
  DateTime? lastVisit;
  TargetDto? target;
  UserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LocalizedNameDto.fromJson(json["name"] ?? {});
    sabNumber = json['sab_number'];
    media = json['media'] ?? '';
    lastVisit = DateTime.tryParse(json['last_visit'] ?? '');
    phone = json['phone'];
    target = TargetDto.fromJson(json['target'] ?? {});
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
        id: id!,
        name: name?.dtoToDomainModel() ?? LocalizedName(),
        sabNumber: sabNumber ?? '',
        phone: phone ?? '',
        media: media ?? '',
        lastVisit: lastVisit!,
        target:
            target?.dtoToDomainModel() ?? Target(totalSellOut: 0, target: 0),
        notificationEnabled: false);
  }
}

class LoginDto implements DtoToDomainMapper<LoginModel> {
  String? authToken;
  UserDto? userProfile;

  LoginDto({required this.authToken, required this.userProfile});

  LoginDto.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    userProfile = json['user_profile'] != null
        ? new UserDto.fromJson(json['user_profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "auth_token": authToken,
      "user_profile": userProfile?.toJson(),
    };
  }

  @override
  LoginModel dtoToDomainModel() {
    return LoginModel(
      userProfile: userProfile?.dtoToDomainModel(),
      authToken: authToken ?? '',
    );
  }
}

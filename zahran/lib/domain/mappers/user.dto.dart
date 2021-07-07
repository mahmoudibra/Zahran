part of 'domain_mapper.dart';

class UserDto implements DtoToDomainMapper<UserModel> {
  int id;
  String userName;
  int sabNumber;
  String avatar;
  String lastVisit;
  String phoneNumber;
  Target target;
  UserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    sabNumber = json['sab_number'];
    avatar = json['avatar'];
    lastVisit = json['last_visit'];
    phoneNumber = json['phone_number'];
    target =
        json['target'] != null ? new Target.fromJson(json['target']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['sab_number'] = this.sabNumber;
    data['avatar'] = this.avatar;
    data['last_visit'] = this.lastVisit;
    data['phone_number'] = this.phoneNumber;
    if (this.target != null) {
      data['target'] = this.target.toJson();
    }
    return data;
  }

  @override
  UserModel dtoToDomainModel() {
    return UserModel(id: id, name: userName);
  }
}

class LoginResponse {
  String authToken;
  UserDto userProfile;

  LoginResponse({this.authToken, this.userProfile});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
}

class Target {
  int totalSellOut;
  int target;

  Target({this.totalSellOut, this.target});

  Target.fromJson(Map<String, dynamic> json) {
    totalSellOut = json['total_sell_out'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_sell_out'] = this.totalSellOut;
    data['target'] = this.target;
    return data;
  }
}

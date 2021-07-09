part of 'domain_mapper.dart';

class LoginDto implements DtoToDomainMapper<LoginModel> {
  String authToken;
  UserDto userProfile;

  LoginDto({this.authToken, this.userProfile});

  LoginDto.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    userProfile = json['user_profile'] != null ? new UserDto.fromJson(json['user_profile']) : null;
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
    return LoginModel(userProfile: userProfile.dtoToDomainModel(), authToken: authToken);
  }
}

import 'package:hive/hive.dart';

import 'localization.domain.dart';

@HiveType(typeId: 3)
class LoginModel {
  @HiveField(0)
  String authToken;
  @HiveField(1)
  UserModel userProfile;

  LoginModel({this.authToken, this.userProfile});
}

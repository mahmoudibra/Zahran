import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:zahran/data/base/base_api_request.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/empty_model.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class UserRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<LoginModel?> login(String sub, String password) async {
    var result = await post(
      path: '/v1/mobile/login',
      data: {
        "sab_number": sub,
        "password": password,
        "fcm_device_token": await FCMConfig.instance.messaging.getToken(),
      },
      mapItem: (json) => LoginDto.fromJson(json).dtoToDomainModel(),
    );
    return result.data;
  }

  Future<UserModel?> fetchUserInfo() async {
    var result = await get(
      path: '/v1/mobile/me',
      mapItem: (json) => UserDto.fromJson(json).dtoToDomainModel(),
    );
    return result.data;
  }

  Future<UserModel?> updateProfile(
      String name, String phoneNumber, int? avatarId) async {
    print("Updated profile data is: $name, $phoneNumber, $avatarId");
    var result = await post(
      path: '/v1/mobile/update-profile',
      data: UpdateProfileRequest(
              name: name, phoneNumber: phoneNumber, avatarId: avatarId)
          .toJson(),
      mapItem: (json) => UserDto.fromJson(json).dtoToDomainModel(),
    );
    return result.data;
  }

  Future<EmptyModel?> changePassword(
      {required ChangePasswordRequest changePasswordRequest}) async {
    var result = await post(
      path: '/v1/mobile/update-password',
      data: changePasswordRequest.toJson(),
      mapItem: (json) => EmptyModel(),
    );
    return result.data;
  }

  Future<UserModel?> receiveNotification(
      {required bool receiveNotification}) async {
    var result = await post(
      path: '/v1/mobile/notification-setting',
      data: {
        "recive_notification": receiveNotification,
      },
      mapItem: (json) => UserDto.fromJson({
        'notification_enabled': receiveNotification,
        ...json,
      }).dtoToDomainModel(),
    );
    return result.data;
  }
}

class UpdateProfileRequest extends RequestMappable {
  LocalizedName name = LocalizedName();
  String phoneNumber = "";
  int? avatarId;

  UpdateProfileRequest(
      {required String name, required String phoneNumber, int? avatarId}) {
    this.name = LocalizedName(en: name, ar: name);
    this.phoneNumber = phoneNumber;
    this.avatarId = avatarId;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name.toJson();
    data['phone'] = this.phoneNumber;
    data['media_id'] = this.avatarId;
    return data;
  }
}

class ChangePasswordRequest extends RequestMappable {
  final String oldPassword;
  final String newPassword;
  final String newPasswordConfirm;

  ChangePasswordRequest(
      {required this.oldPassword,
      required this.newPassword,
      required this.newPasswordConfirm});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_password'] = this.oldPassword;
    data['new_password'] = this.newPassword;
    data['new_password_confirmation'] = this.newPasswordConfirm;
    return data;
  }
}

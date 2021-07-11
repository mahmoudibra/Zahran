import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/localization/tr.dart';

class SettingViewModel extends GetxController {
  final BuildContext context;
  UserModel? userModel;

  SettingViewModel(this.context);

  Future _fetchUserInfo() async {
    try {
      var localUserModel = Get.find<AuthViewModel>().user;
      userModel = localUserModel?.userProfile;
      update();
    } catch (error) {
      context.errorSnackBar(TR.of(context).un_expected_error);
    }
  }

  Future _updateNotificationStatus() async {
    try {
      await Repos.userRepo.receiveNotification(receiveNotification: true);
      var localUserModel = Get.find<AuthViewModel>().user;
      var updatedUserModel = UserModel.copyWith(origin: userModel!, notificationEnabled: true);
      var updatedLoginModel = LoginModel.copyWith(origin: localUserModel!, userProfile: updatedUserModel);
      await Get.find<AuthViewModel>().saveUser(updatedLoginModel);
      context.primarySnackBar(TR.of(context).user_setting_updated);
    } catch (error) {
      context.errorSnackBar(TR.of(context).un_expected_error);
    }
  }

  String? validateUserName(String? v) {
    return (v != null && v.length > 0).onFalse(TR.of(context).invalid_user_name);
  }

  String? validatePhoneNumber(String? v) {
    return (v != null && v.length == 11).onFalse(TR.of(context).invalid_phone_number);
  }

  Future<void> submitChanges() async {}

  @override
  void onReady() {
    FlareAnimation.show(action: _fetchUserInfo(), context: context);
    super.onReady();
  }
}

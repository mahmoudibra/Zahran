import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/localization/tr.dart';

class SettingViewModel extends GetxController {
  final BuildContext context;
  UserModel? _userModel;
  bool notificationEnabledValue = false;

  SettingViewModel(this.context);

  Future _fetchUserInfo() async {
    try {
      var localUserModel = Get.find<AuthViewModel>().user;
      _userModel = localUserModel?.userProfile;
      notificationEnabledValue = _userModel?.notificationEnabled ?? false;
      update();
    } catch (error) {
      context.errorSnackBar(TR.of(context).un_expected_error);
    }
  }

  Future _updateNotificationStatus() async {
    //TODO: ask why we consider 201 as error
    try {
      var userModel = await Repos.userRepo
          .receiveNotification(receiveNotification: notificationEnabledValue);

      var localAuthModel = Get.find<AuthViewModel>().user;
      var updatedLoginModel = LoginModel.copyWith(
        origin: localAuthModel!,
        userProfile: userModel,
      );
      await Get.find<AuthViewModel>().saveUser(updatedLoginModel);
      context.primarySnackBar(TR.of(context).user_setting_updated);
    } catch (error) {
      context.errorSnackBar(TR.of(context).un_expected_error);
    }
  }

  void updateNotificationStatus(bool notificationStatus) {
    notificationEnabledValue = notificationStatus;
    update();
  }

  Future<void> submitChanges() async {
    print("changes");
    await _updateNotificationStatus();
  }

  @override
  void onReady() {
    FlareAnimation.show(action: (_) => _fetchUserInfo(), context: context);
    super.onReady();
  }
}

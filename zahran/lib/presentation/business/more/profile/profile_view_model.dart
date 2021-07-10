import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.pm.dart';
import 'package:zahran/presentation/localization/tr.dart';

class UserProfileViewModel extends GetxController {
  final BuildContext context;
  String? lastFetch = DateTime.now().toIso8601String();
  String? userName;
  String? phoneNumber;
  UserModel? userModel;

  UserProfileViewModel(this.context);

  Future _fetchUserInfo() async {
    try {
      userModel = await Repos.userRepo.fetchUserInfo();
      var localUserModel = Get.find<AuthViewModel>().user;
      var updatedLoginModel = LoginModel.copyWith(origin: localUserModel!, userProfile: userModel);
      await Get.find<AuthViewModel>().saveUser(updatedLoginModel);
      lastFetch = DateTime.now().toIso8601String();
      update();
    } catch (error) {
      context.errorSnackBar(TR.of(context).un_expected_error);
    }
  }

  Future _updateUserProfile() async {
    try {
      userModel = await Repos.userRepo.updateProfile(userName!, phoneNumber!);
      var localUserModel = Get.find<AuthViewModel>().user;
      var updatedLoginModel = LoginModel.copyWith(origin: localUserModel!, userProfile: userModel);
      await Get.find<AuthViewModel>().saveUser(updatedLoginModel);
      context.primarySnackBar(TR.of(context).user_profile_updated);
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

  Future<void> submitChanges() async {
    await _updateUserProfile();
  }

  Future<void> selectImage() async {
    print("🚀🚀🚀🚀 Action to open image PopUp");
  }

  Future<void> changePassword() async {
    print("🚀🚀🚀🚀 Action to change password");
  }

  @override
  void onReady() {
    FlareAnimation.show(action: _fetchUserInfo(), context: context);
    super.onReady();
  }

  bool showMediaDialog = false;
  MediaPickerType mediaPickerType = MediaPickerType.CAMERA_WITH_GALLERY;

  void onMediaDismissed() {
    showMediaDialog = false;
  }
}

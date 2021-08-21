import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.pm.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class UserProfileViewModel extends GetxController {
  final BuildContext context;
  String? lastFetch = DateTime.now().toIso8601String();
  String? userName;
  String? phoneNumber;
  UserModel? userModel;

  MediaPickerType mediaPickerType = MediaPickerType.CAMERA_WITH_GALLERY;
  MediaLocal? mediaFile;
  int? uploadedMediaId;

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
      if (!(error is ApiFetchException)) {
        context.errorSnackBar(TR.of(context).un_expected_error);
      }
    }
  }

  Future _updateUserProfile() async {
    try {
      userModel = await Repos.userRepo.updateProfile(userName!, phoneNumber!, uploadedMediaId);
      var localUserModel = Get.find<AuthViewModel>().user;
      var updatedLoginModel = LoginModel.copyWith(origin: localUserModel!, userProfile: userModel);
      await Get.find<AuthViewModel>().saveUser(updatedLoginModel);
      context.primarySnackBar(TR.of(context).user_profile_updated);
    } catch (error) {
      if (!(error is ApiFetchException)) {
        context.errorSnackBar(TR.of(context).un_expected_error);
      }
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
    ScreenRouter.showPopup(
        type: PopupsNames.MEDIA_PICKER_POPUP,
        parameters: _prepareMediaParameter(),
        actionsCallbacks: _prepareMediaAction());
  }

  Map<String, Function> _prepareMediaAction() {
    print("🚀🚀🚀🚀 Heeeereeeeeeeeee");
    Map<String, Function> actionsCallbacks = Map();
    actionsCallbacks['mediaPickerCallback'] = (MediaLocal? mediaModel) =>
        {mediaFile = mediaModel, FlareAnimation.show(action: _uploadMedia(), context: context)};
    actionsCallbacks['dismissCallback'] = () => {print("🚀🚀🚀🚀 User Dismissed")};
    return actionsCallbacks;
  }

  Map<String, dynamic>? _prepareMediaParameter() {
    Map<String, dynamic>? parameters = Map();
    parameters["pickerType"] = mediaPickerType;
    return parameters;
  }

  Future<void> changePassword() async {
    ScreenNames.CHANGE_PASSWORD.push();
  }

  Future<void> _uploadMedia() async {
    try {
      var uploadedMedia = await Repos.mediaRepo.uploadMedia(uploadedFile: mediaFile!.mediaFile);
      uploadedMediaId = uploadedMedia!.id;
      userModel!.media = uploadedMedia.path;
      print("🚀🚀🚀 uploaded Media is: $uploadedMediaId ");
      update();
    } catch (error) {
      print("🚀🚀🚀 exception while uploading media: $error ");
    }
  }

  @override
  void onReady() {
    FlareAnimation.show(action: _fetchUserInfo(), context: context);
    super.onReady();
  }
}

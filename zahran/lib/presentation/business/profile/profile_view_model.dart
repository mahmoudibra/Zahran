import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/commom/media_picker/media_local.domain.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.pm.dart';
import 'package:zahran/presentation/localization/tr.dart';

enum UpdateProfileStates { INITIAL, LOADING }

class UserProfileViewModel extends GetxController {
  final BuildContext context;
  String? userName;
  String? phoneNumber;
  UserModel? userModel;

  UserProfileViewModel(this.context);

  Future _fetchUserInfo() async {
    userModel = await Repos.userRepo.fetchUserInfo();
    var localUserModel = Get.find<AuthViewModel>().user;
    var updatedLoginModel = LoginModel.copyWith(origin: localUserModel!, userProfile: userModel);
    Get.find<AuthViewModel>().saveUser(updatedLoginModel);
    update([
      [userModel]
    ]);
  }

  String? validateUserName(String? v) {
    return (v != null && v.length > 0).onFalse(TR.of(context).invalid_user_name);
  }

  String? validatePhoneNumber(String? v) {
    return (v != null && v.length == 11).onFalse(TR.of(context).invalid_phone_number);
  }

  Future<void> submitChanges() async {
    print("🚀🚀🚀🚀 changes submitted successfully");
  }

  Future<void> selectImage() async {
    print("🚀🚀🚀🚀 Action to open image PopUp");
  }

  Future<void> changePassword() async {
    print("🚀🚀🚀🚀 Action to change password");
  }

  @override
  void onInit() {
    _fetchUserInfo();
    super.onInit();
  }

  // Function retry;
  // NamedNavigator navigator;
  // UserManagementRepo userManagementRepo;
  // UserInfoManagerRepo userInfoManagerRepo;
  // MultiMediaRepo multiMediaRepo;
  bool showMediaDialog = false;
  MediaPickerType mediaPickerType = MediaPickerType.CAMERA_WITH_GALLERY;

  // File mediaFile;

  // UserData userData;

  int mediaId = 0;

  StreamController<UpdateProfileStates> _updateProfileStream = StreamController();

  // UpdateProfilePM({this.navigator, this.userManagementRepo, this.userInfoManagerRepo, this.multiMediaRepo});

  Stream<UpdateProfileStates> get updateProfileStatesStream => _updateProfileStream.stream;

  Future<void> initialize() async {
    try {
      // userData = await userManagementRepo.getUserProfile();
      _updateProfileStream.add(UpdateProfileStates.INITIAL);
    } catch (error) {
      // catchException(error);
    }
  }

  void changeProfileImage() {
    showMediaDialog = true;
    _updateProfileStream.add(UpdateProfileStates.INITIAL);
  }

  void mediaFilePicked(MediaLocal mediaModel) {
    showMediaDialog = false;
    // mediaFile = mediaModel.mediaFile;
    uploadProfileImage();
  }

  void onMediaDismissed() {
    showMediaDialog = false;
    _updateProfileStream.add(UpdateProfileStates.INITIAL);
  }

  Future<void> uploadProfileImage() async {
    // List<MultipartFile> multiMediaList = [];
    // var multipartFile = await MultipartFile.fromPath('selectedFile', mediaFile.path);
    // multiMediaList.add(multipartFile);

    // isLoading = true;
    // _updateProfileStream.add(UpdateProfileStates.INITIAL);
    // multiMediaRepo.uploadMedia(mediaType: "image", multiMedia: multiMediaList).then((imageUploadResponse) {
    //   isLoading = false;
    //   mediaId = imageUploadResponse.data.id;
    //   saveUserResponseImage(imageUploadResponse);
    //   _updateProfileStream.add(UpdateProfileStates.INITIAL);
    // }).catchError((errorPayLoad) => catchException(errorPayLoad));
  }

  void goToChangePassword() {
    // navigator.push(Routes.UPDATE_PASSWORD_ROUTER, replace: false, clean: false);
  }

  void updateProfile(String username, String phone) {
    // isLoading = true;
    // _updateProfileStream.add(UpdateProfileStates.INITIAL);
    // retry = () => updateProfile(username, phone);
    // userManagementRepo
    //     .updateProfile(UpdateProfileRequest(username, phone, mediaId))
    //     .then((value) => updateUserData(value.data))
    //     .catchError((errorPayLoad) => catchException(errorPayLoad));
  }

  // void updateUserData(UpdatedUserInfo updatedUserInfo) {
  //   // isLoading = false;
  //   // retry = () => updateUserData(updatedUserInfo);
  //   // userData = UserData.copyWith(
  //   //   origin: userData,
  //   //   username: updatedUserInfo.name,
  //   //   phone: updatedUserInfo.phone,
  //   //   mediaPath: updatedUserInfo.mediaPath,
  //   // );
  //   // userInfoManagerRepo.saveLocalCustomerInfo(userData);
  //   // _updateProfileStream.add(UpdateProfileStates.INITIAL);
  // }

  void dismiss() {
    // navigator.pop();
  }

  void dispose() {
    // super.dispose();
    _updateProfileStream.close();
  }

// void saveUserResponseImage(MultiMediaResponse uploadImageResponse) {
//   userData = UserData.copyWith(
//     origin: userData,
//     mediaPath: uploadImageResponse.data.originalMediaPath,
//   );
//   userInfoManagerRepo.saveLocalCustomerInfo(userData);
// }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/data/repo/user.repo.dart';
import 'package:zahran/presentation/localization/tr.dart';

class ChangePasswordViewModel extends GetxController {
  final BuildContext context;
  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;

  ChangePasswordViewModel(this.context);

  String? validateOldPassword(String? v) {
    return (v != null && v.length >= 6).onFalse(TR.of(context).invalid_password);
  }

  String? validateNewPassword(String? v) {
    newPassword = v;
    return (v != null && v.length >= 6).onFalse(TR.of(context).invalid_password);
  }

  String? validateConfirmNewPassword(String? v) {
    print("confirm: $v");
    print("new: $newPassword");
    return (v != null && v == newPassword).onFalse(TR.of(context).invalid_confirm_password);
  }

  Future<void> saveChanges() async {
    try {
      var changePasswordRequest = ChangePasswordRequest(
          oldPassword: oldPassword!, newPassword: newPassword!, newPasswordConfirm: confirmNewPassword!);
      await Repos.userRepo.changePassword(changePasswordRequest: changePasswordRequest);
      context.primarySnackBar(TR.of(context).user_password_changed_successfully);
    } catch (error) {
      context.errorSnackBar(TR.of(context).un_expected_error);
    }
  }
}

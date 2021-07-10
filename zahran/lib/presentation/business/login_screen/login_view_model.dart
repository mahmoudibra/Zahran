import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class LoginViewModel extends GetxController {
  final BuildContext context;
  String? sab;
  String? password;

  LoginViewModel(this.context);

  Future login() async {
    var res = await Repos.userRepo.login(sab!, password!);
    Get.find<AuthViewModel>().saveUser(res!);
    ScreenNames.home.pushAndRemoveAll();
  }

  String? validateSab(String? v) {
    return (v != null && v.isNum && v.length >= 6 && v.length <= 8).onFalse(TR.of(context).inavlid_sab);
  }

  String? validatePassword(String? v) {
    return (v != null && v.length >= 6).onFalse(TR.of(context).inavlid_password);
  }
}

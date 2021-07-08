import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/presentation/localization/ext.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class LoginViewModel extends GetxController {
  final BuildContext context;
  String sab;
  String password;

  LoginViewModel(this.context);

  Future login() async {
    await Repos.userRepo.login(sab, password).catchError((e) {});
    ScreenNames.home.pushAndRemoveAll();
  }

  String validateSab(String v) {
    return (v != null && v.isNum && v.length == 6)
        .onFalse(TR.of(context).inavlid_sab);
  }

  String validatePassword(String v) {
    return (v != null && v.length >= 6)
        .onFalse(TR.of(context).inavlid_password);
  }
}

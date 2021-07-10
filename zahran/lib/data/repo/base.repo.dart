import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/user.repo.dart';
import 'package:zahran/data/repo/visits.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/config/configs.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class Repos {
  static UserRepo get userRepo => UserRepo();
  static VisitsRepo get visitsRepo => VisitsRepo();
}

abstract class BaseRepositryImpl extends BaseRepositry {
  @override
  String get listTotalKey => "total_count";

  @override
  String get language => Localizations.localeOf(context).languageCode;

  @override
  Future<bool> onError(ApiFetchException error) async {
    if (error.statusCode == 401 && error.retryCount == 0) {
      var res = await ScreenNames.login_sheet.showAsBottomSheet(context);
      return res is LoginModel;
    } else if (!error.isCancel) {
      context.errorSnackBar(error.toString());
    }
    return false;
  }

  @override
  Uri get baseUrl {
    return Uri.parse(GeneralConfigs.BASE_URL);
  }

  @override
  Future<Map<String, String>> getHeaders(ROptions options) async {
    return await Get.find<AuthViewModel>().getHeaders();
  }

  @override
  Map<String, dynamic> resolveResponse(Response response) {
    var result = super.resolveResponse(response);
    result["status"] = result["code"];
    return result;
  }
}

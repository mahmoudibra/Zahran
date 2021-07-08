import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/user.repo.dart';
import 'package:zahran/data/repo/visits.repo.dart';
import 'package:zahran/presentation/config/configs.dart';

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
  void onError(ApiFetchException error) {
    if (!error.isCancel) context.errorSnackBar(error.toString());
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

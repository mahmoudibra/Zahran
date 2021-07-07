import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/user.repo.dart';
import 'package:zahran/presentation/config/configs.dart';

class Repos {
  static UserRepo get userRepo => UserRepo();
}

abstract class BaseRepositryImpl<T> extends BaseRepositry {
  @override
  String get listTotalKey => "total_count";

  @override
  String get language => Localizations.localeOf(context).languageCode;

  @override
  void onError(ApiFetchException error) {
    context.errorSnackBar(error.toString());
  }

  @override
  Uri get baseUrl {
    return Uri.parse(GeneralConfigs.BASE_URL);
  }

  @override
  Future<Map<String, String>> getHeaders(ROptions options) async {
    return {};
  }

  @override
  Map<String, dynamic> resolveResponse(Response<String> response) {
    var result = super.resolveResponse(response);
    print(result);
    result["status"] = result["code"];
    return result;
  }
}

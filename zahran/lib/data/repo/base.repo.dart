import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/notification.repo.dart';
import 'package:zahran/data/repo/promotion.repo.dart';
import 'package:zahran/data/repo/question.repo.dart';
import 'package:zahran/data/repo/reports.repo.dart';
import 'package:zahran/data/repo/salary.repo.dart';
import 'package:zahran/data/repo/task.repo.dart';
import 'package:zahran/data/repo/user.repo.dart';
import 'package:zahran/data/repo/visits.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/config/configs.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'brand.repo.dart';
import 'document.repo.dart';
import 'media.repo.dart';

class Repos {
  static UserRepo get userRepo => UserRepo();
  static VisitsRepo get visitsRepo => VisitsRepo();
  static PromotionRepo get promotionRepo => PromotionRepo();
  static BrandRepo get brandRepo => BrandRepo();
  static SallaryRepo get sallaryRepo => SallaryRepo();
  static DocumentRepo get documentRepo => DocumentRepo();
  static NotificationRepo get notificationRepo => NotificationRepo();
  static MediaRepo get mediaRepo => MediaRepo();
  static TaskRepo get taskRepo => TaskRepo();
  static QuestionRepo get questionRepo => QuestionRepo();
  static ReportsRepo get reports => ReportsRepo();
}

abstract class BaseRepositryImpl extends BaseRepositry {
  @override
  String get listTotalKey => "total_count";

  @override
  String get language => Localizations.localeOf(context).languageCode;

  @override
  Future<bool> onError(ApiFetchException error) async {
    if (error.statusCode == 401 && error.retryCount == 0) {
      var res = await ScreenNames.LOGIN_SHEET.showAsBottomSheet(context);
      return res is LoginModel;
    } else if (!error.isCancel) {
      if (error.message?.contains('SocketException: Failed host lookup:') ==
          true) {
        if (error.response == null) {
          context.errorSnackBar(
              ReusableLocalizations.of(context)!.noInternetMessage);
        } else {
          context.errorSnackBar(
              ReusableLocalizations.of(context)!.notFoundMessage);
        }
      } else
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
    var headers = await Get.find<AuthViewModel>().getHeaders();
    return {
      ...headers,
      "content-language": language,
    };
  }

  @override
  Map<String, dynamic> resolveResponse(Response response) {
    var result = super.resolveResponse(response);
    result["status"] = result["code"];
    return result;
  }
}

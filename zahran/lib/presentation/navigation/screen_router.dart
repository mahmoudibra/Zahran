import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/home_screen/home_screen.dart';
import 'package:zahran/presentation/business/login_screen/login_screen.dart';
import 'package:zahran/presentation/business/more/branch/branch_list_screen.dart';
import 'package:zahran/presentation/business/more/brands/brand_list_screen.dart';
import 'package:zahran/presentation/business/more/change_password/change_password_screen.dart';
import 'package:zahran/presentation/business/more/check_in/check_in_screen.dart';
import 'package:zahran/presentation/business/more/documents/details/document_details_screen.dart';
import 'package:zahran/presentation/business/more/documents/document_list_screen.dart';
import 'package:zahran/presentation/business/more/notification/details/notification_details_screen.dart';
import 'package:zahran/presentation/business/more/notification/notification_list_screen.dart';
import 'package:zahran/presentation/business/more/profile/profile_screen.dart';
import 'package:zahran/presentation/business/more/promotions/details/promotion_details_screen.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_list_screen.dart';
import 'package:zahran/presentation/business/more/salary/details/salary_details_screen.dart';
import 'package:zahran/presentation/business/more/salary/salaries_screen.dart';
import 'package:zahran/presentation/business/more/setting/seeting_screen.dart';
import 'package:zahran/presentation/business/profile_tab/logout.popup.dart';
import 'package:zahran/presentation/business/splash/splash_screen.dart';
import 'package:zahran/presentation/business/visits/details/visit_details.dart';
import 'package:zahran/presentation/commom/image_preview/image_preview_screen.dart';
import 'package:zahran/presentation/commom/media_picker/media_local.domain.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.pm.dart';
import 'package:zahran/presentation/commom/video_preview/video_preview_view_model.dart';

part 'screen_extensions.dart';

enum ScreenNames {
  LOGIN,
  LOGIN_SHEET,
  SPLASH,
  HOME,
  VISIT_DETAILS,
  USER_PROFILE,
  CHANGE_PASSWORD,
  SETTING,
  PROMOTION_LIST,
  PROMOTION_DETAILS,
  BRANCH_LIST,
  BRANDS_LIST,
  Sallery_LIST,
  Sallery_Details,
  DOCUMENT_LIST,
  DOCUMENT_DETAILS,
  CHECK_IN_LIST,
  NOTIFICATION_LIST,
  NOTIFICATION_DETAILS,
  IMAGE_PREVIEW,
  VIDEO_PREVIEW
}

enum PopupsNames { LOGOUT, MEDIA_PICKER_POPUP }

class ScreenRouter {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  //! Routes
  static Map<String, WidgetBuilder> get routes => {
        '/': (_) => SplashScreen(),
        "${ScreenNames.SPLASH}": (_) => SplashScreen(),
        "${ScreenNames.LOGIN}": (_) => LoginScreen(),
        "${ScreenNames.LOGIN_SHEET}": (_) => LoginSheet(),
        "${ScreenNames.HOME}": (_) => HomeScreen(),
        "${ScreenNames.USER_PROFILE}": (_) => UserProfileScreen(),
        "${ScreenNames.CHANGE_PASSWORD}": (_) => ChangePasswordScreen(),
        "${ScreenNames.VISIT_DETAILS}": (_) => VisitDetails(),
        "${ScreenNames.SETTING}": (_) => SettingScreen(),
        "${ScreenNames.PROMOTION_LIST}": (_) => PromotionListScreen(),
        "${ScreenNames.PROMOTION_DETAILS}": (_) => PromotionDetailsScreen(),
        "${ScreenNames.BRANCH_LIST}": (_) => BranchesListScreen(),
        "${ScreenNames.BRANDS_LIST}": (_) => BrandsListScreen(),
        "${ScreenNames.Sallery_LIST}": (_) => SalariesScreen(),
        "${ScreenNames.Sallery_Details}": (_) => SalaryDetailsScreen(),
        "${ScreenNames.DOCUMENT_LIST}": (_) => DocumentListScreen(),
        "${ScreenNames.DOCUMENT_DETAILS}": (_) => DocumentDetailsScreen(),
        "${ScreenNames.CHECK_IN_LIST}": (_) => CheckINScreen(),
        "${ScreenNames.NOTIFICATION_LIST}": (_) => NotificationListScreen(),
        "${ScreenNames.NOTIFICATION_DETAILS}": (_) => NotificationDetailsScreen(),
        "${ScreenNames.IMAGE_PREVIEW}": (_) => ImagePreviewScreen(),
        "${ScreenNames.VIDEO_PREVIEW}": (_) => VideoPreviewScreen(),
      };

  static void pop<T extends Object>([T? result]) {
    if (key.currentState!.canPop()) key.currentState!.pop(result);
  }

  static bool canPop() {
    return key.currentState!.canPop();
  }

  static Future showPopup(
      {required PopupsNames type,
      Map<String, dynamic>? parameters,
      Map<String, Function>? actionsCallbacks,
      bool barrierDismissible = true}) {
    Widget _popup;
    switch (type) {
      case PopupsNames.LOGOUT:
        _popup = LogoutPopUp(parameters: parameters, actionsCallbacks: actionsCallbacks);
        break;
      case PopupsNames.MEDIA_PICKER_POPUP:
        _popup = MediaPickerComponent(
          mediaPickerFileCallback: ({MediaLocal? mediaModel}) async {
            actionsCallbacks!['mediaPickerCallback']!(mediaModel);
          },
          mediaPickerType: parameters!["pickerType"] as MediaPickerType,
          onMediaDismissedCallback: () {
            actionsCallbacks!['dismissCallback']!();
          },
        );
        break;
    }

    return showDialog(
      context: key.currentState!.context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return _popup;
      },
    );
  }
}

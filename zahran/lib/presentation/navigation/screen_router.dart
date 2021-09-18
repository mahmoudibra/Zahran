import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
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
import 'package:zahran/presentation/business/tasks/details/task_details_screen.dart';
import 'package:zahran/presentation/business/visits/details/reports/comment/screen.dart';
import 'package:zahran/presentation/business/visits/details/reports/competition_sell_out/screen.dart';
import 'package:zahran/presentation/business/visits/details/reports/competition_stock_count/screen.dart';
import 'package:zahran/presentation/business/visits/details/reports/problem/screen.dart';
import 'package:zahran/presentation/business/visits/details/reports/return/screen.dart';
import 'package:zahran/presentation/business/visits/details/reports/sell_out/screen.dart';
import 'package:zahran/presentation/business/visits/details/reports/stock_count/screen.dart';
import 'package:zahran/presentation/business/visits/details/reports/supply_report/screen.dart';
import 'package:zahran/presentation/business/visits/details/visit_details.dart';
import 'package:zahran/presentation/commom/image_preview/image_preview_screen.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.pm.dart';
import 'package:zahran/presentation/commom/video_preview/video_preview_view_model.dart';
import 'package:zahran/presentation/commom/voices/voice_note.component.dart';
import 'package:zahran/presentation/commom/voices/voice_note.pm.dart';

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
  VIDEO_PREVIEW,
  TAS_DETAILS,
  COMMENT_REPORT,
  PROBLEM_REPORT,
  COMPITION_STOCK_COUNT_REPORT,
  COMPITION_SELL_OUT_REPORT,
  SELL_OUT_REPORT,
  STOCK_COUNT_REPORT,
  RETURN_REPORT,
  SUPPLY_REPORT,
}

enum PopupsNames { LOGOUT, MEDIA_PICKER_POPUP }

enum BottomSheetNames { VOICE_NOTE }

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
        "${ScreenNames.NOTIFICATION_DETAILS}": (_) =>
            NotificationDetailsScreen(),
        "${ScreenNames.IMAGE_PREVIEW}": (_) => ImagePreviewScreen(),
        "${ScreenNames.VIDEO_PREVIEW}": (_) => VideoPreviewScreen(),
        "${ScreenNames.TAS_DETAILS}": (_) => TaskDetailsScreen(),
        "${ScreenNames.COMMENT_REPORT}": (_) => CommentReportScreen(),
        "${ScreenNames.PROBLEM_REPORT}": (_) => ProblemReportScreen(),
        "${ScreenNames.COMPITION_SELL_OUT_REPORT}": (_) =>
            CompitionSellOutReportScreen(),
        "${ScreenNames.COMPITION_STOCK_COUNT_REPORT}": (_) =>
            CompitionStockCountReportScreen(),
        "${ScreenNames.SELL_OUT_REPORT}": (_) => SellOutReportScreen(),
        "${ScreenNames.STOCK_COUNT_REPORT}": (_) => StockCountReportScreen(),
        "${ScreenNames.SUPPLY_REPORT}": (_) => SupplyReportScreen(),
        "${ScreenNames.RETURN_REPORT}": (_) => ReturnReportScreen(),
      };

  static void pop<T extends Object>([T? result]) {
    if (key.currentState!.canPop()) key.currentState!.pop(result);
  }

  static bool canPop() {
    return key.currentState!.canPop();
  }

  static Future showBottomSheet(
      {required BottomSheetNames type,
      Map<String, dynamic>? parameters,
      Map<String, Function>? actionsCallbacks,
      bool barrierDismissible = false}) {
    Widget _sheet;
    switch (type) {
      case BottomSheetNames.VOICE_NOTE:
        _sheet = VoiceNote(
            intent: parameters!["voiceNoteIntent"] as VoiceNoteIntent,
            onAcceptNote: ({File? file}) {
              print("On Accept Note with file $file 🚀 🚀 🚀 🚀");
              actionsCallbacks!['onAcceptNoteCallback']!(file);
            },
            onRemoveNote: () {
              print("On Remove Note 🚀 🚀 🚀 🚀");
              actionsCallbacks!['onRemoveNoteCallback']!();
            },
            onClose: () {
              print("On Close Note 🚀 🚀 🚀 🚀");
              actionsCallbacks!['onCloseNoteCallback']!();
            },
            file: parameters["voiceNoteFile"] != null
                ? parameters["voiceNoteFile"] as File
                : null,
            audioUrl: parameters["voiceNoteUrl"] != null
                ? parameters["voiceNoteUrl"] as String
                : null);
        break;
    }

    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: barrierDismissible,
        enableDrag: false,
        context: key.currentState!.context,
        builder: (context) => _sheet);
  }

  static Future showPopup(
      {required PopupsNames type,
      Map<String, dynamic>? parameters,
      Map<String, Function>? actionsCallbacks,
      bool barrierDismissible = true}) {
    Widget _popup;
    switch (type) {
      case PopupsNames.LOGOUT:
        _popup = LogoutPopUp(
            parameters: parameters, actionsCallbacks: actionsCallbacks);
        break;
      case PopupsNames.MEDIA_PICKER_POPUP:
        _popup = MediaPickerComponent(
          mediaPickerFileCallback: ({MediaLocal? mediaModel}) async {
            print("🚀🚀🚀🚀 Callback with data $mediaModel");
            actionsCallbacks!['mediaPickerCallback']!(mediaModel);
          },
          mediaPickerType: parameters!["pickerType"] as MediaPickerType,
          onMediaDismissedCallback: () {
            print("🚀🚀🚀🚀 Dismiss");
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

import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/base/BasePM.dart';
import 'package:zahran/presentation/config/configs.dart';
import 'package:zahran/presentation/localization/ext.dart';

import '../toolbox.helper.dart';

class AppErrorComponent extends StatelessWidget {
  final ErrorModel errorModel;

  AppErrorComponent({@required this.errorModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 36, left: 16, right: 16, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(GeneralConfigs.IMAGE_ASSETS_PATH + "error-artwork.png"),
              ViewsToolbox.emptySpaceWidget(height: 16),
              Text(
                TR.of(context).error_dialog_header,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
              ViewsToolbox.emptySpaceWidget(height: 12),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 30, end: 30),
                child: Text(
                  // errorModel.localErrorCode.value
                  errorModel.isLocalError
                      ? TR.of(context).generic_error_message //TODO: search how to get dynamic localization
                      : errorModel.errorMessage ?? TR.of(context).generic_error_message,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).textTheme.headline6.color,
                        fontWeight: FontWeight.w400,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              ViewsToolbox.emptySpaceWidget(height: 24),
              drawTryAgainButton(context),
              ViewsToolbox.emptySpaceWidget(height: 16),
              GestureDetector(
                onTap: errorModel.dismiss,
                child: Text(
                  TR.of(context).dismiss,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).textTheme.headline6.color,
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawTryAgainButton(BuildContext context) {
    return errorModel.retry == null
        ? Container()
        : Container(
            height: 48,
            child: FlatButton(
              onPressed: onRetry,
              child: Center(
                child: Text(
                  TR.of(context).try_again,
                  style:
                      Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              // color: Color(themeColors.colorBlue), //TODO: un comment this later
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          );
  }

  void onRetry() {
    errorModel.dismiss();
    errorModel.retry();
  }
}

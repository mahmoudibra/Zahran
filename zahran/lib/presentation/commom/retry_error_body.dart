import 'package:flutter/material.dart';
import 'package:zahran/presentation/config/configs.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'toolbox.helper.dart';

class RetryErrorBody extends StatelessWidget {
  final VoidCallback retry;
  final String? errorMessage;
  final String? errorIcon;

  RetryErrorBody(
      {required this.retry, required this.errorMessage, this.errorIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        errorIcon != null
            ? Image.asset(GeneralConfigs.IMAGE_ASSETS_PATH + errorIcon!)
            : Image.asset(
                GeneralConfigs.IMAGE_ASSETS_PATH + "error-artwork.png"),
        ViewsToolbox.emptySpaceWidget(height: 16),
        Text(
          TR.of(context).we_are_sorry,
          style: Theme.of(context).textTheme.headline4?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        ViewsToolbox.emptySpaceWidget(height: 12),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 30, end: 30),
          child: Text(
            errorMessage ?? TR.of(context).generic_error_message,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        drawTryAgainButton(context),
      ],
    );
  }

  Widget drawTryAgainButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: .72 * MediaQuery.of(context).size.width,
      height: 48,
      margin: EdgeInsets.only(top: 14),
      child: TextButton(
        onPressed: retry,
        child: Center(
          child: Text(
            TR.of(context).try_again,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        style: TextButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}

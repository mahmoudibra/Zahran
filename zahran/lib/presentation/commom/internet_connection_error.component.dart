import 'package:flutter/material.dart';
import 'package:zahran/presentation/config/configs.dart';
import 'package:zahran/presentation/localization/tr.dart';

class InternetConnectionError extends StatelessWidget {
  final VoidCallback retry;

  InternetConnectionError({required this.retry});

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 30),
              child: Image.asset(
                  GeneralConfigs.IMAGE_ASSETS_PATH + 'not-connected-art.png')),
          Container(
            margin: EdgeInsetsDirectional.only(top: 70),
            child: Text(
              TR.of(context).internet_connection_error_title,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(top: 22, start: 31, end: 31),
            child: Text(
              TR.of(context).internet_connection_error_msg,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
            ),
          ),
          _drawTryAgainButton(_screenSize, context),
        ],
      ),
    );
  }

  Widget _drawTryAgainButton(screenSize, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: .72 * screenSize.width,
      height: 48,
      margin: EdgeInsets.only(top: 105, bottom: 130),
      child: TextButton(
        onPressed: retry,
        child: Center(
          child: Text(
            TR.of(context).internet_connection_error_try_again_button,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        style: TextButton.styleFrom(
          primary: Theme.of(context).colorScheme.error,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/config/configs.dart';

class RetryErrorBody extends StatelessWidget {
  final Function retry;
  final String errorMessage;
  final String errorIcon;

  RetryErrorBody({@required this.retry, this.errorMessage, this.errorIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        errorIcon != null
            ? Image.asset(GeneralConfigs.IMAGE_ASSETS_PATH + errorIcon)
            : Image.asset(GeneralConfigs.IMAGE_ASSETS_PATH + "error-artwork.png"),
        ViewsToolbox.emptySpaceWidget(height: 16),
        Text(
          "we are sorry", //TODO: Change this later
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        ViewsToolbox.emptySpaceWidget(height: 12),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 30, end: 30),
          child: Text(
            errorMessage ?? "Generic error message", //TODO: Change this later
            style: Theme.of(context).textTheme.subtitle2.copyWith(
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
    if (retry == null) {
      return Container();
    }
    return Container(
      alignment: Alignment.center,
      width: .72 * MediaQuery.of(context).size.width,
      height: 48,
      margin: EdgeInsets.only(top: 14),
      child: FlatButton(
        onPressed: retry,
        child: Center(
          child: Text(
            "try again", //TODO: Change this later
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}

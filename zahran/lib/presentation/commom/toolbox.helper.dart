import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zahran/presentation/config/configs.dart';

class ViewsToolbox {
  /// Normalize a number 'value' from within a range 'minValue'  maxValue, given that 'limitDelta' = maxValue - minValue
  static double normalize({@required double value, @required double minValue, @required double limitDelta}) {
    double result = (value - minValue) / limitDelta;
    if (result > 1.0) return 1.0;
    if (result < 0.0) return 0.0;
    return result;
  }

  /// Returns an empty widget that takes up no space at all
  static Widget emptyWidget() {
    return Container();
  }

  /// Returns an empty sliver widget that takes up no space at all
  static Widget emptySliverWidget() {
    return SliverToBoxAdapter(child: Container());
  }

  /// Returns an empty sliver widget that fills the remaining space in sliver list
  static Widget emptySliverFillRemainingWidget() {
    return SliverFillRemaining(child: Container());
  }

  /// Returns an empty widget that takes up the provided space
  static Widget emptySpaceWidget({double height = 0.0, double width = 0.0}) {
    return SizedBox(height: height, width: width);
  }

  /// Returns a widget that when it's tapped it dismisses the keyboard if opened
  static Widget dismissKeyboardWidget({@required Widget child, @required BuildContext context, VoidCallback callback}) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        if (callback != null) callback();
      },
      child: child,
    );
  }

  /// Dismisses the keyboard if opened
  static void dismissKeyboard({@required BuildContext context}) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static Widget mainButton({
    BuildContext context,
    String text,
    Function callback,
    double marginTop = 40.0,
    double marginBottom = 0.0,
    double marginStart = 0.0,
    double marginEnd = 0.0,
    double width = 250.0,
    double height = 48.0,
    bool disabled = false,
    String iconPath,
  }) {
    return Container(
        height: height,
        width: width,
        margin: EdgeInsetsDirectional.only(
            //TODO: change it later to send margin as argument
            top: marginTop,
            bottom: marginBottom,
            start: marginStart,
            end: marginEnd),
        child: FlatButton(
            onPressed: disabled ? () {} : callback,
            color: disabled ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  iconPath != null
                      ? Image.asset(
                          GeneralConfigs.IMAGE_ASSETS_PATH + iconPath,
                          height: 14,
                          width: 14,
                        )
                      : emptyWidget(),
                  emptySpaceWidget(width: iconPath != "" ? 5.0 : 0.0, height: 0.0),
                  Text(text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: disabled ? Theme.of(context).textTheme.bodyText2.color : Colors.white,
                          ))
                ])));
  }

  static Widget secondaryButton(
      {@required BuildContext context,
      String text,
      Function callback,
      double height = 48.0,
      double marginTop = 20.0,
      Widget iconWidget,
      double width = 250.0}) {
    return Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(top: marginTop),
        child: OutlineButton(
            onPressed: callback,
            color: Colors.transparent,
            borderSide: BorderSide(color: Theme.of(context).dividerColor, width: 1.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                iconWidget != null ? iconWidget : emptyWidget(),
                emptySpaceWidget(width: iconWidget != null ? 5.0 : 0.0, height: 0.0),
                Text(text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Theme.of(context).primaryColor,
                        ))
              ],
            )));
  }

  // static void showErrorDialog(BuildContext context, ErrorModel errorModel) {
  //   showModalBottomSheet(
  //       isScrollControlled: true, context: context, builder: (context) => AppErrorComponent(errorModel: errorModel));
  // }
}

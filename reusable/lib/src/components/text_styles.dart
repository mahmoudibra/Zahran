import 'package:flutter/material.dart';

class TextStyles extends StatelessWidget {
  final Widget child;
  final TextStyle? Function(TextTheme theme) getStyle;

  const TextStyles({
    Key? key,
    required this.child,
    required this.getStyle,
  }) : super(key: key);

  factory TextStyles.bodyText1({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.bodyText1,
        child: child,
      );
  factory TextStyles.bodyText2({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.bodyText2,
        child: child,
      );
  factory TextStyles.headline1({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.headline1,
        child: child,
      );
  factory TextStyles.headline2({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.headline2,
        child: child,
      );
  factory TextStyles.headline3({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.headline3,
        child: child,
      );
  factory TextStyles.headline4({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.headline4,
        child: child,
      );
  factory TextStyles.headline5({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.headline5,
        child: child,
      );
  factory TextStyles.headline6({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.headline6,
        child: child,
      );
  factory TextStyles.button({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.button,
        child: child,
      );
  factory TextStyles.caption({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.caption,
        child: child,
      );
  factory TextStyles.overline({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.overline,
        child: child,
      );
  factory TextStyles.subtitle1({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.subtitle1,
        child: child,
      );
  factory TextStyles.subtitle2({required Widget child}) => TextStyles(
        getStyle: (TextTheme theme) => theme.subtitle2,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: getStyle(Theme.of(context).textTheme),
      child: child,
    );
  }
}

class PrimaryTextStyles extends StatelessWidget {
  final Widget child;
  final TextStyle? Function(TextTheme theme) getStyle;

  const PrimaryTextStyles({
    Key? key,
    required this.child,
    required this.getStyle,
  }) : super(key: key);

  factory PrimaryTextStyles.bodyText1({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.bodyText1,
        child: child,
      );
  factory PrimaryTextStyles.bodyText2({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.bodyText2,
        child: child,
      );
  factory PrimaryTextStyles.headline1({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.headline1,
        child: child,
      );
  factory PrimaryTextStyles.headline2({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.headline2,
        child: child,
      );
  factory PrimaryTextStyles.headline3({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.headline3,
        child: child,
      );
  factory PrimaryTextStyles.headline4({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.headline4,
        child: child,
      );
  factory PrimaryTextStyles.headline5({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.headline5,
        child: child,
      );
  factory PrimaryTextStyles.headline6({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.headline6,
        child: child,
      );
  factory PrimaryTextStyles.button({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.button,
        child: child,
      );
  factory PrimaryTextStyles.caption({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.caption,
        child: child,
      );
  factory PrimaryTextStyles.overline({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.overline,
        child: child,
      );
  factory PrimaryTextStyles.subtitle1({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.subtitle1,
        child: child,
      );
  factory PrimaryTextStyles.subtitle2({required Widget child}) =>
      PrimaryTextStyles(
        getStyle: (TextTheme theme) => theme.subtitle2,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: getStyle(Theme.of(context).primaryTextTheme),
      child: child,
    );
  }
}

class AccentTextStyles extends StatelessWidget {
  final Widget child;
  final TextStyle? Function(TextTheme theme) getStyle;

  const AccentTextStyles({
    Key? key,
    required this.child,
    required this.getStyle,
  }) : super(key: key);

  factory AccentTextStyles.bodyText1({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.bodyText1,
        child: child,
      );
  factory AccentTextStyles.bodyText2({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.bodyText2,
        child: child,
      );
  factory AccentTextStyles.headline1({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.headline1,
        child: child,
      );
  factory AccentTextStyles.headline2({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.headline2,
        child: child,
      );
  factory AccentTextStyles.headline3({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.headline3,
        child: child,
      );
  factory AccentTextStyles.headline4({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.headline4,
        child: child,
      );
  factory AccentTextStyles.headline5({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.headline5,
        child: child,
      );
  factory AccentTextStyles.headline6({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.headline6,
        child: child,
      );
  factory AccentTextStyles.button({required Widget child}) => AccentTextStyles(
        getStyle: (TextTheme theme) => theme.button,
        child: child,
      );
  factory AccentTextStyles.caption({required Widget child}) => AccentTextStyles(
        getStyle: (TextTheme theme) => theme.caption,
        child: child,
      );
  factory AccentTextStyles.overline({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.overline,
        child: child,
      );
  factory AccentTextStyles.subtitle1({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.subtitle1,
        child: child,
      );
  factory AccentTextStyles.subtitle2({required Widget child}) =>
      AccentTextStyles(
        getStyle: (TextTheme theme) => theme.subtitle2,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: getStyle(Theme.of(context).accentTextTheme),
      child: child,
    );
  }
}

class PrimaryText extends StatelessWidget {
  final Widget child;
  final TextStyle? Function(TextTheme theme) getStyle;

  const PrimaryText({
    Key? key,
    required this.child,
    required this.getStyle,
  }) : super(key: key);

  factory PrimaryText.bodyText1({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.bodyText1,
        child: child,
      );
  factory PrimaryText.bodyText2({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.bodyText2,
        child: child,
      );
  factory PrimaryText.headline1({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.headline1,
        child: child,
      );
  factory PrimaryText.headline2({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.headline2,
        child: child,
      );
  factory PrimaryText.headline3({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.headline3,
        child: child,
      );
  factory PrimaryText.headline4({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.headline4,
        child: child,
      );
  factory PrimaryText.headline5({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.headline5,
        child: child,
      );
  factory PrimaryText.headline6({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.headline6,
        child: child,
      );
  factory PrimaryText.button({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.button,
        child: child,
      );
  factory PrimaryText.caption({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.caption,
        child: child,
      );
  factory PrimaryText.overline({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.overline,
        child: child,
      );
  factory PrimaryText.subtitle1({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.subtitle1,
        child: child,
      );
  factory PrimaryText.subtitle2({required Widget child}) => PrimaryText(
        getStyle: (TextTheme theme) => theme.subtitle2,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: (getStyle(Theme.of(context).textTheme) ?? TextStyle())
          .copyWith(color: Theme.of(context).primaryColor),
      child: child,
    );
  }
}

class AccentText extends StatelessWidget {
  final Widget child;
  final TextStyle? Function(TextTheme theme) getStyle;

  const AccentText({
    Key? key,
    required this.child,
    required this.getStyle,
  }) : super(key: key);

  factory AccentText.bodyText1({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.bodyText1,
        child: child,
      );
  factory AccentText.bodyText2({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.bodyText2,
        child: child,
      );
  factory AccentText.headline1({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.headline1,
        child: child,
      );
  factory AccentText.headline2({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.headline2,
        child: child,
      );
  factory AccentText.headline3({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.headline3,
        child: child,
      );
  factory AccentText.headline4({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.headline4,
        child: child,
      );
  factory AccentText.headline5({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.headline5,
        child: child,
      );
  factory AccentText.headline6({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.headline6,
        child: child,
      );
  factory AccentText.button({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.button,
        child: child,
      );
  factory AccentText.caption({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.caption,
        child: child,
      );
  factory AccentText.overline({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.overline,
        child: child,
      );
  factory AccentText.subtitle1({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.subtitle1,
        child: child,
      );
  factory AccentText.subtitle2({required Widget child}) => AccentText(
        getStyle: (TextTheme theme) => theme.subtitle2,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: (getStyle(Theme.of(context).textTheme) ?? TextStyle())
          .copyWith(color: Theme.of(context).accentColor),
      child: child,
    );
  }
}

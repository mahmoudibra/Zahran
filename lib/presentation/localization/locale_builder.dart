import 'package:flutter/material.dart';

class LocaleBuilder extends StatefulWidget {
  final Widget Function(Locale context) builder;
  const LocaleBuilder({Key key, this.builder}) : super(key: key);
  static _LocaleBuilderState of(BuildContext context) =>
      context.findRootAncestorStateOfType<_LocaleBuilderState>();
  @override
  _LocaleBuilderState createState() => _LocaleBuilderState();
}

class _LocaleBuilderState extends State<LocaleBuilder> {
  Locale locale;
  void initLocale() {
    locale = WidgetsBinding.instance.window.locale;
  }

  void changeLocale(Locale _locale) {
    setState(() {
      locale = _locale;
    });
  }

  @override
  void initState() {
    initLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (locale == null) return SizedBox();
    return widget.builder(locale);
  }
}

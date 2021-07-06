import 'package:flutter/material.dart';

enum ScreenSize { mobile, iPad, laptop, desktop, tv }
enum CalcualtionType { screen, media_query, widget }

extension ScreenSizeExtension on ScreenSize {
  bool get isMobile => this == ScreenSize.mobile;
  bool get isIPad => this == ScreenSize.iPad;
  bool get isLaptop => this == ScreenSize.laptop;
  bool get isDesktop => this == ScreenSize.desktop;
  bool get isTv => this == ScreenSize.tv;
}

class Responsive extends StatelessWidget {
  final double mobilemaxWidth;
  final double ipadmaxWidth;
  final double laptopmaxWidth;
  final double desktopmaxWidth;
  final CalcualtionType calcualtionType;
  final Widget Function(BuildContext context, ScreenSize size) builder;
  const Responsive({
    Key? key,
    this.mobilemaxWidth = 480,
    this.ipadmaxWidth = 768,
    this.laptopmaxWidth = 1024,
    this.desktopmaxWidth = 1200,
    this.calcualtionType = CalcualtionType.media_query,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        late double width;
        var mediaqueryWidth = MediaQuery.of(context).size.width;
        switch (calcualtionType) {
          case CalcualtionType.screen:
            width = WidgetsBinding.instance?.window.physicalSize.width ??
                mediaqueryWidth;
            break;
          case CalcualtionType.media_query:
            width = mediaqueryWidth;
            break;
          case CalcualtionType.widget:
            width = constraints.maxWidth == double.infinity
                ? mediaqueryWidth
                : constraints.maxWidth;
            break;
        }

        late ScreenSize size;
        if (width <= mobilemaxWidth) {
          size = ScreenSize.mobile;
        } else if (width <= ipadmaxWidth) {
          size = ScreenSize.iPad;
        } else if (width <= laptopmaxWidth) {
          size = ScreenSize.laptop;
        } else if (width <= desktopmaxWidth) {
          size = ScreenSize.desktop;
        } else {
          size = ScreenSize.desktop;
        }

        return builder(context, size);
      },
    );
  }
}

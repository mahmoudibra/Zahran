import 'package:flutter/material.dart';

class SliverPaddingBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const SliverPaddingBox({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverToBoxAdapter(
        child: child,
      ),
    );
  }
}

class SliverSpacer extends StatelessWidget {
  final double value;
  const SliverSpacer([this.value = 20]);
  static Widget safeArea([double v = 20]) => SliverSafeArea(
        top: false,
        sliver: SliverSpacer(v),
      );
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: value),
    );
  }
}

class SliverImage extends StatelessWidget {
  final String image;
  final double factor;
  const SliverImage({
    Key? key,
    required this.image,
    this.factor = 0.4,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverPaddingBox(
      child: Center(
        child: Image.asset(
          image,
          width: MediaQuery.of(context).size.width * factor,
        ),
      ),
    );
  }
}

class SliverInputLabel extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry padding;
  const SliverInputLabel({
    Key? key,
    required this.label,
    this.padding = const EdgeInsets.only(left: 20, right: 20, bottom: 8),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverPaddingBox(
      padding: padding,
      child: Text(
        label,
        style: Theme.of(context).inputDecorationTheme.labelStyle,
      ),
    );
  }
}

class InputLabel extends StatelessWidget {
  final String label;
  const InputLabel({
    Key? key,
    required this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).inputDecorationTheme.labelStyle,
    );
  }
}

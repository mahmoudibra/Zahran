import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

class SliverShimmerView extends StatelessWidget {
  final bool loading;
  final Widget child;
  final Widget? shimmerChild;
  const SliverShimmerView({
    Key? key,
    required this.loading,
    required this.child,
    this.shimmerChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPaddingBox(
      child: ShimmerView(
        loading: loading,
        child: child,
        shimmerChild: shimmerChild,
      ),
    );
  }
}

class SliverShimmerText extends StatelessWidget {
  final bool loading;
  final Widget child;
  final bool showPlaceholder;
  const SliverShimmerText({
    Key? key,
    required this.loading,
    required this.child,
    this.showPlaceholder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPaddingBox(
      child: AnimatedSize(
        duration: Duration(milliseconds: 300),
        child: ShimmerView(
          loading: loading,
          shimmerChild:
              showPlaceholder.onTrue(ShimmerPlaceholderText(count: 5)),
          child: child,
        ),
      ),
    );
  }
}

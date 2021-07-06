part of shimmers;

class ShimmerView extends StatelessWidget {
  final bool loading;
  final Widget child;
  final Widget? shimmerChild;
  final ShimmerDirection? direction;
  final BlendMode? blendMode;
  const ShimmerView({
    Key? key,
    required this.loading,
    required this.child,
    this.shimmerChild,
    this.direction,
    this.blendMode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (loading) {
      var isdark = Theme.of(context).brightness == Brightness.dark;
      return Shimmer.fromColors(
        baseColor: (isdark
            ? Theme.of(context).colorScheme.onSurface.withAlpha(30)
            : Colors.grey[200]!),
        direction: direction ?? ShimmerDirection.ltr,
        highlightColor: isdark
            ? Theme.of(context).colorScheme.onSurface.withAlpha(150)
            : Colors.grey[300]!,
        child: shimmerChild ?? child,
      );
    }
    return child;
  }
}

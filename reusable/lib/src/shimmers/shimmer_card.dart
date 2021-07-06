part of shimmers;

class ShimmerCard extends StatefulWidget {
  final bool loading;
  final Widget child;
  final Widget? shimmerChild;
  final BlendMode? blendMode;
  final ShimmerDirection? direction;
  const ShimmerCard({
    Key? key,
    required this.loading,
    required this.child,
    this.shimmerChild,
    this.blendMode,
    this.direction,
  }) : super(key: key);

  @override
  _ShimmerCardState createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<ShimmerCard>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: Duration(milliseconds: 300),
        vsync: this,
        child: _build(context),
      ),
    );
  }

  Widget _build(BuildContext context) {
    if (widget.loading) {
      return ShimmerView(
        blendMode: widget.blendMode,
        shimmerChild: widget.shimmerChild,
        loading: true,
        direction: widget.direction,
        child: widget.child,
      );
    }
    return widget.child;
  }
}

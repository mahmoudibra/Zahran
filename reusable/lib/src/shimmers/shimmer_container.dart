part of shimmers;

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double? radius;

  const ShimmerContainer(this.width, this.height, [this.radius]);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(radius ??
              max((width == double.infinity ? 0 : width),
                  (height == double.infinity ? 0 : height)))),
    );
  }
}

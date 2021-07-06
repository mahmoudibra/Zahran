part of shimmers;

class ShimmerPlaceholderText extends StatelessWidget {
  final Random rnd = Random();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ShimmerView(
      loading: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < 50; i++) ...[
            ShimmerContainer(i.isEven ? width : width * rnd.nextDouble(), 5),
            SizedBox(height: 5)
          ]
        ],
      ),
    );
  }
}

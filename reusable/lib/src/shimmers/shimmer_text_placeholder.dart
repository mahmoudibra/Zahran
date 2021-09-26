part of shimmers;

class ShimmerPlaceholderText extends StatelessWidget {
  final Random rnd = Random();
  final int count;

  ShimmerPlaceholderText({Key? key, this.count = 50}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ShimmerView(
      loading: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < count; i++) ...[
            ShimmerContainer(i.isEven ? width : width * rnd.nextDouble(), 5),
            SizedBox(height: 5)
          ]
        ],
      ),
    );
  }
}

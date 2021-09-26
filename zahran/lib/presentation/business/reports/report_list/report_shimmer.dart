import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

class ReportShimmer extends StatelessWidget {
  const ReportShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Column(
        children: [
          Row(
            children: [
              ShimmerContainer(w * 0.5, 20),
              Spacer(),
              ShimmerContainer(w * 0.25, 20),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              ShimmerContainer(w * 0.4, 20),
              Spacer(),
              ShimmerContainer(w * 0.35, 20),
            ],
          ),
          Divider(),
          Row(
            children: [
              ShimmerContainer(w * 0.25, 20),
              Spacer(),
              CircleAvatar(),
              CircleAvatar(),
              CircleAvatar(),
            ],
          ),
        ],
      ),
    );
  }
}

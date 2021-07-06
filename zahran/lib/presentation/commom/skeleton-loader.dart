import 'package:flutter/material.dart';

class SkeletonLoader extends StatelessWidget {
  final Widget row;
  final int count;

  SkeletonLoader({@required this.row, @required this.count});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (context, index) {
        return row;
      },
    );
  }
}

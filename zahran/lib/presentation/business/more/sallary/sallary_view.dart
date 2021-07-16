import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class SallaryView extends StatelessWidget {
  final SallaryModel model;
  const SallaryView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          ScreenNames.Sallery_Details.push(model);
        },
        title: Text(
          model.title.format(context),
          style: context.headline6,
        ),
      ),
    );
  }
}

class SallaryShimmer extends StatelessWidget {
  const SallaryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rnd = Random();
    var random = (rnd.nextInt(50) / 100) + 0.3;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      alignment: AlignmentDirectional.centerStart,
      child: ShimmerContainer(width * random, 40),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/commom/rounded_chip.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/localization/tr.dart';

import '../../../../r.dart';

class CheckINView extends StatelessWidget {
  final BranchModel model;
  final VoidCallback onCheckInSelectedCallback;

  const CheckINView({Key? key, required this.model, required this.onCheckInSelectedCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          onCheckInSelectedCallback();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name.format(context),
                      style: context.headline6,
                    ),
                    RoundedChip(
                      chipText: TR.of(context).check_in_list,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      chipTextColor: Theme.of(context).colorScheme.onPrimary,
                    )
                  ],
                ),
                ViewsToolbox.emptySpaceWidget(height: 8.0),
                Row(
                  children: [
                    AssetIcon(R.assetsImgsInRange, size: 16),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        model.address.format(context),
                        style: context.overline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(TR.of(context).distance_away(model.distance.format()), style: context.overline)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// title:

class CheckInShimmer extends StatelessWidget {
  const CheckInShimmer({Key? key}) : super(key: key);

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

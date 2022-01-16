import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/rounded_image.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/r.dart';

class BranchRow extends StatelessWidget {
  final BranchModel branch;
  final VoidCallback onBranchSelectedCallback;
  BranchRow({required this.branch, required this.onBranchSelectedCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onBranchSelectedCallback();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        margin: EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).dividerColor,
              blurRadius: 4,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            branchTitle(context),
            ViewsToolbox.emptySpaceWidget(height: 8),
            branchDetails(context),
          ],
        ),
      ),
    );
  }

  Widget branchDetails(BuildContext context) {
    return Row(
      children: <Widget>[
        RoundedImage(
          radius: 20,
          borderSize: 1,
          imageUrl: branch.chain.media,
          borderColor: Theme.of(context).dividerColor,
          loadingIndicatorSize: 10,
        ),
        ViewsToolbox.emptySpaceWidget(width: 8),
        Expanded(
          child: Text(
            branch.chain.title.format(context),
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ),
        ViewsToolbox.emptySpaceWidget(width: 8),
        Text(
          TR.of(context).get_direction,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        ViewsToolbox.emptySpaceWidget(width: 8),
        Image.asset(
          R.assetsImagesArrowRight,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ],
    );
  }

  Widget branchTitle(BuildContext context) {
    return Text(
      branch.name.format(context),
      style: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/tasks/task_view.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/commom/brands_view.dart';
import 'package:zahran/presentation/commom/visit_status_chip.component.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/r.dart';

import 'app_bar.dart';

class VisitDetails extends StatelessWidget {
  const VisitDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BranchModel model =
        ModalRoute.of(context)!.settings.arguments as BranchModel;
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          DetailsAppBar(),
          _titleRow(model, context),
          _locationRow(model, context),
          _brandsnRow(model, context),
          SliverSpacer(),
          SliverPaddingBox(
            child: Text(TR.of(context).task_count(model.totalTasks),
                style: context.headline6),
          ),
          SliverSpacer(10),
          for (var i = 0; i < 10; i++)
            SliverPaddingBox(
              child: FadeItem(child: TaskView()),
            ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.login),
                label: Text(TR.of(context).check_in),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: context.theme.primaryColor),
                onPressed: () {
                  //TODO report
                },
                icon: Icon(Icons.summarize),
                label: Text(TR.of(context).report),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverPaddingBox _titleRow(BranchModel model, BuildContext context) {
    return SliverPaddingBox(
        child: Row(
      children: [
        Expanded(
          child: Text(model.name.format(context), style: context.headline6),
        ),
        SizedBox(width: 10),
        VisitStatusChip(visitStatus: 'pending'),
      ],
    ));
  }

  Widget _locationRow(BranchModel model, BuildContext context) {
    return SliverPaddingBox(
      child: Row(
        children: [
          AssetIcon(R.assetsImagesLocationInRangeIcon),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              model.address.format(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 5),
          _buildButton(context, model, () {
            launch(
                "https://www.google.com/maps/dir/?api=1&destination=${model.location.lat},${model.location.lang}");
          }, TR.of(context).get_directions),
        ],
      ),
    );
  }

  Directionality _buildButton(BuildContext context, BranchModel model,
      VoidCallback callback, String label) {
    return Directionality(
      textDirection: Directionality.of(context) == TextDirection.rtl
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsetsDirectional.only(top: 5, bottom: 5, end: 10),
        ),
        icon: Icon(
          Icons.arrow_back_ios,
          color: context.theme.accentColor,
          size: 20,
        ),
        onPressed: callback,
        label: Text(label),
      ),
    );
  }

  Widget _brandsnRow(BranchModel model, BuildContext context) {
    return SliverPaddingBox(
      child: Row(
        children: [
          Expanded(
            child: BrandsView(brands: model.brands),
          ),
          SizedBox(width: 5),
          _buildButton(context, model, () {
            launch(
                "https://www.google.com/maps/dir/?api=1&destination=${model.location.lat},${model.location.lang}");
          }, TR.of(context).see_all),
        ],
      ),
    );
  }
}

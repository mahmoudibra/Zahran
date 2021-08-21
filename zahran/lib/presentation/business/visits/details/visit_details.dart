import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/tasks/task_view.dart';
import 'package:zahran/presentation/business/visits/details/visit_details_view_model.dart';
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
    return GetBuilder<VisitDetailsViewModel>(
      init: VisitDetailsViewModel(context),
      builder: (VisitDetailsViewModel vm) {
        BranchModel model = vm.model;
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
                child: Text(TR.of(context).task_count(model.totalTasks), style: context.headline6),
              ),
              SliverSpacer(10),
              for (var task in model.tasks)
                SliverPaddingBox(
                  child: SlideFadeItem(
                    child: TaskView(
                      task: task,
                      onOpenTaskDetailsAction: () {
                        print(" 🚀🚀🚀🚀 Action here");
                        vm.routeToTaskDetailsAction(task);
                      },
                    ),
                  ),
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
                    onPressed: () => model.visitStatus.isInProgress ? vm.checkOut(model) : vm.checkIn(model),
                    icon: Icon(Icons.login),
                    label: Text(model.visitStatus.isInProgress ? TR.of(context).check_out : TR.of(context).check_in),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: context.theme.primaryColor),
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
      },
    );
  }

  SliverPaddingBox _titleRow(BranchModel model, BuildContext context) {
    return SliverPaddingBox(
        child: Row(
      children: [
        Expanded(
          child: Text(model.name.format(context), style: context.headline6),
        ),
        if (model.visitStatus == VisitStatus.IN_PROGRESS) ...[
          SizedBox(width: 10),
          VisitStatusChip(visitStatus: model.visitStatus),
        ]
      ],
    ));
  }

  Widget _locationRow(BranchModel model, BuildContext context) {
    var vm = Get.find<VisitDetailsViewModel>();
    return SliverPaddingBox(
      child: Row(
        children: [
          AssetIcon(R.assetsImgsInRange2, size: 16),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              "${model.address.format(context)} (${TR.of(context).distance(model.distance.format())})",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 5),
          _buildButton(context, model, vm.goToDirections, TR.of(context).get_directions),
        ],
      ),
    );
  }

  Directionality _buildButton(BuildContext context, BranchModel model, VoidCallback callback, String label) {
    return Directionality(
      textDirection: Directionality.of(context) == TextDirection.rtl ? TextDirection.ltr : TextDirection.rtl,
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
    var vm = Get.find<VisitDetailsViewModel>();

    return SliverPaddingBox(
      child: Row(
        children: [
          Expanded(
            child: BrandsView(brands: model.brands),
          ),
          SizedBox(width: 5),
          _buildButton(context, model, vm.goToBrands, TR.of(context).see_all),
        ],
      ),
    );
  }
}

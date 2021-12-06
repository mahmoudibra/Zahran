import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/enums/visit_status.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/tasks/task_view.dart';
import 'package:zahran/presentation/business/visits/details/visit_details_view_model.dart';
import 'package:zahran/presentation/business/visits/tickets/ticket_view.dart';
import 'package:zahran/presentation/commom/asset_icon.dart';
import 'package:zahran/presentation/commom/brands_view.dart';
import 'package:zahran/presentation/commom/shimmers.dart';
import 'package:zahran/presentation/commom/visit_status_chip.component.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/r.dart';

import 'app_bar.dart';
import 'reports_sheet.dart';

class VisitDetails extends StatefulWidget {
  const VisitDetails({Key? key}) : super(key: key);

  @override
  _VisitDetailsState createState() => _VisitDetailsState();
}

class _VisitDetailsState extends State<VisitDetails> {
  bool firstBuild = true;
  @override
  Widget build(BuildContext context) {
    if (firstBuild)
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        setState(() {
          firstBuild = false;
        });
      });
    return GetBuilder<VisitDetailsViewModel>(
      init: VisitDetailsViewModel(context),
      builder: (VisitDetailsViewModel vm) {
        BranchModel model = vm.model;
        var tasks = model.tasks;
        var tickets = model.tickets;
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => vm.loadDetails(false),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                DetailsAppBar(),
                _titleRow(vm.loading, model, context),
                _locationRow(vm.loading, model, context),
                _brandsnRow(vm.loading, model, context),
                SliverSpacer(),
                SliverShimmerText(
                  loading: vm.loading,
                  showPlaceholder: false,
                  child: Text(TR.of(context).task_count(model.totalTasks),
                      style: context.headline6),
                ),
                SliverSpacer(10),
                for (var i = 0; i < (vm.loading ? 5 : tasks.length); i++)
                  SliverPaddingBox(
                    child: AnimatedItemConfig(
                      index: i,
                      firstBuild: firstBuild,
                      child: SlideItem(
                        curve: Curves.decelerate,
                        offset: (c) => Offset(0, c.maxWidth),
                        child: TaskView(
                          loading: vm.loading,
                          task: tasks.length > i
                              ? tasks[i]
                              : TaskModel.empty(context, i),
                          onOpenTaskDetailsAction: () {
                            print(" 🚀🚀🚀🚀 Action here");
                            vm.routeToTaskDetailsAction(model.tasks[i]);
                          },
                        ),
                      ),
                    ),
                  ),
                if (tickets.length > 0) ...[
                  SliverSpacer(30),
                  SliverShimmerText(
                    loading: vm.loading,
                    showPlaceholder: false,
                    child: Text(
                        TR.of(context).tickets_count(model.tickets.length),
                        style: context.headline6),
                  ),
                  SliverSpacer(10),
                  for (var i = 0; i < tickets.length; i++)
                    SliverPaddingBox(
                      child: AnimatedItemConfig(
                        index: i,
                        firstBuild: firstBuild,
                        child: SlideItem(
                          curve: Curves.decelerate,
                          offset: (c) => Offset(0, c.maxWidth),
                          child: TicketView(
                            loading: vm.loading,
                            model: tickets[i],
                          ),
                        ),
                      ),
                    ),
                ],
                SliverSpacer.safeArea(100)
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton.icon(
                    onPressed: () => model.visitStatus.isInProgress
                        ? vm.checkOut(model)
                        : vm.checkIn(model, context),
                    icon: Icon(Icons.login),
                    label: Text(model.visitStatus.isInProgress
                        ? TR.of(context).check_out
                        : TR.of(context).check_in),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: context.theme.primaryColor),
                    onPressed: () {
                      VisitReportsSheet.show(context);
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

  Widget _titleRow(bool loading, BranchModel model, BuildContext context) {
    return SliverShimmerView(
      loading: loading,
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
      ),
    );
  }

  Widget _locationRow(bool loading, BranchModel model, BuildContext context) {
    var vm = Get.find<VisitDetailsViewModel>();
    return SliverShimmerView(
      loading: loading,
      child: Row(
        children: [
          AssetIcon(R.assetsImgsInRange2, size: 16),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              "${model.address.format(context)} (${TR.of(context).distance(model.distance.noTrailing())})",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 5),
          _buildButton(
              context, model, vm.goToDirections, TR.of(context).get_directions),
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
          color: context.theme.colorScheme.secondary,
          size: 20,
        ),
        onPressed: callback,
        label: Text(label),
      ),
    );
  }

  Widget _brandsnRow(bool loading, BranchModel model, BuildContext context) {
    var vm = Get.find<VisitDetailsViewModel>();

    return SliverShimmerView(
      loading: loading,
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

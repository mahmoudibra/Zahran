import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/reports/manage_report/base/report_item_view.dart';
import 'package:zahran/presentation/commom/media_view/media_view.dart';
import 'package:zahran/presentation/commom/shimmers.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'sevirity_chip.dart';
import 'ticket_details_view_model.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({Key? key}) : super(key: key);

  @override
  _TicketDetailsScreenState createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  bool firstBuild = true;
  @override
  Widget build(BuildContext context) {
    if (firstBuild)
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        setState(() {
          firstBuild = false;
        });
      });
    return GetBuilder<TicketDetailsViewModel>(
      init: TicketDetailsViewModel(context),
      builder: (TicketDetailsViewModel vm) {
        ReportModel model = vm.model;
        var showMedia = model.type != ReportTypes.Return_Report;
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => vm.loadDetails(false),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(elevation: 0),
                _buildTitle(vm, model, context),
                SliverShimmerText(
                  loading: vm.loading,
                  showPlaceholder: false,
                  child: Text(
                    model.problem?.problemType?.name.format(context) ?? "",
                    style: context.caption,
                  ),
                ),
                SliverSpacer(10),
                SliverShimmerText(
                  loading: vm.loading,
                  child: Text("${model.comment?.comment}"),
                ),
                SliverSpacer(15),
                if (showMedia &&
                    (vm.loading ||
                        model.comment?.media.isNotEmpty == true)) ...[
                  SliverShimmerView(
                    loading: vm.loading,
                    child: MediaView(media: model.comment?.media ?? []),
                    shimmerChild:
                        MediaView(media: List.filled(4, Media.empty())),
                  ),
                  SliverSpacer(30),
                ],
                SliverShimmerText(
                  loading: vm.loading,
                  showPlaceholder: false,
                  child: Text(
                    TR.of(context).product,
                    style: context.headline6,
                  ),
                ),
                SliverSpacer(10),
                if (vm.loading) ...[
                  for (var i = 0; i < 10; i++)
                    SliverShimmerView(
                      loading: true,
                      child: Card(
                        child: SizedBox(
                          height: model.type == ReportTypes.Return_Report
                              ? 100
                              : 50,
                        ),
                      ),
                    )
                ],
                for (var item in model.items)
                  SliverPaddingBox(
                    child: ReportItemView(
                      item: item,
                      showAsExpansion: model.type == ReportTypes.Return_Report,
                    ),
                  ),
                SliverSpacer(30),
                SliverShimmerView(
                  loading: vm.loading,
                  child: ProgressButton(
                    onPressed: (!vm.loading && !model.problem!.resolved)
                        .onTrue(vm.resolve),
                    child: Text(TR.of(context).resolve),
                  ),
                ),
                SliverSpacer.safeArea(100),
              ],
            ),
          ),
        );
      },
    );
  }

  SliverShimmerView _buildTitle(
      TicketDetailsViewModel vm, ReportModel model, BuildContext context) {
    return SliverShimmerView(
      loading: vm.loading,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    model.problem?.problemTitle ?? "",
                    maxLines: 1,
                    style: context.headline2,
                  ),
                ),
                SizedBox(width: 10),
                SevirityChip(severity: model.problem!.severity!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SliverPaddingBox _buildDate(ReportModel model, BuildContext context) {
  //   return SliverPaddingBox(
  //     child: Row(
  //       children: [
  //         Text(
  //           model.date?.format(context, DateFormat.yMMMd().pattern!) ?? "",
  //           style: context.caption,
  //         ),
  //         SizedBox(width: 10),
  //         Expanded(
  //           child: Align(
  //             alignment: AlignmentDirectional.centerEnd,
  //             child: Text(
  //               model.competitionName ?? "",
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

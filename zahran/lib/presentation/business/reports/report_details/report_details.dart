import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/media_view/media_view.dart';
import 'package:zahran/presentation/commom/shimmers.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'app_bar.dart';
import 'report_details_view_model.dart';
import 'report_item_view.dart';

class ReportDetailsScreen extends StatefulWidget {
  const ReportDetailsScreen({Key? key}) : super(key: key);

  @override
  _ReportDetailsScreenState createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  bool firstBuild = true;
  @override
  Widget build(BuildContext context) {
    if (firstBuild)
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        setState(() {
          firstBuild = false;
        });
      });
    return GetBuilder<ReportDetailsViewModel>(
      init: ReportDetailsViewModel(context),
      builder: (ReportDetailsViewModel vm) {
        ReportModel model = vm.model;
        var showMedia = model.type != ReportTypes.Return_Report;
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => vm.loadDetails(false),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                DetailsAppBar(),
                _buildDate(model, context),
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
                SliverSpacer.safeArea(100),
              ],
            ),
          ),
        );
      },
    );
  }

  SliverPaddingBox _buildDate(ReportModel model, BuildContext context) {
    return SliverPaddingBox(
      child: Row(
        children: [
          Text(
            model.date?.format(context, DateFormat.yMMMd().pattern!) ?? "",
            style: context.caption,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                model.competitor?.name.format(context) ?? "",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

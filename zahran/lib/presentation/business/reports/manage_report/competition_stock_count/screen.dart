import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/reports/manage_report/base/competitors_view_model.dart';
import 'package:zahran/presentation/commom/comment_form_field.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import '../base/product_picker.dart';
import '../base/report_item_view.dart';
import '../base/report_screen_base.dart';
import '../base/report_view_model.dart';

part 'view_model_extensions.dart';

class CompitionStockCountReportScreen extends StatelessWidget {
  const CompitionStockCountReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseReportScreen(
      type: ReportTypes.Competition_Stock_Count,
      title: TR.of(context).competition_stock_count,
      showPlaceholder: false,
      canSave: (vm) => vm.canSave,
      slivers: (ReportViewModel vm) => [
        SliverPaddingBox(
          child: SelectFormField(
            controller: CompetitorsViewModel(vm.branch),
            decoration:
                InputDecoration(hintText: TR.of(context).competition_name),
            onSelected: vm.setCompetitor,
            initialValue: vm.manager.report.competitor,
          ),
        ),
        if (vm.manager.report.competitor != null &&
            vm.manager.report.competitor?.id == null) ...[
          SliverSpacer(),
          SliverPaddingBox(
            child: CustomTextField(
              hint: TR.of(context).competition_name,
              onChanged: vm.selName,
              initialValue: vm.manager.report.competitor?.name.en,
            ),
          ),
        ],
        SliverSpacer(),
        if (vm.manager.hasItems) ...[
          SliverPaddingBox(
            child: Text(
              TR.of(context).product,
              style: context.bodyText1,
            ),
          ),
          SliverSpacer(10),
        ],
        if (vm.showProducts)
          SliverPaddingBox(
            child: ProductPicker(
              onPick: vm.addItem,
            ),
          ),
        for (var item in vm.manager.report.items) ...[
          SliverSpacer(14),
          SliverPaddingBox(
            child: ReportItemView(item: item),
          ),
        ],
        SliverSpacer(60),
        SliverPaddingBox(
          child: CommentFormField(
            intialValue: vm.manager.report.comment,
            onChanged: (v) {
              vm.selComment(v);
            },
          ),
        ),
      ],
    );
  }
}

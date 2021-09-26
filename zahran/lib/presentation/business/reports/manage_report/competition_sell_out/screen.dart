import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/comment_form_field.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import '../base/product_picker.dart';
import '../base/report_item_view.dart';
import '../base/report_screen_base.dart';
import '../base/report_view_model.dart';

part 'view_model_extensions.dart';

class CompitionSellOutReportScreen extends StatelessWidget {
  const CompitionSellOutReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseReportScreen(
      type: ReportTypes.Competition_Sell_OUT,
      title: TR.of(context).competition_stock_count,
      showPlaceholder: false,
      slivers: (ReportViewModel vm) => [
        SliverPaddingBox(
          child: CustomTextField(
            hint: TR.of(context).competition_name,
            onChanged: vm.selName,
            initialValue: vm.manager.report.competitionName,
          ),
        ),
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

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/comment_form_field.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import '../base/product_picker.dart';
import '../base/report_item_view.dart';
import '../base/report_screen_base.dart';
import '../base/report_view_model.dart';

part 'view_model_extensions.dart';

class CommentReportScreen extends StatelessWidget {
  const CommentReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseReportScreen(
      type: ReportTypes.Comment,
      title: TR.of(context).comment_report,
      callBack: (ReportViewModel vm) => vm.save(),
      slivers: (ReportViewModel vm) => [
        SliverPaddingBox(
          child: CommentFormField(
            intialValue: vm.report.comment,
            onChanged: (v) {
              vm.selComment(v);
            },
          ),
        ),
        SliverSpacer(),
        if (vm.hasItems) ...[
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
        for (var item in vm.report.items) ...[
          SliverSpacer(14),
          SliverPaddingBox(
            child: ReportItemView(item: item),
          ),
        ]
      ],
    );
  }
}

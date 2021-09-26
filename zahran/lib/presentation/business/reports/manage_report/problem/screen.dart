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

class ProblemReportScreen extends StatelessWidget {
  const ProblemReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseReportScreen(
      type: ReportTypes.Problem,
      title: TR.of(context).comment_report,
      showPlaceholder: false,
      slivers: (ReportViewModel vm) => [
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
        SliverSpacer(),
        SliverPaddingBox(
          child: Text(
            TR.of(context).problem_title,
            style: context.bodyText1,
          ),
        ),
        SliverSpacer(10),
        SliverPaddingBox(
          child: CustomTextField(
            hint: TR.of(context).enter_problem_title,
            onChanged: vm.setProlemTitle,
            initialValue: vm.manager.report.problem?.problemTitle,
          ),
        ),
        SliverSpacer(),
        SliverPaddingBox(
          child: Text(
            TR.of(context).problem_type,
            style: context.bodyText1,
          ),
        ),
        SliverSpacer(10),
        SliverPaddingBox(
          child: CustomTextField(
            hint: TR.of(context).enter_problem_type,
            onChanged: vm.setProblemType,
            initialValue: vm.manager.report.problem?.problemType,
          ),
        ),
        SliverSpacer(),
        SliverPaddingBox(
          child: CommentFormField(
            intialValue: vm.manager.report.comment,
            onChanged: (v) {
              vm.selComment(v);
            },
          ),
        ),
        SliverSpacer(),
        SliverPaddingBox(
          child: Text(
            TR.of(context).severity,
            style: context.bodyText1,
          ),
        ),
        SliverSpacer(10),
        SliverPaddingBox(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: Severity.values
                .map(
                  (e) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: vm.isInSeverity(e) ? null : Colors.white,
                      onPrimary: vm.isInSeverity(e)
                          ? null
                          : Theme.of(context).textTheme.bodyText2?.color,
                    ),
                    onPressed: () {
                      vm.setSeverity(e);
                    },
                    child: Text(vm.getSevirityDisplay(e)),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

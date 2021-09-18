import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/visits/details/reports/base/report_view_model.dart';
import 'package:zahran/presentation/commom/media_view/media_view.dart';
import 'package:zahran/r.dart';

class ReportItemView extends StatelessWidget {
  final ReportItem item;
  final Future Function()? onEdit;
  final bool showAsExpansion;
  const ReportItemView({
    Key? key,
    required this.item,
    this.onEdit,
    this.showAsExpansion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!showAsExpansion) {
      return SwipeActionCell(
        trailingActions: <SwipeAction>[
          SwipeAction(
            widthSpace: 65,
            onTap: (CompletionHandler handler) async {
              await Get.find<ReportViewModel>().deleteItem(item);
            },
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Image.asset(R.assetsImgsDeleteAction),
            ),
            color: Colors.transparent,
          ),
          if (onEdit != null)
            SwipeAction(
              widthSpace: 65,
              onTap: (CompletionHandler handler) async {
                await onEdit!();
              },
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(R.assetsImgsEditAction),
              ),
              color: Colors.transparent,
            ),
        ],
        key: Key("${item.guid}"),
        child: _build(context),
      );
    } else
      return _build(context);
  }

  Widget buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onEdit != null)
          InkWell(
            onTap: () async {
              await onEdit!();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Image.asset(R.assetsImgsEditAction, width: 40),
            ),
          ),
        InkWell(
          onTap: () async {
            await Get.find<ReportViewModel>().deleteItem(item);
          },
          child: Image.asset(R.assetsImgsDeleteAction, width: 40),
        ),
      ],
    );
  }

  Card _build(BuildContext context) {
    if (!showAsExpansion) {
      return Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          horizontalTitleGap: 0,
          leading: ShapedRemoteImage(
            width: 30,
            height: 30,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            url: item.product.media,
          ),
          title: Text(item.product.name.format(context)),
          trailing: _trailingTexts(),
        ),
      );
    }
    return Card(
      margin: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ListTileTheme(
          horizontalTitleGap: 0,
          child: ExpansionTile(
            initiallyExpanded: true,
            leading: ShapedRemoteImage(
              width: 30,
              height: 30,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
              url: item.product.media,
            ),
            title: Text(item.product.name.format(context)),
            trailing: buildActions(),
            childrenPadding: EdgeInsets.all(20),
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(DateFormat.yMMMd().format(item.createdAt), style: context.caption),
              if (item.reasonOfReaturn?.isNotEmpty == true) ...[
                SizedBox(height: 10),
                Text(
                  item.reasonOfReaturn!,
                  style: context.bodyText1,
                ),
              ],
              if (item.comment != null) ...[
                if (item.comment!.comment.isNotEmpty) ...[
                  SizedBox(height: 10),
                  Text(
                    item.reasonOfReaturn!,
                    style: context.bodyText1,
                  ),
                ],
                if (item.comment!.media.length > 0) ...[
                  SizedBox(height: 10),
                  MediaView(media: item.comment!.media),
                ]
              ]
            ],
          ),
        ),
      ),
    );
  }

  Row _trailingTexts() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.count != null) Text("${item.count}"),
        if (item.price != null) ...[
          SizedBox(width: 10),
          Text(
            "${item.price.currency(symbol: "", decimalDigits: 0)} EGP",
            textDirection: TextDirection.ltr,
          ),
        ]
      ],
    );
  }
}

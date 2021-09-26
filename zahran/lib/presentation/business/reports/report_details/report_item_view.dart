import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/media_view/media_view.dart';

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
    return _build(context);
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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              url: item.product.media,
            ),
            title: Text(item.product.name.format(context)),
            childrenPadding: EdgeInsets.all(20),
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(DateFormat.yMMMd().format(item.createdAt),
                  style: context.caption),
              if (item.reasonOfReaturn?.isNotEmpty == true) ...[
                SizedBox(height: 10),
                Text(
                  item.reasonOfReaturn!,
                  style: context.bodyText2,
                ),
              ],
              if (item.comment != null) ...[
                if (item.comment!.comment.isNotEmpty) ...[
                  Divider(),
                  Text(
                    item.comment!.comment,
                    style: context.bodyText2,
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

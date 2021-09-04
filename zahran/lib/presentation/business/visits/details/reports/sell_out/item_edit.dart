import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/localization/tr.dart';

class EditItem extends StatefulWidget {
  final ReportItem item;
  final bool isNew;
  const EditItem({Key? key, required this.item, required this.isNew})
      : super(key: key);

  static Future<ReportItem?> show(
      BuildContext context, ReportItem item, bool isNew) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return EditItem(item: item, isNew: isNew);
        });
  }

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  late ReportItem model;
  @override
  void initState() {
    model = widget.item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CompletedForm(
      onPostData: () async {
        Navigator.of(context).pop(model);
      },
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20).copyWith(
            top: 30, bottom: MediaQuery.of(context).viewInsets.bottom + 30),
        children: [
          Text(
            widget.item.product.name.format(context),
            style: context.bodyText1,
          ),
          SizedBox(height: 20),
          Text(
            TR.of(context).quantity,
            style: context.bodyText1,
          ),
          SizedBox(height: 5),
          CustomTextField(
            hint: TR.of(context).quantity_hint,
            textInputType: TextInputType.number,
            maxLength: 5,
            initialValue: model.count?.toString(),
            onSaved: (v) => model = model.copyWith(count: int.parse(v ?? "")),
            validator: (v) {
              var res = int.tryParse(v ?? "");
              if (res == null || res <= 0)
                return TR.of(context).invalid_quantity;
            },
          ),
          SizedBox(height: 10),
          Text(
            TR.of(context).price,
            style: context.bodyText1,
          ),
          SizedBox(height: 5),
          CustomTextField(
            hint: TR.of(context).price_hint,
            textInputType: TextInputType.number,
            maxLength: 8,
            initialValue: model.price?.noTrailing(),
            onSaved: (v) =>
                model = model.copyWith(price: double.parse(v ?? "")),
            validator: (v) {
              var res = double.tryParse(v ?? "");
              if (res == null || res <= 0) return TR.of(context).invalid_price;
            },
          ),
          SizedBox(height: 20),
          ProgressButton(
              child:
                  Text(widget.isNew ? TR.of(context).add : TR.of(context).edit))
        ],
      ),
    );
  }
}

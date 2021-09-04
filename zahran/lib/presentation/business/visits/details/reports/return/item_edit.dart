import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/comment_form_field.dart';
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
            TR.of(context).return_reason,
            style: context.bodyText1,
          ),
          SizedBox(height: 5),
          CustomTextField(
            hint: TR.of(context).return_reason_hint,
            initialValue: model.reasonOfReaturn,
            onSaved: (v) => model = model.copyWith(reasonOfReaturn: v),
          ),
          SizedBox(height: 20),
          CommentFormField(
            intialValue: model.comment,
            onChanged: (v) => model = model.copyWith(comment: v),
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

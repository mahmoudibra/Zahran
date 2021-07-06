library select_form_feilds;

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:simple/simple.dart';
part 'sheet.dart';
part 'select_form_field.dart';
part 'multi_select_form_field.dart';

mixin SelectFormController<TItem> on BaseListController<TItem> {
  bool checkSelected(TItem left, TItem right);
  String getItemDisplay(BuildContext context, TItem item) =>
      getDisplay(context, item);
  String getDisplay(BuildContext context, TItem item);
}

import 'package:flutter/src/widgets/framework.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';

class SelectItemsViewModel extends ListController<SelectItem>
    with SelectFormController {
  @override
  bool checkSelected(SelectItem left, SelectItem right) {
    return left.id == right.id;
  }

  @override
  String getDisplay(BuildContext context, SelectItem item) {
    return item.name.format(context);
  }

  @override
  Future<ApiListResponse<SelectItem>> loadData(int skip) {
    return Repos.reports.problemTypes();
  }
}

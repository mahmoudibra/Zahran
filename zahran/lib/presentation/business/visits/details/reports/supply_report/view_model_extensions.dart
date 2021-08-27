part of 'screen.dart';

extension VMExt on ReportViewModel {
  bool canAddProduct(Product product) {
    var items = report.items;
    if (items.any((element) => element.product.id == product.id)) {
      context.errorSnackBar(TR.of(context).product_already_added);
      return false;
    }
    return true;
  }

  void addItem(ReportItem item) async {
    report.items.add(item);
    await report.save();
    ScreenRouter.pop();
  }

  void editItem(ReportItem item) async {
    var index = report.items
        .indexWhere((element) => element.product.id == item.product.id);
    report.items.removeAt(index);
    report.items.insert(index, item);
    await report.save();
  }

  void selComment(CommentModel? comment) async {
    report.comment = comment;
    await report.save();
  }

  Future save() async {
    await Repos.reports.supplyOrder(report);
    Navigator.of(context).pop();
  }
}

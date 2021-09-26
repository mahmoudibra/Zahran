part of 'screen.dart';

extension VMExt on ReportViewModel {
  bool canAddProduct(Product product) {
    var items = manager.report.items;
    if (items.any((element) => element.product.id == product.id)) {
      context.errorSnackBar(TR.of(context).product_already_added);
      return false;
    }
    return true;
  }

  void addItem(ReportItem item) async {
    manager.report.items.add(item);
    await manager.report.save();
    ScreenRouter.pop();
  }

  void editItem(ReportItem item) async {
    var index = manager.report.items
        .indexWhere((element) => element.product.id == item.product.id);
    manager.report.items.removeAt(index);
    manager.report.items.insert(index, item);
    await manager.report.save();
  }

  void selComment(CommentModel? comment) async {
    manager.report.comment = comment;
    await manager.report.save();
  }
}

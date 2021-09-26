part of 'screen.dart';

extension VMExt on ReportViewModel {
  void addItem(Product product) async {
    var items = manager.report.items;
    if (items.any((element) => element.product.id == product.id)) {
      context.errorSnackBar(TR.of(context).product_already_added);
      return;
    }
    manager.report.items.add(ReportItem(product: product));
    await manager.report.save();
    ScreenRouter.pop();
  }

  void selComment(CommentModel? comment) async {
    manager.report.comment = comment;
    await manager.report.save();
  }
}

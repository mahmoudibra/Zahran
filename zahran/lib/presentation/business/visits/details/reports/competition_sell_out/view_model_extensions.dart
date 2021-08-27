part of 'screen.dart';

extension VMExt on ReportViewModel {
  void addItem(Product product) async {
    var items = report.items;
    if (items.any((element) => element.product.id == product.id)) {
      context.errorSnackBar(TR.of(context).product_already_added);
      return;
    }
    report.items.add(ReportItem(product: product));
    await report.save();
    ScreenRouter.pop();
  }

  void selName(String? name) async {
    print(report.isInBox);
    report.competitionName = name;
    await report.save();
  }

  void selComment(CommentModel? comment) async {
    report.comment = comment;
    await report.save();
  }

  Future save() async {
    await Repos.reports.competitionSellOut(report);
    Navigator.of(context).pop();
  }
}

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

  bool get showProducts =>
      hasCompetitor && manager.report.competitor!.products.length > 0;
  bool get hasCompetitor => manager.report.competitor != null;
  bool get canSave {
    return hasCompetitor &&
        !manager.report.competitor!.name.en.isNullOrEmptyOrWhiteSpace &&
        (!showProducts || manager.hasItems);
  }

  void setCompetitor(CompetitorModel? competitor) async {
    if (manager.report.competitor?.id != competitor?.id) {
      manager.report.items.clear();
    }
    manager.report.competitor = competitor;
    await manager.report.save();
  }

  void selName(String? name) async {
    assert(manager.report.competitor?.id == null);
    if (name == null) {
      manager.report.competitor = null;
    } else {
      manager.report.competitor = CompetitorModel.withName(name);
    }
    await manager.report.save();
  }

  void selComment(CommentModel? comment) async {
    manager.report.comment = comment;
    await manager.report.save();
  }
}

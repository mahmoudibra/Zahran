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

  void setProlemTitle(String? s) async {
    manager.report.problem =
        manager.report.problem?.copyWith(problemTitle: s) ??
            ProblemDetailsModel(problemTitle: s);
    await manager.report.save();
  }

  void setProblemType(String? s) async {
    manager.report.problem = manager.report.problem?.copyWith(problemType: s) ??
        ProblemDetailsModel(problemType: s);
    await manager.report.save();
  }

  void setSeverity(Severity s) async {
    manager.report.problem = manager.report.problem?.copyWith(severity: s) ??
        ProblemDetailsModel(severity: s);
    await manager.report.save();
  }

  bool isInSeverity(Severity s) {
    if (manager.report.problem == null) return false;
    return manager.report.problem?.severity == s;
  }

  String getSevirityDisplay(Severity s) {
    switch (s) {
      case Severity.Low:
        return TR.of(context).low;
      case Severity.Medium:
        return TR.of(context).medium;
      case Severity.High:
        return TR.of(context).high;
    }
  }
}

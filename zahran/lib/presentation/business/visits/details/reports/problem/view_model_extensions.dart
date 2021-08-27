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

  void selComment(CommentModel? comment) async {
    report.comment = comment;
    await report.save();
  }

  void setProlemTitle(String? s) async {
    report.problem = report.problem?.copyWith(problemTitle: s) ??
        ProblemDetailsModel(problemTitle: s);
    await report.save();
  }

  void setProblemType(String? s) async {
    report.problem = report.problem?.copyWith(problemType: s) ??
        ProblemDetailsModel(problemType: s);
    await report.save();
  }

  void setSeverity(Severity s) async {
    report.problem = report.problem?.copyWith(severity: s) ??
        ProblemDetailsModel(severity: s);
    await report.save();
  }

  bool isInSeverity(Severity s) {
    if (report.problem == null) return false;
    return report.problem?.severity == s;
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

  Future save() async {
    // await Repos.reports.competitionSellOut(report);
    // Navigator.of(context).pop();
  }
}

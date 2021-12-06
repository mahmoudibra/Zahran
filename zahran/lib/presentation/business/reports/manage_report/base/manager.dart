import 'package:zahran/domain/models/models.dart';

abstract class ReportViewModelManager {
  Future deleteItem(ReportItem item);
  ReportModel get report;
  Future reset([ReportModel? model]);
  bool get hasItems;
  bool get isReady;
  Future onInit();

  void onClose();
  Future save();
  bool get showPopUp;
}

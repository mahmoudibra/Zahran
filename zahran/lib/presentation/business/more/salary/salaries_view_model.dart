import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';

class SalariesViewModel extends ListController<SalaryModel> {
  String? _query;
  void search(String? v) {
    if (_query == v) return;
    _query = v;
    update();
  }

  String? get query => _query;
  Iterable<SalaryModel> get filtered =>
      items.where((element) => element.title.hasName(_query ?? ""));
  @override
  Future<ApiListResponse<SalaryModel>> loadData(int skip) async {
    return Repos.sallaryRepo.pagination(skip);
  }
}

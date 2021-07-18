import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';

class CheckInListViewModel extends ListController<BranchModel> {
  String? _query;
  void search(String? v) {
    if (_query == v) return;
    _query = v;
    update();
  }

  String? get query => _query;
  Iterable<BranchModel> get filtered => items.where((element) => element.name.hasName(_query ?? ""));

  @override
  Future<ApiListResponse<BranchModel>> loadData(int skip) async {
    return Repos.visitsRepo.pagination(skip);
  }
}

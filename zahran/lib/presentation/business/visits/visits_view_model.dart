import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';

class VisitsViewModel extends ListController<Map> {
  @override
  Future<ApiListResponse<Map>> loadData(int skip) {
    return Repos.visitsRepo.pagination(skip);
  }
}

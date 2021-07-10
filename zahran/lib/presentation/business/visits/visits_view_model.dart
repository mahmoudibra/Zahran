import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';

class VisitsViewModel extends ListController<BranchModel> {
  @override
  Future<ApiListResponse<BranchModel>> loadData(int skip) {
    return Repos.visitsRepo.pagination(skip);
  }
}

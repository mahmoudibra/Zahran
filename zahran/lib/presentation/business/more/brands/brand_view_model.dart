import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';

class BrandListViewModel extends ListController<BrandModel> {
  @override
  Future<ApiListResponse<BrandModel>> loadData(int skip) {
    return Repos.brandRepo.pagination(skip: skip);
  }
}

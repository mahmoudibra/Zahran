import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/helpers/map.maneger.dart';

class BranchListViewModel extends ListController<BranchModel> {
  @override
  Future<ApiListResponse<BranchModel>> loadData(int skip) {
    return Repos.visitsRepo.pagination(skip);
  }

  Future<void> routeToBranchLocation(int index) async {
    var branches = items;
    var selectedBranch = branches.toList()[index];
    await MapUtils.openMap(selectedBranch.location.lat, selectedBranch.location.lang);
  }
}

import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/document.dart';

class DocumentsListViewModel extends ListController<Document> {
  @override
  Future<ApiListResponse<Document>> loadData(int skip) {
    return Repos.documentRepo.pagination(skip);
  }

  Future<void> routeToDocumentDetails(int index) async {}
}

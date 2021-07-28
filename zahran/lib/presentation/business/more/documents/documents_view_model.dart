import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/document.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class DocumentsListViewModel extends ListController<Document> {
  @override
  Future<ApiListResponse<Document>> loadData(int skip) {
    return Repos.documentRepo.pagination(skip);
  }

  Future<void> routeToDocumentDetails(int index) async {
    var documents = items;
    var selectedDocument = documents.toList()[index];
    print("🚀🚀🚀 ssssss $selectedDocument");
    ScreenNames.DOCUMENT_DETAILS.push(selectedDocument);
  }
}

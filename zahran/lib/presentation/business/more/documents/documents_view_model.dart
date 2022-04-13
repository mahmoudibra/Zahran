import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/document.dart';
import 'package:zahran/presentation/commom/flare_component.dart';
import 'package:zahran/presentation/localization/tr.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class DocumentsListViewModel extends ListController<Document> {
  final BuildContext context;

  DocumentsListViewModel(this.context);
  @override
  Future<ApiListResponse<Document>> loadData(int skip) {
    return Repos.documentRepo.pagination(skip);
  }

  Future<void> routeToDocumentDetails(int index) async {
    var documents = items;
    var selectedDocument = documents.elementAt(index);
    print("🚀🚀🚀 selectedDocument $selectedDocument");
    if (selectedDocument.documentUrl.endsWith(".pdf")) {
      ScreenNames.DOCUMENT_DETAILS.push(selectedDocument);
    } else {
      var filename = path.basename(selectedDocument.documentUrl);
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = "${tempDir.path}/$filename";
      var exists = await File(tempPath).exists();
      if (exists) {
        _openFile(tempPath);
      } else {
        await FlareAnimation.show(
          action: (notifier) => Repos.documentRepo
              .downloadDocument(selectedDocument, tempPath, (value) {
            notifier.value = value;
          }),
          context: context,
        );
        _openFile(tempPath);
      }
    }
  }

  Future _openFile(String path) async {
    try {
      await OpenFile.open(path);
    } catch (e) {
      context.errorSnackBar(TR.of(context).can_not_open_file);
    }
  }
}

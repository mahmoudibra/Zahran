import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/document.dart';
import 'package:zahran/presentation/business/more/documents/document_row.dart';
import 'package:zahran/presentation/commom/scaffold_list_silver_app_bar.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'documents_view_model.dart';

class DocumentListScreen extends StatelessWidget {
  const DocumentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DocumentsListViewModel(context),
        builder: (DocumentsListViewModel vm) {
          return ScaffoldListSilverAppBar(
            content: buildBranchList(context, vm),
            title: TR.of(context).documents,
          );
        });
  }

  Widget buildBranchList(BuildContext context, DocumentsListViewModel vm) {
    return CompleteList.sliversWithList(
      enablePullUp: false,
      padding: EdgeInsets.all(0).copyWith(top: 0),
      builItem: (Document item, index) {
        return FadeItem(
            child: DocumentRow(
          document: item,
          onDocumentSelectedCallback: () {
            vm.routeToDocumentDetails(index);
          },
        ));
      },
      init: vm,
    );
  }
}

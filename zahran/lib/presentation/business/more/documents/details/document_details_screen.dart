import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:zahran/presentation/commom/scaffold_silver_app_bar.dart';

import 'documents_details_view_model.dart';

class DocumentDetailsScreen extends StatefulWidget {
  DocumentDetailsScreen({Key? key}) : super(key: key);

  @override
  _DocumentDetailsScreenState createState() => _DocumentDetailsScreenState();
}

class _DocumentDetailsScreenState extends State<DocumentDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DocumentsDetailsViewModel(context),
      builder: (DocumentsDetailsViewModel vm) {
        return ScaffoldSilverAppBar(
          content: buildBody(context, vm),
          title: vm.model.name.format(context),
        );
      },
    );
  }

  Widget buildBody(BuildContext context, DocumentsDetailsViewModel vm) {
    return SfPdfViewer.network(
      vm.model.documentUrl,
      initialScrollOffset: Offset(0, 500),
      initialZoomLevel: 1.5,
      onDocumentLoaded: (PdfDocumentLoadedDetails details) {
        print("💪💪💪💪 ${details.document.pages.count}");
      },
      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails error) {
        print("Failed 💪💪💪💪 ${error.description}");
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zahran/domain/models/document.dart';
import 'package:zahran/presentation/business/base/base_details_view_model.dart';

class DocumentsDetailsViewModel extends BaseDetailsViewModel<Document> {
  DocumentsDetailsViewModel(BuildContext context) : super(context);

  @override
  Future<Document> fetchDetails() async {
    return model;
  }
}

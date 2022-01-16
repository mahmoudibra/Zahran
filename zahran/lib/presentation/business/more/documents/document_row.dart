import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/document.dart';

class DocumentRow extends StatelessWidget {
  final Document document;
  final VoidCallback onDocumentSelectedCallback;
  DocumentRow(
      {required this.document, required this.onDocumentSelectedCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          onDocumentSelectedCallback();
        },
        title: Text(
          document.name.format(context),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}

class DocumentShimmer extends StatelessWidget {
  const DocumentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rnd = Random();
    var random = (rnd.nextInt(50) / 100) + 0.3;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      alignment: AlignmentDirectional.centerStart,
      child: ShimmerContainer(width * random, 40),
    );
  }
}

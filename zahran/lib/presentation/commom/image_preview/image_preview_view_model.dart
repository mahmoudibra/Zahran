import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

class ImagePreviewViewModel extends GetxController {
  late String _imageUrl;
  final BuildContext context;

  ImagePreviewViewModel(this.context) {
    _imageUrl = ModalRoute.of(context)!.settings.arguments as String;
    update();
  }

  String get imageUrl => _imageUrl;
}

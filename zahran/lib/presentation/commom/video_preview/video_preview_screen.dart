import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

class VideoPreviewViewModel extends GetxController {
  late String _videoUrl;
  final BuildContext context;

  VideoPreviewViewModel(this.context) {
    _videoUrl = ModalRoute.of(context)!.settings.arguments as String;
    update();
  }

  String get videoUrl => _videoUrl;
}

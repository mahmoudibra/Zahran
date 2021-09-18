import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewViewModel extends GetxController {
  late String _videoUrl;
  final BuildContext context;

  late VideoPlayerController _controller;
  bool get isVideoIntialized => _controller.value.isInitialized;
  VideoPlayerValue get value => _controller.value;
  VideoPlayerController get controller => _controller;
  VideoPreviewViewModel(this.context) {
    _videoUrl = ModalRoute.of(context)!.settings.arguments as String;
    update();
  }

  String get videoUrl => _videoUrl;

  @override
  void onInit() {
    _controller = VideoPlayerController.network(videoUrl);
    _controller.addListener(update);
    _controller.setLooping(true);
    _controller.initialize().then((value) {
      update();
    });
    _controller.play();
    super.onInit();
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}

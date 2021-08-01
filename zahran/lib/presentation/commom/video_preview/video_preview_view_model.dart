import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:video_player/video_player.dart';
import 'package:zahran/presentation/commom/video_preview/video_preview_screen.dart';
import 'package:zahran/presentation/localization/tr.dart';

import '../scaffold_silver_app_bar.dart';

class VideoPreviewScreen extends StatefulWidget {
  VideoPreviewScreen();

  @override
  _VideoPreviewScreenState createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    var auth = Get.find<VideoPreviewViewModel>();

    _videoPlayerController = VideoPlayerController.network(auth.videoUrl);

    _videoPlayerController.addListener(() {
      setState(() {});
    });
    _videoPlayerController.setLooping(true);
    _videoPlayerController.initialize();
    _videoPlayerController.play();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return GetBuilder(
      init: VideoPreviewViewModel(context),
      builder: (VideoPreviewViewModel vm) {
        return ScaffoldSilverAppBar(
          content: content(context, vm),
          title: TR.of(context).image_preview,
          paddingVertical: 0.0,
          paddingHorizontal: 0.0,
        );
      },
    );
  }

  Widget content(BuildContext context, VideoPreviewViewModel vm) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(_videoPlayerController),
                      ClosedCaption(text: _videoPlayerController.value.caption.text),
                      PlayPauseOverlay(
                        controller: _videoPlayerController,
                        key: null,
                      ),
                      VideoProgressIndicator(_videoPlayerController, allowScrubbing: true),
                    ],
                  ))
              : Container()),
    );
  }
}

class PlayPauseOverlay extends StatelessWidget {
  final VideoPlayerController controller;

  const PlayPauseOverlay({required Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}

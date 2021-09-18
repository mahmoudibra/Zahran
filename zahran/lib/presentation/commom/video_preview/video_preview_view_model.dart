import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:video_player/video_player.dart';
import 'package:zahran/presentation/commom/video_preview/video_preview_screen.dart';
import 'package:zahran/presentation/localization/tr.dart';

import '../scaffold_silver_app_bar.dart';

class VideoPreviewScreen extends StatelessWidget {
  VideoPreviewScreen();

  Widget build(BuildContext context) {
    return GetBuilder(
      init: VideoPreviewViewModel(context),
      builder: (VideoPreviewViewModel vm) {
        return ScaffoldSilverAppBar(
          content: content(context, vm),
          title: TR.of(context).video_preview,
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
          child: vm.isVideoIntialized
              ? AspectRatio(
                  aspectRatio: vm.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(vm.controller),
                      ClosedCaption(text: vm.value.caption.text),
                      PlayPauseOverlay(
                        controller: vm.controller,
                        key: null,
                      ),
                      VideoProgressIndicator(vm.controller,
                          allowScrubbing: true),
                    ],
                  ))
              : Container()),
    );
  }
}

class PlayPauseOverlay extends StatelessWidget {
  final VideoPlayerController controller;

  const PlayPauseOverlay({required Key? key, required this.controller})
      : super(key: key);

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

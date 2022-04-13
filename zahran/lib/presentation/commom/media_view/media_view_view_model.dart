import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/media_picker/MediaFileTypes.dart';
import 'package:zahran/presentation/commom/voices/voice_note.pm.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import '../flare_component.dart';

class MediaViewViewModel extends GetxController {
  final BuildContext context;

  MediaViewViewModel(this.context);

  openMediaViewAction(Media media) {
    if (media.type == MediaFileTypes.IMAGE.value) {
      print("🚀🚀🚀🚀 Open Image Preview");
      ScreenNames.IMAGE_PREVIEW.push(media.mediaPath);
    } else if (media.type == MediaFileTypes.VIDEO.value) {
      print("🚀🚀🚀🚀 Open Video Preview");
      ScreenNames.VIDEO_PREVIEW.push(media.mediaPath);
    } else {
      print("🚀🚀🚀🚀 Open Sound Component ");
      playVoiceNote(media, context);
    }
  }

  Future<void> playVoiceNote(Media media, BuildContext context) async {
    ScreenRouter.showBottomSheet(
        type: BottomSheetNames.VOICE_NOTE,
        parameters: _prepareVoiceNoteParameter(
            voiceNoteIntent: VoiceNoteIntent.Play,
            voiceNoteUrl: media.mediaPath),
        actionsCallbacks: _prepareVoiceNoteActions(context));
  }

  Map<String, dynamic>? _prepareVoiceNoteParameter(
      {required VoiceNoteIntent voiceNoteIntent,
      File? voiceNoteFile,
      String? voiceNoteUrl}) {
    Map<String, dynamic>? parameters = Map();
    parameters["voiceNoteIntent"] = voiceNoteIntent;
    parameters["voiceNoteFile"] = voiceNoteFile;
    parameters["voiceNoteUrl"] = voiceNoteUrl;
    return parameters;
  }

  Map<String, Function> _prepareVoiceNoteActions(BuildContext context) {
    Map<String, Function> actionsCallbacks = Map();
    actionsCallbacks['onAcceptNoteCallback'] = (File? file) async {
      ScreenRouter.pop();
      print("🚀🚀🚀🚀 onAcceptNoteCallback done with file $file}");
      var mediaModel = MediaLocal(
        mediaFile: file!,
        mediaFileTypes: MediaFileTypes.AUDIO,
        fileName: path.basename(file.path),
      );
      try {
        await FlareAnimation.show(
          action: (notifier) => mediaModel.compressAndUpload(
            notifier: notifier,
            upload: (file, onProgress) async {
              return await Repos.mediaRepo.uploadMedia(
                uploadedFile: file,
                mediaFileTypes: mediaModel.mediaFileTypes,
                onProgress: onProgress,
              );
            },
          ),
          context: context,
        );
      } catch (e) {}
    };
    actionsCallbacks['onCloseNoteCallback'] =
        () => {ScreenRouter.pop(), print("🚀🚀🚀🚀 On Close Note Callback")};
    actionsCallbacks['onRemoveNoteCallback'] =
        () => {ScreenRouter.pop(), print("🚀🚀🚀🚀 On Remove Note Callback")};
    return actionsCallbacks;
  }
}

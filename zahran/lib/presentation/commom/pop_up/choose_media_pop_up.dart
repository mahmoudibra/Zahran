import 'package:flutter/material.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.pm.dart';
import 'package:zahran/presentation/commom/pop_up/pop_up.component.dart';
import 'package:zahran/presentation/localization/tr.dart';

class MediaPickerPopUp extends StatelessWidget {
  final VoidCallback onPickFromCameraCallback;
  final VoidCallback onPickFromGalleryCallback;
  final VoidCallback onRecordVideoCallback;
  final VoidCallback onChooseVideoCallabck;
  final VoidCallback onMediaDismissedCallback;
  final MediaPickerType mediaPickerType;

  MediaPickerPopUp({
    required this.onPickFromCameraCallback,
    required this.onPickFromGalleryCallback,
    required this.onRecordVideoCallback,
    required this.onChooseVideoCallabck,
    required this.mediaPickerType,
    required this.onMediaDismissedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return _drawStateSelectPicker(context);
  }

  Widget _drawStateSelectPicker(BuildContext context) {
    return PopUp(
      implicitDismiss: true,
      title: TR.of(context).choose_media,
      message: TR.of(context).choose_media_description,
      actions: decideMediaActions(context),
      context: context,
      onDismissedAction: () {
        onMediaDismissedCallback();
      },
    );
  }

  Map<String, VoidCallback> decideMediaActions(BuildContext context) {
    if (mediaPickerType == MediaPickerType.VIDEO) {
      return {
        TR.of(context).record_video: onRecordVideoCallback,
      };
    } else if (mediaPickerType == MediaPickerType.BOTH) {
      return {
        TR.of(context).capture_image: onPickFromCameraCallback,
        TR.of(context).choose_from_gallery: onPickFromGalleryCallback,
        TR.of(context).record_video: onRecordVideoCallback,
        TR.of(context).choose_video_from_gallery: onChooseVideoCallabck,
      };
    } else if (mediaPickerType == MediaPickerType.CAMERA_WITH_GALLERY) {
      return {
        TR.of(context).capture_image: onPickFromCameraCallback,
        TR.of(context).choose_from_gallery: onPickFromGalleryCallback,
      };
    } else {
      return {
        TR.of(context).capture_image: onPickFromCameraCallback,
      };
    }
  }
}

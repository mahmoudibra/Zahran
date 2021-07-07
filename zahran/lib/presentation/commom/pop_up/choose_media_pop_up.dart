import 'package:flutter/material.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.pm.dart';
import 'package:zahran/presentation/commom/pop_up/pop_up.component.dart';
import 'package:zahran/presentation/localization/ext.dart';

class MediaPickerPopUp extends StatelessWidget {
  final Function onPickFromCameraCallback;
  final Function onPickFromGalleryCallback;
  final Function onRecordVideoCallback;
  final Function onChooseVideoCallabck;
  final Function onMediaDismissedCallback;
  final MediaPickerType mediaPickerType;

  MediaPickerPopUp(
      {@required this.onPickFromCameraCallback,
      @required this.onPickFromGalleryCallback,
      @required this.onRecordVideoCallback,
      @required this.onChooseVideoCallabck,
      @required this.mediaPickerType,
      @required this.onMediaDismissedCallback});

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

  Map<String, Function> decideMediaActions(BuildContext context) {
    if (mediaPickerType == MediaPickerType.VIDEO) {
      return {
        TR.of(context).record_video: onRecordVideoCallback,
      };
    } else if (mediaPickerType == MediaPickerType.CAMERA) {
      return {
        TR.of(context).capture_image: onPickFromCameraCallback,
      };
    } else if (mediaPickerType == MediaPickerType.CAMERA_WITH_GALLERY) {
      return {
        TR.of(context).capture_image: onPickFromCameraCallback,
        TR.of(context).choose_from_gallery: onPickFromGalleryCallback,
      };
    } else {
      return {
        TR.of(context).capture_image: onPickFromCameraCallback,
        TR.of(context).record_video: onRecordVideoCallback,
      };
    }
  }
}
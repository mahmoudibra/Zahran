import 'package:flutter/material.dart';
import 'package:zahran/presentation/commom/media_picker/media_picker.pm.dart';
import 'package:zahran/presentation/commom/pop_up/pop_up.component.dart';

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
      title: "Choose media", //TODO: change this later
      message: "Choose media description", //TODO: change this later
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
        'record_video': onRecordVideoCallback,
      };
    } else if (mediaPickerType == MediaPickerType.CAMERA) {
      return {
        'capture_image': onPickFromCameraCallback,
      };
    } else if (mediaPickerType == MediaPickerType.CAMERA_WITH_GALLERY) {
      return {
        'capture_image': onPickFromCameraCallback,
        'choose_from_gallery': onPickFromGalleryCallback,
      };
    } else {
      return {
        'capture_image': onPickFromCameraCallback,
        'record_video': onRecordVideoCallback,
      };
    }
  }
}

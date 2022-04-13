import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/pop_up/choose_media_pop_up.dart';
import 'package:zahran/presentation/commom/pop_up/permission_popup.component.dart';
import 'package:zahran/presentation/external/image_picker/image_picker_maneger.impl.dart';
import 'package:zahran/presentation/external/permission/permission_handler.manager.impl.dart';

import '../retry_full_screen_error.dart';
import 'media_picker.pm.dart';

typedef MediaPickerFileCallback = Future Function({
  required BuildContext context,
  required MediaLocal? mediaModel,
});

class MediaPickerComponent extends StatefulWidget {
  final MediaPickerPM _mediaPickerPM;

  final Function onMediaDismissedCallback;

  MediaPickerComponent({
    required MediaPickerType mediaPickerType,
    required MediaPickerFileCallback mediaPickerFileCallback,
    required this.onMediaDismissedCallback,
  }) : _mediaPickerPM = MediaPickerPM(
            mediaPickerManeger: MediaPickerManegerImpl(),
            permissionManager: PermissionManagerImpl(),
            mediaPickerType: mediaPickerType,
            mediaPickerFileCallback: ({
              required BuildContext context,
              required MediaLocal? mediaModel,
            }) {
              return mediaPickerFileCallback(
                  mediaModel: mediaModel, context: context);
            });

  @override
  _MediaPickerComponentState createState() => _MediaPickerComponentState();
}

class _MediaPickerComponentState extends State<MediaPickerComponent> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaPickerStatues>(
      stream: widget._mediaPickerPM.mediaPickerStream,
      initialData: MediaPickerStatues.READY,
      builder: (ctx, value) {
        if (value.hasError || (!value.hasData)) {
          return RetryFullScreenError(
            retry: () {},
          );
        } else {
          return stateRender(value.data!);
        }
      },
    );
  }

  Widget stateRender(MediaPickerStatues state) {
    Widget currentState = Container();
    switch (state) {
      case MediaPickerStatues.READY:
        showPermissionDialog();
        currentState = _buildReadyState();
        break;
      case MediaPickerStatues.PROBLEMATIC:
        currentState = RetryFullScreenError(
          retry: () {},
        );
        break;
    }
    return currentState;
  }

  Widget _buildReadyState() {
    return Builder(
      builder: (context) {
        return Container(
          child: MediaPickerPopUp(
            onPickFromCameraCallback: () async {
              widget._mediaPickerPM.captureImageFromCamera(context);
            },
            onPickFromGalleryCallback: () async {
              widget._mediaPickerPM.pickImageFromGallery(context);
            },
            onChooseVideoCallabck: () async {
              widget._mediaPickerPM.pickVideoFromGallery(context);
            },
            onRecordVideoCallback: () async {
              widget._mediaPickerPM.captureVideoFromCamera(context);
            },
            mediaPickerType: widget._mediaPickerPM.mediaPickerType,
            onMediaDismissedCallback: () {
              widget.onMediaDismissedCallback();
            },
          ),
        );
      },
    );
  }

  Future<void> showPermissionDialog() async {
    if (widget._mediaPickerPM.showPermissionDialog) {
      await Future.delayed(Duration.zero);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return _drawStateNeedGalleryPermission();
          });
    }
  }

  Widget _drawStateNeedGalleryPermission() {
    return PermissionPopUp(
      service: widget._mediaPickerPM.permissionType,
      onOpenSettings: () => {widget._mediaPickerPM.openSettings()},
      onDismiss: () => {widget._mediaPickerPM.onDismissPermissionPopUp()},
      mediaType: widget._mediaPickerPM.mediaType,
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/external/image_picker/image_picker_maneger.dart';
import 'package:zahran/presentation/external/permission/permission_handler.manager.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'MediaFileTypes.dart';
import 'media_picker.dart';

enum MediaPickerStatues { READY, PROBLEMATIC }
enum MediaPickerType { CAMERA, VIDEO, BOTH, CAMERA_WITH_GALLERY }

class MediaPickerPM {
  MediaPickerManager mediaPickerManeger;
  PermissionManager permissionManager;
  MediaPickerType mediaPickerType;
  MediaPickerFileCallback mediaPickerFileCallback;

  // Observables
  StreamController<MediaPickerStatues> _mediaPickerStateStream =
      StreamController();

  Stream<MediaPickerStatues> get mediaPickerStream =>
      _mediaPickerStateStream.stream;

  // Data
  bool showPermissionDialog = false;

  PermissionType permissionType = PermissionType.Gallery;

  MediaFileTypes mediaType = MediaFileTypes.IMAGE;

  MediaPickerPM({
    required this.mediaPickerManeger,
    required this.permissionManager,
    required this.mediaPickerType,
    required this.mediaPickerFileCallback,
  }) {
    _mediaPickerStateStream.add(MediaPickerStatues.READY);
  }

  Future<void> captureImageFromCamera(BuildContext context) async {
    permissionType = PermissionType.Camera;
    mediaType = MediaFileTypes.IMAGE;
    await permissionManager
        .checkPermission(service: permissionType)
        .then((value) => _onPhotoCameraPermissionResolved(value, context));
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    permissionType = PermissionType.Gallery;
    mediaType = MediaFileTypes.IMAGE;
    await permissionManager
        .checkPermission(service: permissionType)
        .then((value) => _onPhotoGalleryPermissionResolved(value, context));
  }

  Future<void> captureVideoFromCamera(BuildContext context) async {
    permissionType = PermissionType.Camera;
    mediaType = MediaFileTypes.VIDEO;
    await permissionManager
        .checkPermission(service: permissionType)
        .then((value) => _onVideoCameraPermissionResolved(value, context));
  }

  Future<void> pickVideoFromGallery(BuildContext context) async {
    permissionType = PermissionType.Gallery;
    mediaType = MediaFileTypes.VIDEO;
    await permissionManager
        .checkPermission(service: permissionType)
        .then((value) => _onVideoGalleryPermissionResolved(value, context));
  }

  Future<void> _onPhotoGalleryPermissionResolved(
    PermissionState permissionState,
    BuildContext context,
  ) async {
    if (permissionState == PermissionState.Granted) {
      File result = await mediaPickerManeger.pickImageFromGallery();
      await mediaPickerFileCallback(
        mediaModel: MediaLocal(
            mediaFile: result,
            mediaFileTypes: mediaType,
            fileName: path.basename(result.path)),
        context: context,
      );
      onDismissPermissionPopUp();
      print("🚀🚀🚀🚀 Change State with new result data ${result.path}");
    } else {
      _showPermissionDialog();
    }
  }

  Future<void> _onPhotoCameraPermissionResolved(
    PermissionState permissionState,
    BuildContext context,
  ) async {
    if (permissionState == PermissionState.Granted) {
      File result = await mediaPickerManeger.capturePicture();
      await mediaPickerFileCallback(
        mediaModel: MediaLocal(
            mediaFile: result,
            mediaFileTypes: mediaType,
            fileName: path.basename(result.path)),
        context: context,
      );
      onDismissPermissionPopUp();
      print("🚀🚀🚀🚀 Change State with new result data ${result.path}");
    } else {
      _showPermissionDialog();
    }
  }

  Future<void> _onVideoGalleryPermissionResolved(
      PermissionState permissionState, BuildContext context) async {
    if (permissionState == PermissionState.Granted) {
      File result = await mediaPickerManeger.pickVideoFromGallery();
      await mediaPickerFileCallback(
          mediaModel: MediaLocal(
              mediaFile: result,
              mediaFileTypes: mediaType,
              fileName: path.basename(result.path)),
          context: context);
      onDismissPermissionPopUp();
      print("🚀🚀🚀🚀 Change State with new result data ${result.path}");
    } else {
      _showPermissionDialog();
    }
  }

  Future<void> _onVideoCameraPermissionResolved(
      PermissionState permissionState, BuildContext context) async {
    if (permissionState == PermissionState.Granted) {
      File result = await mediaPickerManeger.captureVideo();
      await mediaPickerFileCallback(
        mediaModel: MediaLocal(
          mediaFile: result,
          mediaFileTypes: mediaType,
          fileName: path.basename(result.path),
        ),
        context: context,
      );
      onDismissPermissionPopUp();
      print("🚀🚀🚀🚀 Change State with new result data ${result.path}");
    } else {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showPermissionDialog = true;
    _mediaPickerStateStream.add(MediaPickerStatues.READY);
  }

  void openSettings() {
    permissionManager.openSettings();
  }

  void onDismissPermissionPopUp() {
    ScreenRouter.pop();
    showPermissionDialog = false;
    _mediaPickerStateStream.add(MediaPickerStatues.READY);
  }
}

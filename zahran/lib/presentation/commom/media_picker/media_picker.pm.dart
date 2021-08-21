import 'dart:async';
import 'dart:io';

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
  StreamController<MediaPickerStatues> _mediaPickerStateStream = StreamController();

  Stream<MediaPickerStatues> get mediaPickerStream => _mediaPickerStateStream.stream;

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

  Future<void> captureImageFromCamera() async {
    permissionType = PermissionType.Camera;
    mediaType = MediaFileTypes.IMAGE;
    await permissionManager.checkPermission(service: permissionType).then(_onPhotoCameraPermissionResolved);
  }

  Future<void> pickImageFromGallery() async {
    permissionType = PermissionType.Gallery;
    mediaType = MediaFileTypes.IMAGE;
    await permissionManager.checkPermission(service: permissionType).then(_onPhotoGalleryPermissionResolved);
  }

  Future<void> captureVideoFromCamera() async {
    permissionType = PermissionType.Camera;
    mediaType = MediaFileTypes.VIDEO;
    await permissionManager.checkPermission(service: permissionType).then(_onVideoCameraPermissionResolved);
  }

  Future<void> pickVideoFromGallery() async {
    permissionType = PermissionType.Gallery;
    mediaType = MediaFileTypes.VIDEO;
    await permissionManager.checkPermission(service: permissionType).then(_onVideoGalleryPermissionResolved);
  }

  Future<void> _onPhotoGalleryPermissionResolved(PermissionState permissionState) async {
    if (permissionState == PermissionState.Granted) {
      File result = await mediaPickerManeger.pickImageFromGallery();
      mediaPickerFileCallback(mediaModel: MediaLocal(mediaFile: result, mediaFileTypes: mediaType));
      onDismissPermissionPopUp();
      print("🚀🚀🚀🚀 Change State with new result data ${result.path}");
    } else {
      _showPermissionDialog();
    }
  }

  Future<void> _onPhotoCameraPermissionResolved(PermissionState permissionState) async {
    if (permissionState == PermissionState.Granted) {
      File result = await mediaPickerManeger.capturePicture();
      mediaPickerFileCallback(mediaModel: MediaLocal(mediaFile: result, mediaFileTypes: mediaType));
      onDismissPermissionPopUp();
      print("🚀🚀🚀🚀 Change State with new result data ${result.path}");
    } else {
      _showPermissionDialog();
    }
  }

  Future<void> _onVideoGalleryPermissionResolved(PermissionState permissionState) async {
    if (permissionState == PermissionState.Granted) {
      File result = await mediaPickerManeger.pickVideoFromGallery();
      mediaPickerFileCallback(mediaModel: MediaLocal(mediaFile: result, mediaFileTypes: mediaType));
      onDismissPermissionPopUp();
      print("🚀🚀🚀🚀 Change State with new result data ${result.path}");
    } else {
      _showPermissionDialog();
    }
  }

  Future<void> _onVideoCameraPermissionResolved(PermissionState permissionState) async {
    if (permissionState == PermissionState.Granted) {
      File result = await mediaPickerManeger.captureVideo();
      mediaPickerFileCallback(mediaModel: MediaLocal(mediaFile: result, mediaFileTypes: mediaType));
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

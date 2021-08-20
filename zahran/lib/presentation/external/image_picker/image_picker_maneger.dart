import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class MediaPickerManager {
  Future<File> pickImageFromGallery();

  Future<File> capturePicture();

  Future<File> captureVideo();

  Future<File> pickVideoFromGallery();

  Future<LostDataResponse> reteriveLostData();
}

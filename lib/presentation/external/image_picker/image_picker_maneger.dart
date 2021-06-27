import 'dart:io';

abstract class MediaPickerManager {
  Future<File> pickImageFromGallery();

  Future<File> capturePicture();

  Future<File> captureVideo();

  Future<File> pickVideoFromGallery();
}

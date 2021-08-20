import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'image_picker_maneger.dart';

class MediaPickerManegerImpl extends MediaPickerManager {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File> pickImageFromGallery() async {
    return await _getImage(ImageSource.gallery);
  }

  Future<File> capturePicture() async {
    return await _getImage(ImageSource.camera);
  }

  Future<File> _getImage(ImageSource imageSource) async {
    final pickedFile = await _imagePicker.pickImage(
      source: imageSource,
      maxWidth: 500,
      maxHeight: 500,
    );
    return File(pickedFile!.path);
  }

  Future<File> _pickVideo(ImageSource imageSource) async {
    final pickedFile = await _imagePicker.pickVideo(
      source: imageSource,
    );
    return File(pickedFile!.path);
  }

  @override
  Future<File> pickVideoFromGallery() async {
    return await _pickVideo(ImageSource.gallery);
  }

  @override
  Future<File> captureVideo() async {
    return await _pickVideo(ImageSource.camera);
  }

  @override
  Future<LostDataResponse> reteriveLostData() async {
    return await _imagePicker.retrieveLostData();
  }
}

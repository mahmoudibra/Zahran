import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class MediaRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<MediaUpload?> uploadMedia({required File uploadedFile}) async {
    var result = await post(
        path: '"/v1/mobile/upload"',
        mapItem: (json) => MediaUploadDto.fromJson(json).dtoToDomainModel(),
        formData: true,
        data: {"file": MultipartFile.fromFile(uploadedFile.path)});
    return result.data;
  }
}

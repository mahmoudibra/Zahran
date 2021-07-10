import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoHelper {
  static Future<File> getVideoThumbnailLocal(File file) async {
    var thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: file.path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 64,
      quality: 75,
    );
    return File(thumbnailPath!);
  }

  static Future<File> getVideoThumbnailRemote(String url) async {
    var thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 64,
      quality: 75,
    );
    return File(thumbnailPath!);
  }

  static Future<MediaInfo> compressVideo(File file) async {
    await VideoCompress.setLogLevel(0);
    return (await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.LowQuality,
      deleteOrigin: false,
      includeAudio: true,
    ))!;
  }
}

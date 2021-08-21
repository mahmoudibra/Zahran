part of 'models.dart';

class MediaLocal {
  MediaFileTypes mediaFileTypes;
  File? videoThumbnail;
  File mediaFile;

  MediaLocal({required this.mediaFile, required this.mediaFileTypes});

  Future<void> extractVideoThumbnail() async {
    if (mediaFileTypes.value == MediaFileTypes.VIDEO.value) {
      videoThumbnail = await VideoHelper.getVideoThumbnailLocal(mediaFile);
    }
  }

  Future<void> compressVideo() async {
    if (mediaFileTypes.value == MediaFileTypes.VIDEO.value) {
      var fileSize = await mediaFile.length();
      print("🚀🚀🚀🚀🚀 size before compress: $fileSize");
      MediaInfo info = await VideoHelper.compressVideo(mediaFile);
      mediaFile = info.file!;
      var fileSizeCompresed = await mediaFile.length();
      print("🚀🚀🚀🚀🚀 size after compress: $fileSizeCompresed");
    }
  }

  factory MediaLocal.fromJson(Map<String, dynamic> json, {String? tmpDirectory}) {
    MediaFileTypes mediaFileTypes;
    File? mediaFile;
    if (json['mediaFileTypes'] != null) {
      mediaFileTypes = MediaFileTypes(json['mediaFileTypes']);
    } else {
      mediaFileTypes = MediaFileTypes.IMAGE;
    }
    if (json['mediaFile'] != null) {
      print("🚀🚀🚀🚀🚀 Media File Type HashCode: ${mediaFileTypes.hashCode}");
      if (mediaFileTypes.value == MediaFileTypes.IMAGE.value) {
        mediaFile = File('$tmpDirectory/media-file-${mediaFileTypes.hashCode}.jpg');
      } else if (mediaFileTypes.value == MediaFileTypes.VIDEO.value) {
        mediaFile = File('$tmpDirectory/media-file-${mediaFileTypes.hashCode}.mp4');
      } else if (mediaFileTypes.value == MediaFileTypes.AUDIO.value) {
        mediaFile = File('$tmpDirectory/media-file-${mediaFileTypes.hashCode}.mp3');
      }
      mediaFile!.writeAsBytesSync(List<int>.from(json['mediaFile']));
    }
    return MediaLocal(mediaFile: mediaFile!, mediaFileTypes: mediaFileTypes);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['mediaFileTypes'] = this.mediaFileTypes.value;

    data['mediaFile'] = this.mediaFile.readAsBytesSync();

    return data;
  }

  @override
  String toString() {
    return "mediaFile: $mediaFile, mediaFileTypes: ${mediaFileTypes.value} ";
  }
}

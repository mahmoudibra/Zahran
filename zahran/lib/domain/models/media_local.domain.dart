part of 'models.dart';

class MediaLocal {
  MediaFileTypes mediaFileTypes;
  File? videoThumbnail;
  File mediaFile;
  String fileName;

  MediaLocal(
      {required this.mediaFile,
      required this.mediaFileTypes,
      required this.fileName});

  Future<void> extractVideoThumbnailFromFile() async {
    if (mediaFileTypes.value == MediaFileTypes.VIDEO.value) {
      videoThumbnail = await VideoHelper.getVideoThumbnailLocal(mediaFile);
    }
  }

  Future<T> compressAndUpload<T>({
    required ValueNotifier<double?>? notifier,
    required Future<T> Function(File file, ValueChanged<double> onProgress)
        upload,
  }) async {
    File? file;
    notifier?.value = 0.15;
    if (mediaFileTypes.value == MediaFileTypes.VIDEO.value) {
      MediaInfo info = await VideoHelper.compressVideo(mediaFile, (v) {
        notifier?.value = Tween(begin: 0.15, end: 0.3).transform(v);
      });
      file = info.file;
    } else if (mediaFileTypes.value == MediaFileTypes.IMAGE.value) {
      String _path = await _generateTempDirectory(fileName);
      print("🚀🚀🚀🚀🚀 path: $_path and mediaPath: ${mediaFile.path}");
      file = await FlutterImageCompress.compressAndGetFile(
        mediaFile.path,
        _path,
        minWidth: 2300,
        minHeight: 1500,
        quality: 94,
        format: _decideCompressionType(fileName)
      );
    }

    notifier?.value = 0.35;
    return await upload(file ?? mediaFile, (v) {
      notifier?.value = Tween(begin: 0.4, end: 1.0).transform(v);
    });
  }

  CompressFormat _decideCompressionType(String fileName) {
    if(fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
      return CompressFormat.jpeg;
    } else if(fileName.endsWith(".png")) {
      return CompressFormat.png;
    } else if (fileName.endsWith(".heic")) {
      return CompressFormat.heic;
    } else if (fileName.endsWith(".webp")) {
      return CompressFormat.webp;
    } else {
      return CompressFormat.jpeg;
    }
  }

  Future<String> _generateTempDirectory(String fileName) async {
    var tempDirectory = await getTemporaryDirectory();
    if (Platform.isAndroid) {
      return tempDirectory.path + '/temporary/$fileName';
    } else {
      return tempDirectory.path + '/$fileName';
    }
  }

  factory MediaLocal.fromJson(Map<String, dynamic> json,
      {String? tmpDirectory}) {
    late MediaFileTypes mediaFileTypes;
    late File mediaFile;
    late String fileName;
    if (json['mediaFileTypes'] != null) {
      mediaFileTypes = MediaFileTypes(json['mediaFileTypes']);
    } else {
      mediaFileTypes = MediaFileTypes.IMAGE;
    }
    if (json['mediaFile'] != null) {
      print("🚀🚀🚀🚀🚀 Media File Type HashCode: ${mediaFileTypes.hashCode}");
      if (mediaFileTypes.value == MediaFileTypes.IMAGE.value) {
        mediaFile =
            File('$tmpDirectory/media-file-${mediaFileTypes.hashCode}.jpg');
      } else if (mediaFileTypes.value == MediaFileTypes.VIDEO.value) {
        mediaFile =
            File('$tmpDirectory/media-file-${mediaFileTypes.hashCode}.mp4');
      } else if (mediaFileTypes.value == MediaFileTypes.AUDIO.value) {
        mediaFile =
            File('$tmpDirectory/media-file-${mediaFileTypes.hashCode}.mp3');
      } else {
        mediaFile = File('$tmpDirectory/media-file-${mediaFileTypes.hashCode}');
      }
      mediaFile.writeAsBytesSync(List<int>.from(json['mediaFile']));
    }
    fileName = json['mediaFileName'] ?? path.basename(mediaFile.path);

    return MediaLocal(
        mediaFile: mediaFile,
        mediaFileTypes: mediaFileTypes,
        fileName: fileName);
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

part of 'models.dart';

@HiveType(typeId: 0)
class Media {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String mediaPath;
  @HiveField(2)
  final String? type;

  Media({required this.id, required this.mediaPath, required this.type});

  @override
  String toString() {
    return '''Document( 
    id: $id,
    mediaPath: $mediaPath,
    type: $type,
    ''';
  }

  Future<File?> extractVideoThumbnailFromRemote() async {
    if (type == MediaFileTypes.VIDEO.value) {
      return await VideoHelper.getVideoThumbnailRemote(mediaPath);
    }
    return null;
  }

  factory Media.fromMediaUpload(MediaUpload mediaUpload, String type) {
    return Media(id: mediaUpload.id, mediaPath: mediaUpload.path, type: type);
  }
}

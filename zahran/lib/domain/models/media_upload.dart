part of 'models.dart';

@HiveType(typeId: 0)
class MediaUpload extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String path;

  MediaUpload({required this.id, required this.path});

  @override
  String toString() {
    return '''Document( 
    id: $id,
    path: $path
    ''';
  }
}

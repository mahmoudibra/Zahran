part of 'models.dart';

class MediaUpload {
  final int id;
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

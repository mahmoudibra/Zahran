part of 'domain_mapper.dart';

class MediaUploadDto implements DtoToDomainMapper<MediaUpload> {
  int? id;
  String? path;

  MediaUploadDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    return data;
  }

  @override
  String toString() {
    return '''Document( 
    id: $id,
    path: $path
    ''';
  }

  @override
  MediaUpload dtoToDomainModel() {
    return MediaUpload(id: id!, path: path ?? "");
  }
}

part of 'domain_mapper.dart';

class MediaDto extends DtoToDomainMapper<Media> {
  int? id;
  String? mediaPath;
  String? type;

  MediaDto({required this.id, required this.mediaPath, required this.type});

  MediaDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaPath = json['media_path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['media_path'] = this.mediaPath;
    data['type'] = this.type;
    return data;
  }

  @override
  Media dtoToDomainModel() {
    return Media(id: id!, mediaPath: mediaPath!, type: type ?? MediaFileTypes.IMAGE.value);
  }
}

part of 'models.dart';

@HiveType(typeId: 5)
class CommentModel extends HiveObject {
  CommentModel({
    this.comment = '',
    List<MediaUpload>? media,
  }) : media = media ?? List.empty(growable: true);
  @HiveField(0)
  String comment;
  @HiveField(1)
  List<MediaUpload> media;

  CommentModel copyWith({
    String? comment,
    List<MediaUpload> Function(List<MediaUpload> old)? media,
  }) =>
      CommentModel(
        comment: comment ?? this.comment,
        media: media?.call(this.media) ?? this.media,
      );
}

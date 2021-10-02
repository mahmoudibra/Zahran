part of 'models.dart';

@HiveType(typeId: 43)
class CommentModel extends HiveObject {
  CommentModel({
    this.comment = '',
    List<Media>? media,
  }) : media = media ?? List.empty(growable: true);
  @HiveField(0)
  String comment;
  @HiveField(1)
  List<Media> media;

  CommentModel copyWith({
    String? comment,
    List<Media> Function(List<Media> old)? media,
  }) =>
      CommentModel(
        comment: comment ?? this.comment,
        media: media?.call(this.media) ?? this.media,
      );
}

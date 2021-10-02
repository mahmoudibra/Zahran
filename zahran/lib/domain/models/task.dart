part of 'models.dart';

class TaskModel {
  int? visitId;
  final int id;
  final bool status;
  final bool isCompleted;
  final LocalizedName title;
  final LocalizedName description;
  final LocalizedName instructions;
  final List<BrandModel> brands;
  final List<Question> questions;
  final List<Media> media;
  factory TaskModel.empty(BuildContext context, int i) {
    return TaskModel(
      status: i.isEven,
      media: [],
      isCompleted: i.isEven,
      title: LocalizedName.name(TR.of(context).title),
      description: LocalizedName.name(TR.of(context).task_description),
      instructions: LocalizedName.name(TR.of(context).instructions),
      brands: [],
      id: 0,
      questions: [],
    );
  }
  TaskModel({
    required this.status,
    required this.media,
    required this.isCompleted,
    required this.title,
    required this.description,
    required this.instructions,
    required this.brands,
    required this.id,
    required this.questions,
  });

  TaskModel copyWith({
    bool? status,
    List<Media>? media,
    bool? isCompleted,
    LocalizedName? title,
    LocalizedName? description,
    LocalizedName? instructions,
    List<BrandModel>? brands,
    List<Question>? questions,
  }) {
    return TaskModel(
      status: status ?? this.status,
      media: media ?? this.media,
      isCompleted: isCompleted ?? this.isCompleted,
      title: title ?? this.title,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      brands: brands ?? this.brands,
      questions: questions ?? this.questions,
      id: id,
    );
  }
}

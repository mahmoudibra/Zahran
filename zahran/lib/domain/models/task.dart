part of 'models.dart';

class TaskModel {
  int? visitId;
  final int id;
  final bool status;
  final String media;
  final bool isCompleted;
  final LocalizedName title;
  final LocalizedName description;
  final LocalizedName instructions;
  final List<BrandModel> brands;

  TaskModel({
    required this.status,
    required this.media,
    required this.isCompleted,
    required this.title,
    required this.description,
    required this.instructions,
    required this.brands,
    required this.id,
  });
}

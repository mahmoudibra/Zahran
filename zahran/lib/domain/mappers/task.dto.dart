part of 'domain_mapper.dart';

class TaskDto implements DtoToDomainMapper<TaskModel> {
  int? id;
  bool? status;
  String? media;
  bool? isCompleted;
  LocalizedNameDto? title;
  LocalizedNameDto? description;
  LocalizedNameDto? instructions;
  List<BrandDto>? brands;
  TaskDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = LocalizedNameDto.fromJson(json["title"] ?? {});
    description = LocalizedNameDto.fromJson(json["description"] ?? {});
    instructions = LocalizedNameDto.fromJson(json["instructions"] ?? {});
    brands =
        (json["brands"] as List?)?.map((e) => BrandDto.fromJson(e)).toList() ??
            [];
    status = json["status"] == true;
    isCompleted = json["is_completed"] == true;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status": status,
      "title": title?.tojson(),
      "is_completed": isCompleted,
      "description": description?.tojson(),
      "instructions": instructions?.tojson(),
      "brands": brands?.map((e) => e.toJson()).toList(),
      "media": media
    };
  }

  @override
  TaskModel dtoToDomainModel() {
    return TaskModel(
      id: id!,
      title: title?.dtoToDomainModel() ?? LocalizedName(),
      description: title?.dtoToDomainModel() ?? LocalizedName(),
      instructions: title?.dtoToDomainModel() ?? LocalizedName(),
      isCompleted: isCompleted ?? false,
      status: status ?? true,
      brands: (brands ?? []).map((e) => e.dtoToDomainModel()).toList(),
      media: media ?? "",
    );
  }
}

part of 'domain_mapper.dart';

class QuestionDto implements DtoToDomainMapper<Question> {
  int? id;
  String? taskID;
  String? answerType;
  bool? mandatory;
  LocalizedNameDto? question;
  List<OptionDto>? options;

  QuestionDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskID = json['task_id'];
    answerType = json['answer_type'];
    mandatory = json['mandatory'];
    question = LocalizedNameDto.fromJson(json['question'] ?? {});
    options = (json["options"] as List?)?.map((e) => OptionDto.fromJson(e)).toList() ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "task_id": taskID,
      "answer_type": answerType,
      "mandatory": mandatory,
      "question": question?.tojson(),
      "options": options?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  Question dtoToDomainModel() {
    return Question(
      id: id!,
      taskId: taskID!,
      answerType: answerType ?? QuestionTypes.TEXT.value,
      mandatory: mandatory ?? false,
      question: question?.dtoToDomainModel() ?? LocalizedName(),
      options: (options ?? []).map((e) => e.dtoToDomainModel()).toList(),
    );
  }
}

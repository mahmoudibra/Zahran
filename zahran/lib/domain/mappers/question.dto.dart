part of 'domain_mapper.dart';

class QuestionDto implements DtoToDomainMapper<Question> {
  int? id;
  String? taskID;
  String? answerType;
  bool? mandatory;
  LocalizedNameDto? question;

  QuestionDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskID = json['task_id'];
    answerType = json['answer_type'];
    mandatory = json['mandatory'];
    question = LocalizedNameDto.fromJson(json['question'] ?? {});
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "task_id": taskID,
      "answer_type": answerType,
      "mandatory": mandatory,
      "question": question?.tojson(),
    };
  }

  @override
  Question dtoToDomainModel() {
    return Question(
        id: id!,
        taskId: taskID!,
        answerType: answerType ?? QuestionTypes.TEXT.value,
        mandatory: mandatory ?? false,
        question: question?.dtoToDomainModel() ?? LocalizedName());
  }
}

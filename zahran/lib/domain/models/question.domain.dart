part of 'models.dart';

class Question {
  int id;
  int taskId;
  String answerType;
  bool mandatory;
  LocalizedName question;

  List<Option>? options;

  // answers
  String answerText = "";

  // selected multimedia for question from type media only
  List<MediaLocal> selectedMultimedia = [];

  List<int> answerMediaList = []; // id that reflect selected mulimedia

  Question(
      {required this.id,
      required this.taskId,
      required this.answerType,
      required this.mandatory,
      required this.question});

  @override
  String toString() {
    return '''QuestionModel( 
    id: $id, 
    taskId: $taskId, 
    answerType: $answerType, 
    mandatory: $mandatory, 
    question: $question, 
    options: $options, 
    answerText: $answerText, 
    selectedMultimedia: $selectedMultimedia, 
    answerMediaList: $answerMediaList, 
    )''';
  }
}

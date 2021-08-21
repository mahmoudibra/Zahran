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
  List<Question>? questions;

  TaskModel({
    required this.status,
    required this.media,
    required this.isCompleted,
    required this.title,
    required this.description,
    required this.instructions,
    required this.brands,
    required this.id,
  }) {
    _prepareTestQuestion();
  }

  _prepareTestQuestion() {
    var questionOne = Question(
        id: 200,
        taskId: 300,
        answerType: QuestionTypes.TEXT.value,
        mandatory: true,
        question: LocalizedName(ar: "7a7a", en: "en 7a7a"));

    var questionTwo = Question(
        id: 400,
        taskId: 300,
        answerType: QuestionTypes.DATE.value,
        mandatory: true,
        question: LocalizedName(ar: "What is your birth date", en: "What is your birth date"));

    var questionThree = Question(
        id: 400,
        taskId: 300,
        answerType: QuestionTypes.NUMBER.value,
        mandatory: true,
        question: LocalizedName(ar: "What is your phone number", en: "What is your phone number"));

    var questionFour = Question(
        id: 400,
        taskId: 300,
        answerType: QuestionTypes.MEDIA.value,
        mandatory: true,
        question: LocalizedName(ar: "What is your home pictures ?", en: "What is your home pictures ?"));

    var questionFive = Question(
        id: 400,
        taskId: 300,
        answerType: QuestionTypes.SELECT.value,
        mandatory: true,
        question: LocalizedName(ar: "What is your home pictures ?", en: "What is your home pictures ?"));

    questionFive.options = [
      Option(id: 1, value: "one"),
      Option(id: 2, value: "two"),
      Option(id: 3, value: "three"),
      Option(id: 4, value: "four")
    ];

    questions = [questionOne, questionTwo, questionThree, questionFour, questionFive];
  }
}

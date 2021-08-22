import 'package:flutter/material.dart';
import 'package:zahran/data/base/base_api_request.dart';
import 'package:zahran/domain/models/empty_model.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/domain/models/question_types.enum.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class QuestionRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<EmptyModel?> answerTaskQuestions(int taskId, List<AnswerRequest> answerList) async {
    var allAnswerAsJson = answerList.map((e) => e.toJson()).toList();
    var request = {"answer": allAnswerAsJson};
    print("Is heeeeeeereeeeeeee\n $request");
    var result = await this.post(
      path: '/v1/mobile/tasks/$taskId/answers',
      data: request,
      mapItem: (json) => EmptyModel(),
    );
    return result.data;
  }
}

class AnswerRequest extends RequestMappable {
  int questionID;
  String? answer;
  int? optionId;
  List<int>? media;
  QuestionTypes questionTypes;

  AnswerRequest({required this.questionID, required this.questionTypes, this.answer, this.optionId, this.media});

  factory AnswerRequest.fromQuestionModel(Question question) {
    return AnswerRequest(
        questionID: question.id,
        questionTypes: QuestionTypes(question.answerType),
        answer: question.answerText,
        optionId: question.selectedOptionId,
        media: question.answerMediaList);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionID;
    if (this.questionTypes.value == QuestionTypes.MEDIA.value) {
      data['media'] = this.media;
    } else if (this.questionTypes.value == QuestionTypes.SELECT.value) {
      data['option_id'] = this.optionId;
    } else {
      data['answer'] = this.answer;
    }
    return data;
  }
}

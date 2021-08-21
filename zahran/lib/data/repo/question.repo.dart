import 'package:flutter/material.dart';
import 'package:zahran/data/base/base_api_request.dart';
import 'package:zahran/domain/models/empty_model.dart';
import 'package:zahran/domain/models/question_types.enum.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

import 'base.repo.dart';

class QuestionRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext!;

  Future<EmptyModel?> answerTaskQuestions(int taskId, List<AnswerRequest> answerList) async {
    //TODO: edit later
    var allAnswerAsJson = answerList.map((e) => e.toJson()).toList();
    var result = await this.post(
      path: '/v1/mobile/tasks/$taskId/answers',
      data: {},
      mapItem: (json) => EmptyModel(),
    );
    return result.data;
  }
}

class AnswerRequest extends RequestMappable {
  int questionID;
  String? answer;
  int? optionId;
  List<int>? mediaIds;
  QuestionTypes questionTypes;

  AnswerRequest({required this.questionID, required this.questionTypes, this.answer, this.optionId, this.mediaIds});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionID;
    if (this.questionTypes.value == QuestionTypes.MEDIA.value) {
      data['media_ids'] = this.mediaIds;
    } else if (this.questionTypes.value == QuestionTypes.SELECT.value) {
      data['option'] = this.optionId;
    } else {
      data['answer'] = this.answer;
    }
    return data;
  }
}

import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/base_details_view_model.dart';

class TaskDetailsViewModel extends BaseDetailsViewModel<TaskModel> {
  final BuildContext context;
  Promotion promotion = Promotion.empty();

  TaskDetailsViewModel(this.context) : super(context);

  @override
  void onReady() {
    super.onReady();
  }
}

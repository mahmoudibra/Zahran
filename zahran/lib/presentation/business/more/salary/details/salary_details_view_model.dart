import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/business/base/base_details_view_model.dart';

class SalaryDetailsViewModel extends BaseDetailsViewModel<SalaryModel> {
  SalaryDetailsViewModel(BuildContext context) : super(context);

  @override
  Future<SalaryModel> fetchDetails() async {
    //TODO
    return model;
  }
}

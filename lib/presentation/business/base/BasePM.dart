import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:zahran/presentation/exceptions/api_exceptions.dart';

class ErrorModel {
  String errorMessage;
  bool isLocalError;
  Function retry;
  Function dismiss;

  ErrorModel({this.errorMessage, this.retry, this.dismiss, this.isLocalError = false});

  factory ErrorModel.copyWith({String errorMessage, Function retry, Function dismiss, bool isLocalError}) {
    return ErrorModel(errorMessage: errorMessage, retry: retry, dismiss: dismiss, isLocalError: isLocalError);
  }
}

abstract class BasePM {
  Function retry;

  @protected
  StreamController<ErrorModel> errorStream = StreamController();

  Stream<ErrorModel> get errorStatesStream => errorStream.stream;

  bool isLoading = false;

  @protected
  void dispose() {
    errorStream.close();
  }

  void dismiss();

  @protected
  void catchException(errorPayload) {
    print("🐜🐜🐜🐜 Print Error in Base pm $errorPayload 🐜🐜🐜");
    isLoading = false;
    if (errorPayload is BackEndException) {
      errorStream.add(
          ErrorModel.copyWith(errorMessage: errorPayload.message, retry: retry, dismiss: dismiss, isLocalError: false));
    } else {
      errorStream.add(ErrorModel(retry: retry, dismiss: dismiss, isLocalError: false));
    }
  }
}

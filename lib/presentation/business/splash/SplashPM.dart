import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/base/BasePM.dart';
import 'package:zahran/presentation/navigation/named-navigator.dart';

enum SplashStates { INITIAL }

class SplashPM extends BasePM {
  // Dependence's
  NamedNavigator navigator;

  // retry
  Function retry;

  // Stream
  StreamController<SplashStates> _splashStream = StreamController();

  Stream<SplashStates> get splashStatesStream => _splashStream.stream;

  // init
  SplashPM({@required this.navigator});

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 3));
    // await localNotification.initialize();
    // firebaseMessagingManager.initialize();
    await checkAppFirstLogin();
  }

  Future<void> checkAppFirstLogin() async {}

  @override
  void dismiss() {
    navigator.pop();
  }

  @override
  void dispose() {
    super.dispose();
    _splashStream.close();
  }
}

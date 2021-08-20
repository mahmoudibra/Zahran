import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/base/auth_view_model.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class SplashViewModel extends GetxController {
  final TickerProvider vsync;
  late AnimationController _controller;
  late Animation<double> _colorAnimation;
  late Animation<double> _imageAnimation;
  late Animation<double> _loaderAnimation;
  SplashViewModel(this.vsync);
  AnimationController get controller => _controller;
  Animation<double> get colorAnimation => _colorAnimation;
  Animation<double> get imageAnimation => _imageAnimation;
  Animation<double> get loaderAnimation => _loaderAnimation;
  Duration get duration => Duration(seconds: 2);

  Future checkFirstLogin() async {}

  void navigate() {
    var auth = Get.find<AuthViewModel>();
    // ScreenNames.VIDEO_PREVIEW
    //     .pushReplacementNamed(arguments: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4");

    if (auth.authenticated) {
      ScreenNames.HOME.pushReplacementNamed();
    } else {
      ScreenNames.LOGIN.pushReplacementNamed();
    }
  }

  @override
  void onInit() async {
    _controller = AnimationController(vsync: vsync, duration: duration);
    _colorAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.0, 0.3, curve: Curves.easeInCubic)));
    _imageAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.3, 0.8, curve: Curves.easeInCubic),
    ));
    _loaderAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.3, 0.5, curve: Curves.easeInCubic),
    ));
    _controller.animateTo(0.3);
    await checkFirstLogin();
    _controller.animateTo(1.0).then((value) => navigate());
    super.onInit();
  }
}

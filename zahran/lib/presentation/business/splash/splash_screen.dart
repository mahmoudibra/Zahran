import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/business/splash/view_model.dart';
import 'package:zahran/presentation/commom/app_loader.dart';
import 'package:zahran/presentation/commom/gradient_container.dart';
import 'package:zahran/r.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashStates createState() => _SplashStates();
}

class _SplashStates extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashViewModel>(
      init: SplashViewModel(this),
      builder: (SplashViewModel _) {
        return AnimatedBuilder(
          animation: _.controller,
          builder: (ctx, w) {
            var colorAlpha = _.colorAnimation.value;
            var imageanimation = _.imageAnimation.value;
            var loaderAnimation = _.imageAnimation.value;
            return Stack(
              fit: StackFit.expand,
              children: [
                GradientContainer(
                  alpha: colorAlpha,
                  padding: EdgeInsets.all(30),
                  child: Opacity(
                    opacity: imageanimation,
                    child: Center(
                      child: Transform(
                        transform: Matrix4.rotationY(pi - pi * imageanimation),
                        alignment: Alignment.center,
                        child: Transform.scale(
                          scale: imageanimation,
                          child: Image.asset(R.assetsImgsLogo),
                        ),
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 1.0 - (loaderAnimation < 1 ? loaderAnimation : 1.0),
                  child: AppLoader(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

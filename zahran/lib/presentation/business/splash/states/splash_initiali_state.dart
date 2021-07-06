import 'package:flutter/material.dart';
import 'package:zahran/presentation/config/configs.dart';

class SplashPageInitialState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Image.asset(GeneralConfigs.IMAGE_ASSETS_PATH + "app-logo.png"),
      ),
    );
  }
}

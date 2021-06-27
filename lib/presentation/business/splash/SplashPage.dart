import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/splash/SplashPM.dart';
import 'package:zahran/presentation/business/splash/states/splash_initiali_state.dart';
import 'package:zahran/presentation/commom/app_loader.dart';
import 'package:zahran/presentation/navigation/named_navigator_impl.dart';

class SplashPage extends StatefulWidget {
  final SplashPM splashPM = SplashPM(navigator: NamedNavigatorImpl());

  @override
  _SplashStates createState() => _SplashStates();
}

class _SplashStates extends State<SplashPage> {
  @override
  void initState() {
    widget.splashPM.errorStatesStream.listen((errorPayload) {
      setState(() {});
      //TODO: error message UI
      // ViewsToolbox.showErrorDialog(context, errorPayload);
    });
    widget.splashPM.initialize();
    super.initState();
  }

  @override
  void dispose() {
    widget.splashPM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SplashStates>(
      stream: widget.splashPM.splashStatesStream,
      initialData: SplashStates.INITIAL,
      builder: (ctx, value) {
        return Stack(
          children: <Widget>[
            stateRender(value.data),
            if (widget.splashPM.isLoading) AppLoader(),
          ],
        );
      },
    );
  }

  Widget stateRender(SplashStates state) {
    Widget currentState = Container();
    switch (state) {
      case SplashStates.INITIAL:
        currentState = SplashPageInitialState();
        break;
    }
    return currentState;
  }
}

part of helpers;

class _Dismiss extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const _Dismiss({Key? key, required this.child, required this.duration})
      : super(key: key);
  @override
  __DismissState createState() => __DismissState();
}

class __DismissState extends State<_Dismiss> {
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration).then((value) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _Observer extends NavigatorObserver {
  Route? currentRoute;
  bool get isPopupRout => currentRoute != null && currentRoute is PopupRoute;
  bool get isDialog => currentRoute != null && currentRoute is DialogRoute;
  @override
  void didPop(Route route, Route? previousRoute) {
    currentRoute = previousRoute;
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    currentRoute = route;
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    currentRoute = previousRoute;
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    currentRoute = newRoute;
  }
}

extension SnackBarExtention on BuildContext {
  static final _observer = _Observer();
  _Observer get snackBarObserver => SnackBarExtention._observer;
  void waitDialog(Function callBack) {
    if (snackBarObserver.isDialog) {
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        waitDialog(callBack);
      });
    } else {
      callBack();
    }
  }

  void showSnackBar(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
    Animation<double>? animation,
    VoidCallback? onVisible,
    bool? modalSheet,
    bool waitDialogToPop = true,
  }) {
    var _modalSheet = modalSheet ?? SnackBarExtention._observer.isPopupRout;
    var fn = () {
      if (_modalSheet) {
        showModalBottomSheet(
          context: this,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (ctx) => _Dismiss(
            duration: duration,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    color: backgroundColor,
                    shape: shape,
                    elevation: elevation,
                    margin: margin ?? EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: padding ?? const EdgeInsets.all(15),
                            child: Text(
                              message,
                              style: TextStyle(color: textColor),
                              textAlign: action == null
                                  ? TextAlign.center
                                  : TextAlign.start,
                            ),
                          ),
                        ),
                        if (action != null)
                          TextButton(
                            style:
                                TextButton.styleFrom(primary: action.textColor),
                            onPressed: action.onPressed,
                            child: Text(action.label),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        if (onVisible != null) onVisible();
      } else {
        var manager = ScaffoldMessenger.maybeOf(this);
        manager?.showSnackBar(SnackBar(
          content: Text(
            message,
            style: TextStyle(color: textColor),
            textAlign: action == null ? TextAlign.center : TextAlign.start,
          ),
          backgroundColor: backgroundColor,
          elevation: elevation,
          margin: margin,
          padding: padding,
          width: width,
          shape: shape,
          behavior: behavior,
          action: action,
          duration: duration,
          animation: animation,
          onVisible: onVisible,
        ));
      }
    };
    if (waitDialogToPop) {
      waitDialog(fn);
    } else {
      fn();
    }
  }

  void errorSnackBar(
    String message, {
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
    Animation<double>? animation,
    VoidCallback? onVisible,
    bool? modalSheet,
    bool waitDialogToPop = true,
  }) {
    showSnackBar(
      message,
      backgroundColor: Theme.of(this).colorScheme.error,
      textColor: Theme.of(this).colorScheme.onError,
      elevation: elevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: shape,
      behavior: behavior,
      action: action,
      duration: duration,
      animation: animation,
      onVisible: onVisible,
      modalSheet: modalSheet,
      waitDialogToPop: waitDialogToPop,
    );
  }

  void primarySnackBar(
    String message, {
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
    Animation<double>? animation,
    VoidCallback? onVisible,
    bool? modalSheet,
    bool waitDialogToPop = true,
  }) {
    showSnackBar(
      message,
      backgroundColor: Theme.of(this).colorScheme.primary,
      textColor: Theme.of(this).colorScheme.onPrimary,
      elevation: elevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: shape,
      behavior: behavior,
      action: action,
      duration: duration,
      animation: animation,
      onVisible: onVisible,
      modalSheet: modalSheet,
      waitDialogToPop: waitDialogToPop,
    );
  }

  void accentSnackBar(
    String message, {
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
    Animation<double>? animation,
    VoidCallback? onVisible,
    bool? modalSheet,
    bool waitDialogToPop = true,
  }) {
    showSnackBar(
      message,
      backgroundColor: Theme.of(this).colorScheme.secondary,
      textColor: Theme.of(this).colorScheme.onSecondary,
      elevation: elevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: shape,
      behavior: behavior,
      action: action,
      duration: duration,
      animation: animation,
      onVisible: onVisible,
      modalSheet: modalSheet,
      waitDialogToPop: waitDialogToPop,
    );
  }
}

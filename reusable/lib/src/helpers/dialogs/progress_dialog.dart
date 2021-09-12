part of helpers;

typedef ProgressDialogInitializer<TModel> = Future<TModel> Function(
    Function(double v) onNewValue);

typedef ProgressDialogBuilder = Widget Function(double currentvalue);

class ProgressDialog<TModel> extends StatefulWidget {
  final ProgressDialogBuilder? build;
  final ProgressDialogInitializer<TModel> action;
  const ProgressDialog({
    Key? key,
    required this.build,
    required this.action,
  }) : super(key: key);
  @override
  _ProgressDialogState<TModel> createState() => _ProgressDialogState<TModel>();
}

class _ProgressDialogState<TModel> extends State<ProgressDialog<TModel>> {
  double progress = 0;
  @override
  void initState() {
    super.initState();
    widget.action((v) {
      setState(() {
        progress = v;
      });
    }).then((data) {
      Navigator.of(context).pop(data);
    }).catchError((e) {
      Navigator.of(context).pop(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: widget.build == null
              ? _defaultProgress()
              : widget.build!(progress),
        ),
      ),
    );
  }

  Widget _defaultProgress() {
    return CircularPercentIndicator(
      radius: 100,
      lineWidth: 5,
      animateFromLastPercent: true,
      animation: true,
      arcType: ArcType.FULL,
      backgroundColor: Theme.of(context).backgroundColor,
      circularStrokeCap: CircularStrokeCap.round,
      percent: progress,
      arcBackgroundColor: DefaultTextStyle.of(context).style.color,
      progressColor: Theme.of(context).colorScheme.secondary,
    );
  }

  Future<T> showProgressDialog<T>({
    required BuildContext context,
    required ProgressDialogInitializer<T> action,
    ProgressDialogBuilder? build,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: ProgressDialog<T>(
              action: action,
              build: build,
            ),
          );
        }).then((value) {
      if (value is T) {
        return value;
      } else {
        throw value;
      }
    });
  }
}

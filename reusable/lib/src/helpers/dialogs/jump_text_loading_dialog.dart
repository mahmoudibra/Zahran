part of helpers;

class JumpingText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final TextDirection? direction;
  final Offset beginTweenValue = Offset.zero;
  final Offset endTweenValue;
  const JumpingText({
    Key? key,
    this.text = '',
    this.textStyle,
    this.direction,
    this.endTweenValue = const Offset(0.0, -1.0),
  }) : super(key: key);
  @override
  _JumpingTextState createState() => _JumpingTextState(text, textStyle);
}

class _JumpingTextState extends State<JumpingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Text> children;
  _JumpingTextState(String text, TextStyle? style) {
    children = text.runes
        .map((r) => Text(
              String.fromCharCode(r),
              style: style,
            ))
        .toList();
  }
  final animations = <Animation>[];
  List<WidgetAnimations<Offset>> _widgets = [];
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: (children.length * 0.25).round()),
    );
    _widgets = WidgetAnimations.createList<Offset>(
      widgets: children,
      controller: _controller,
      forwardCurve: Curves.ease,
      reverseCurve: Curves.ease,
      begin: widget.beginTweenValue,
      end: widget.endTweenValue,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final end = widget.endTweenValue;
    return Row(
      textDirection: widget.direction,
      mainAxisSize: MainAxisSize.min,
      children: _widgets.map(
        (widgetAnimation) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _widget) {
              return FractionalTranslation(
                translation: widgetAnimation.forward.value.distanceSquared >=
                        end.distanceSquared
                    ? widgetAnimation.reverse.value
                    : widgetAnimation.forward.value,
                child: widgetAnimation.widget,
              );
            },
          );
        },
      ).toList(),
    );
  }
}

Future<T> showJumpingTextDialog<T>({
  required BuildContext context,
  required Future<T> action,
  TextDirection? direction,
  String? text,
}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 75,
                child: Center(
                  child: JumpingText(
                    direction: direction ?? TextDirection.ltr,
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    text: text ?? 'Loading please wait ...',
                  ),
                ),
              ),
            ),
          ),
        );
      });
  return action.then((data) {
    Navigator.of(context).pop();
    return data;
  }).catchError((e) {
    Navigator.of(context).pop();
    throw e;
  });
}

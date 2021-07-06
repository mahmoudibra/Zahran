part of complete_list;

class CompleteListConfig extends StatefulWidget {
  final Color? color;
  final double spaceBetweenIconAndText;
  final double spaceBetweenTextAndButton;
  final TextStyle? style;
  final Widget child;
  final ListPlaceHolder placeholder;

  const CompleteListConfig({
    Key? key,
    this.color,
    this.style,
    this.spaceBetweenIconAndText = 10,
    this.spaceBetweenTextAndButton = 5,
    required this.child,
    this.placeholder = const ListPlaceHolder(),
  }) : super(key: key);

  @override
  _CompleteListConfigState createState() => _CompleteListConfigState();

  static _CompleteListConfigState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CompleteListConfigState>();
}

class _CompleteListConfigState extends State<CompleteListConfig> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _ListPlaceHolder extends StatefulWidget {
  final BaseListController controller;
  final Widget child;
  const _ListPlaceHolder(
      {Key? key, required this.controller, required this.child})
      : super(key: key);
  @override
  __ListPlaceHolderState createState() => __ListPlaceHolderState();
}

class __ListPlaceHolderState extends State<_ListPlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ListPlaceHolder {
  final BaseListController? controller;
  final Labels Function(BuildContext context)? labels;
  final Widget? icon;
  final Widget? text;
  final Widget? loader;
  const ListPlaceHolder({
    Key? key,
    this.controller,
    this.labels,
    this.icon,
    this.text,
    this.loader,
  });
  static ListPlaceHolder copyWith({
    required BuildContext context,
    Labels Function(BuildContext context)? labels,
    BaseListController? controller,
    Widget? icon,
    Widget? text,
    Widget? loader,
  }) {
    var config = CompleteListConfig.of(context)?.widget;
    return ListPlaceHolder(
      labels: labels ?? config?.placeholder.labels,
      loader: loader ?? config?.placeholder.loader,
      text: text ?? config?.placeholder.text,
      icon: icon ?? config?.placeholder.icon,
      controller: controller,
    );
  }

  Labels getLabels(BuildContext context) {
    var config = CompleteListConfig.of(context)?.widget;
    var fn = labels ?? config?.placeholder.labels;
    if (fn == null) return Labels.of(context);
    return fn(context);
  }

  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        var config = CompleteListConfig.of(context)?.widget;
        var _labels = getLabels(context);
        var _controller = controller ??
            context
                .findAncestorStateOfType<__ListPlaceHolderState>()!
                .widget
                .controller;
        String message;
        if (_controller.paging?.loading == true) {
          message = _labels.loadingText;
        } else if (_controller.paging != null) {
          message = _controller.paging!.error ?? _labels.emptyList;
        } else {
          message = _labels.emptyList;
        }
        return Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(
              color: config?.color ?? Theme.of(context).disabledColor,
            ),
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: config?.color ?? Theme.of(context).disabledColor,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: FittedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: SizedBox(
                        key: Key(
                            '${_controller.paging?.fullScreenLoad}_${_controller.paging?.refreshing}_${_controller.paging?.hasError}'),
                        child: _getPlaceHolder(context, _controller),
                      ),
                    ),
                    SizedBox(height: config?.spaceBetweenIconAndText ?? 10),
                    _getText(config?.style, message),
                    SizedBox(height: config?.spaceBetweenTextAndButton ?? 5),
                    if (_controller.paging != null)
                      _getTextButton(_controller.paging!, _labels),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getText(TextStyle? style, String message) {
    return text ??
        Text(
          message,
          textAlign: TextAlign.center,
          style: style ?? TextStyle(fontSize: 18),
        );
  }

  TextButton _getTextButton(ListPaging controller, Labels _labels) {
    return TextButton(
      onPressed: controller.loading.onFalseOrNull(controller.reloadApi),
      child: Text(_labels.reload, textAlign: TextAlign.center),
    );
  }

  Widget _getPlaceHolder(BuildContext context, BaseListController controller) {
    if (controller.paging?.fullScreenLoad == true) {
      return _getLoader(context);
    } else {
      return _getIcon();
    }
  }

  Widget _getLoader(BuildContext context) {
    return loader ??
        Container(
          height: 100,
          alignment: Alignment.center,
          child: Theme.of(context).platform == TargetPlatform.iOS
              ? CupertinoActivityIndicator(radius: 25)
              : CircularProgressIndicator(),
        );
  }

  Widget _getIcon() {
    return icon ?? Icon(Icons.local_fire_department, size: 100);
  }
}

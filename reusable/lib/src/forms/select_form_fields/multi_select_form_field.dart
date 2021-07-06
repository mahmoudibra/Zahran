part of select_form_feilds;

class MultiSelectFormField<TItem,
    TController extends SelectFormController<TItem>> extends InheritedWidget {
  final InputDecoration decoration;
  final TController controller;
  final String? tag;
  final Color? inActiveColor;
  final Color? activeColor;
  final TextStyle? itemTextStyle;
  final TextStyle? textStyle;
  final Future<TItem> Function(BuildContext context, Widget child)? showItems;
  final FormFieldSetter<List<TItem>>? onSaved;
  final FormFieldSetter<List<TItem>>? onSelected;
  final FormFieldValidator<List<TItem>>? validator;
  final List<TItem>? initialValue;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final TextAlign textAlign;
  final bool enabled;
  final Widget Function(FormFieldState<List<TItem>> feild)? builder;
  MultiSelectFormField({
    this.decoration = const InputDecoration(),
    required this.controller,
    this.inActiveColor,
    Key? key,
    this.activeColor,
    this.itemTextStyle,
    this.textStyle,
    this.onSaved,
    this.onSelected,
    this.validator,
    this.initialValue,
    this.autovalidateMode,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.enabled = true,
    this.tag,
    this.showItems,
  })  : builder = null,
        super(key: key, child: _MltiField<TItem, TController>());

  MultiSelectFormField.builder({
    required this.controller,
    required this.builder,
    this.inActiveColor,
    Key? key,
    this.activeColor,
    this.itemTextStyle,
    this.textStyle,
    this.onSaved,
    this.onSelected,
    this.validator,
    this.initialValue,
    this.autovalidateMode,
    this.enabled = true,
    this.tag,
    this.showItems,
  })  : decoration = const InputDecoration(),
        maxLines = null,
        textAlign = TextAlign.start,
        super(key: key, child: _MltiField<TItem, TController>());
  @override
  bool updateShouldNotify(MultiSelectFormField<TItem, TController> oldWidget) {
    return true;
  }

  static MultiSelectFormField<TItem, TController>?
      of<TItem, TController extends SelectFormController<TItem>>(
          BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        MultiSelectFormField<TItem, TController>>();
  }
}

class _MltiField<TItem, TController extends SelectFormController<TItem>>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var options = MultiSelectFormField.of<TItem, TController>(context)!;
    return FormField<List<TItem>>(
        key: key,
        initialValue: options.initialValue ?? [],
        validator: options.validator,
        onSaved: options.onSaved,
        autovalidateMode: options.autovalidateMode,
        builder: (FormFieldState<List<TItem>> field) {
          return _MultiSelectFormField<TItem, TController>(
            field: field,
          );
        });
  }
}

class _MultiSelectFormField<TItem,
    TController extends SelectFormController<TItem>> extends StatefulWidget {
  final FormFieldState<List<TItem>> field;

  const _MultiSelectFormField({Key? key, required this.field})
      : super(key: key);

  @override
  __MultiSelectFormFieldState<TItem, TController> createState() =>
      __MultiSelectFormFieldState<TItem, TController>();
}

class __MultiSelectFormFieldState<TItem,
        TController extends SelectFormController<TItem>>
    extends State<_MultiSelectFormField<TItem, TController>>
    with AutomaticKeepAliveClientMixin {
  late FocusNode _focusNode;
  late FocusAttachment _focusAttachment;

  @override
  bool get wantKeepAlive => true;
  void _handleFocusChanged() {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      if (mounted && _focusNode.hasFocus) {
        shoSheet();
        _focusNode.unfocus();
      }
    });
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusAttachment = _focusNode.attach(context);
    _focusNode.addListener(_handleFocusChanged);

    super.initState();
  }

  @override
  void dispose() {
    _focusAttachment.detach();
    _focusNode.removeListener(_handleFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // CompletedForm.of(context)?.register(widget.field);
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    // CompletedForm.of(context).unregister(widget.field);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    _focusAttachment.reparent();
    super.build(context);
    var options = MultiSelectFormField.of<TItem, TController>(context)!;

    final effectiveDecoration = options.decoration
        .applyDefaults(Theme.of(context).inputDecorationTheme);
    final style =
        Theme.of(context).textTheme.subtitle1?.merge(options.textStyle) ??
            options.textStyle;
    var value = widget.field.value ?? [];
    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: options.enabled.onTrue(() async {
          FocusScope.of(context).requestFocus(_focusNode);
        }),
        behavior: HitTestBehavior.opaque,
        child: options.builder != null
            ? options.builder!(widget.field)
            : InputDecorator(
                isFocused: _focusNode.hasFocus,
                decoration: effectiveDecoration.copyWith(
                  errorText: widget.field.errorText,
                  enabled: options.enabled,
                  suffixIcon: effectiveDecoration.suffixIcon ??
                      (widget.field.value == null
                          ? null
                          : IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                widget.field.didChange(null);
                              },
                            )),
                ),
                isEmpty: value.isEmpty,
                textAlign: options.textAlign,
                child: Text(
                  value
                      .map((e) => options.controller.getDisplay(context, e))
                      .join(','),
                  style: style,
                  textAlign: options.textAlign,
                  maxLines: options.maxLines,
                ),
              ),
      ),
    );
  }

  Widget getSheet(MultiSelectFormField<TItem, TController> options) {
    return _SelectorSheet<TItem, TController>(
      controller: options.controller,
      allowMultible: true,
      tag: options.tag,
      textStyle: options.itemTextStyle,
      activeColor: options.activeColor,
      inActiveColor: options.inActiveColor,
      selectdItems: widget.field.value ?? [],
    );
  }

  Future shoSheet() {
    var options = MultiSelectFormField.of<TItem, TController>(context)!;
    Future future;
    if (options.showItems != null) {
      future = options.showItems!(
        widget.field.context,
        getSheet(options),
      );
    } else {
      future = showModalBottomSheet(
        context: widget.field.context,
        isScrollControlled: true,
        builder: (ctx) => getSheet(options),
      );
    }
    return future.then((value) {
      if (value is List<TItem>) {
        widget.field.didChange(value);
        if (options.onSelected != null) options.onSelected!(value);
      }
    });
  }
}

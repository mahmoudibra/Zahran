part of select_form_feilds;

class SelectFormField<TItem, TController extends SelectFormController<TItem>>
    extends InheritedWidget {
  final InputDecoration decoration;
  final TController controller;
  final String? tag;
  final Color? inActiveColor;
  final Color? activeColor;
  final Labels? labels;
  final TextStyle? itemTextStyle;
  final TextStyle? textStyle;
  final FormFieldSetter<TItem>? onSaved;
  final FormFieldSetter<TItem>? onSelected;
  final FormFieldValidator<TItem>? validator;
  final TItem? initialValue;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final TextAlign textAlign;
  final bool enabled;
  final Future<TItem> Function(BuildContext context, Widget child)? showItems;
  final Widget Function(FormFieldState<TItem> feild)? builder;
  SelectFormField({
    this.decoration = const InputDecoration(),
    required this.controller,
    this.inActiveColor,
    Key? key,
    this.activeColor,
    this.labels,
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
        super(key: key, child: _Field<TItem, TController>());

  SelectFormField.builder({
    required this.controller,
    required this.builder,
    this.inActiveColor,
    Key? key,
    this.activeColor,
    this.labels,
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
        super(key: key, child: _Field<TItem, TController>());
  @override
  bool updateShouldNotify(SelectFormField<TItem, TController> oldWidget) {
    return true;
  }

  static SelectFormField<TItem, TController>?
      of<TItem, TController extends SelectFormController<TItem>>(
          BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        SelectFormField<TItem, TController>>();
  }
}

class _Field<TItem, TController extends SelectFormController<TItem>>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var options = SelectFormField.of<TItem, TController>(context)!;
    return FormField<TItem>(
        key: key,
        initialValue: options.initialValue,
        validator: options.validator,
        onSaved: options.onSaved,
        autovalidateMode: options.autovalidateMode,
        builder: (FormFieldState<TItem> field) {
          return _SelectFormField<TItem, TController>(
            field: field,
          );
        });
  }
}

class _SelectFormField<TItem, TController extends SelectFormController<TItem>>
    extends StatefulWidget {
  final FormFieldState<TItem> field;

  const _SelectFormField({Key? key, required this.field}) : super(key: key);

  @override
  __SelectFormFieldState<TItem, TController> createState() =>
      __SelectFormFieldState<TItem, TController>();
}

class __SelectFormFieldState<TItem,
        TController extends SelectFormController<TItem>>
    extends State<_SelectFormField<TItem, TController>>
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
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
  Widget build(BuildContext context) {
    _focusAttachment.reparent();
    super.build(context);
    var options = SelectFormField.of<TItem, TController>(context)!;

    final effectiveDecoration = options.decoration
        .applyDefaults(Theme.of(context).inputDecorationTheme);
    final style =
        Theme.of(context).textTheme.subtitle1?.merge(options.textStyle) ??
            options.textStyle;
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
                                if (options.onSelected != null)
                                  options.onSelected!(null);
                              },
                            )),
                ),
                isEmpty: widget.field.value == null,
                textAlign: options.textAlign,
                child: Text(
                  widget.field.value == null
                      ? ''
                      : options.controller
                          .getDisplay(context, widget.field.value!),
                  style: style,
                  textAlign: options.textAlign,
                  maxLines: options.maxLines,
                ),
              ),
      ),
    );
  }

  Widget getSheet(SelectFormField<TItem, TController> options) {
    return _SelectorSheet<TItem, TController>(
      controller: options.controller,
      allowMultible: false,
      tag: options.tag,
      textStyle: options.itemTextStyle,
      activeColor: options.activeColor,
      inActiveColor: options.inActiveColor,
      selectdItems: widget.field.value == null ? [] : [widget.field.value!],
    );
  }

  Future shoSheet() {
    var options = SelectFormField.of<TItem, TController>(context)!;
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
      if (value is TItem) {
        widget.field.didChange(value);
        if (options.onSelected != null) options.onSelected!(value);
      }
      return value;
    });
  }
}

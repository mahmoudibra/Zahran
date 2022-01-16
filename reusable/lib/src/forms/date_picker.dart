import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

class FormDatePicker extends StatefulWidget {
  final GlobalKey<FormFieldState<DateTime>>? fieldKey;
  final InputDecoration decoration;
  final FormFieldSetter<DateTime>? onSaved;
  final FormFieldSetter<DateTime>? onPicked;
  final FormFieldValidator<DateTime>? validator;
  final DateTime? initialValue;
  final DateFormat? format;
  final DateTime minDate;
  final TextStyle? textStyle;
  final AutovalidateMode? autovalidateMode;
  final bool enabled;
  final SelectableDayPredicate? selectableDayPredicate;
  const FormDatePicker({
    this.fieldKey,
    this.decoration = const InputDecoration(),
    this.onSaved,
    this.onPicked,
    this.validator,
    this.initialValue,
    this.format,
    required this.minDate,
    this.textStyle,
    this.autovalidateMode,
    this.enabled = true,
    this.selectableDayPredicate,
  });
  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormFieldState<DateTime>> _fieldKey =
      GlobalKey<FormFieldState<DateTime>>();
  GlobalKey<FormFieldState<DateTime>> get fieldKey =>
      widget.fieldKey ?? _fieldKey;
  late FocusNode _focusNode;
  late FocusAttachment _focusAttachment;
  @override
  bool get wantKeepAlive => true;
  void _handleFocusChanged() {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      if (mounted && _focusNode.hasFocus) {
        _pickDate(fieldKey.currentState!);
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
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    _focusAttachment.reparent();
    super.build(context);
    return FormField(
      key: fieldKey,
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      builder: (FormFieldState<DateTime> field) {
        var date = field.value ?? DateTime.now();
        var myLocale = Localizations.localeOf(field.context);
        var formatter = widget.format ??
            (DateFormat('EEEE dd MMMM yyyy', myLocale.languageCode));
        var formatted = formatter.format(date.toLocal());
        var theme = Theme.of(field.context);
        final effectiveDecoration =
            widget.decoration.applyDefaults(theme.inputDecorationTheme);
        final style = theme.textTheme.subtitle1?.merge(widget.textStyle) ??
            widget.textStyle;
        return Semantics(
          button: true,
          child: GestureDetector(
            onTap: widget.enabled.onTrue(() async {
              var currentFocus = FocusScope.of(field.context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              _pickDate(field);
            }),
            behavior: HitTestBehavior.opaque,
            child: InputDecorator(
              isFocused: _focusNode.hasFocus,
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: widget.enabled,
                suffixIcon: effectiveDecoration.suffixIcon ??
                    (field.value == null
                        ? null
                        : IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              field.didChange(null);
                              if (widget.onPicked != null) {
                                widget.onPicked!(null);
                              }
                            },
                          )),
              ),
              isEmpty: field.value == null,
              child: Text(
                field.value == null ? '' : formatted,
                style: style,
                maxLines: 1,
              ),
            ),
          ),
        );
      },
    );
  }

  void _pickDate(FormFieldState<DateTime> field) async {
    var init = field.value ?? widget.initialValue ?? DateTime.now();
    var result = await showDatePicker(
      context: field.context,
      firstDate: widget.minDate,
      selectableDayPredicate: widget.selectableDayPredicate,
      initialDate: init.isAfter(widget.minDate) ? init : widget.minDate,
      lastDate: DateTime(2250),
    );

    if (result != null) {
      field.didChange(result);
      if (widget.onPicked != null) widget.onPicked!(result);
    }
  }
}

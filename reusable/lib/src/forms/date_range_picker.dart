import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reusable/reusable.dart';
import 'package:simple/simple.dart';

class FormDateTimeRangePicker extends StatefulWidget {
  final GlobalKey<FormFieldState<DateTimeRange>>? fieldKey;
  final InputDecoration decoration;
  final FormFieldSetter<DateTimeRange>? onSaved;
  final FormFieldSetter<DateTimeRange>? onPicked;
  final FormFieldValidator<DateTimeRange>? validator;
  final DateTimeRange? initialValue;
  final DateFormat? format;
  final DateTime minDate;
  final TextStyle? textStyle;
  final AutovalidateMode? autovalidateMode;
  final bool enabled;
  final DatePickerEntryMode initialEntryMode;
  const FormDateTimeRangePicker({
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
    this.initialEntryMode = DatePickerEntryMode.calendar,
  });
  @override
  _FormDateTimeRangeickerState createState() => _FormDateTimeRangeickerState();
}

class _FormDateTimeRangeickerState extends State<FormDateTimeRangePicker>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormFieldState<DateTimeRange>> _fieldKey =
      GlobalKey<FormFieldState<DateTimeRange>>();
  GlobalKey<FormFieldState<DateTimeRange>> get fieldKey =>
      widget.fieldKey ?? _fieldKey;
  late FocusNode _focusNode;
  late FocusAttachment _focusAttachment;
  @override
  bool get wantKeepAlive => true;
  void _handleFocusChanged() {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      if (mounted && _focusNode.hasFocus) {
        _pick(fieldKey.currentState!);
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
      builder: (FormFieldState<DateTimeRange> field) {
        var myLocale = Localizations.localeOf(field.context);
        var formatter = widget.format ??
            (DateFormat('EEEE dd MMMM yyyy', myLocale.languageCode));
        var formattedStart =
            field.value == null ? null : formatter.format(field.value!.start);
        var formattedEnd =
            field.value == null ? null : formatter.format(field.value!.end);
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
              _pick(field);
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
                field.value == null ? '' : '$formattedStart _ $formattedEnd',
                style: style,
                maxLines: 1,
              ),
            ),
          ),
        );
      },
    );
  }

  void _pick(FormFieldState<DateTimeRange> field) async {
    var result = await showDateRangePicker(
      context: field.context,
      firstDate: widget.minDate,
      initialEntryMode: widget.initialEntryMode,
      initialDateRange: field.value,
      lastDate: DateTime(2250),
    );

    if (result != null) {
      field.didChange(result);
      if (widget.onPicked != null) widget.onPicked!(result);
    }
  }
}

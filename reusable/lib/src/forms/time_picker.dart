import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple/simple.dart';

import '../../reusable.dart';

class FormTimePicker extends StatefulWidget {
  final GlobalKey<FormFieldState<TimeOfDay>>? fieldKey;
  final InputDecoration decoration;
  final FormFieldSetter<TimeOfDay>? onSaved;
  final FormFieldSetter<TimeOfDay>? onPicked;
  final FormFieldValidator<TimeOfDay>? validator;
  final TimeOfDay? initialValue;
  final DateFormat? format;
  final TextStyle? textStyle;
  final AutovalidateMode? autovalidateMode;
  final bool enabled;

  const FormTimePicker({
    this.fieldKey,
    this.decoration = const InputDecoration(),
    this.onSaved,
    this.onPicked,
    this.validator,
    this.initialValue,
    this.format,
    this.textStyle,
    this.autovalidateMode,
    this.enabled = true,
  });
  @override
  _FormTimePickerState createState() => _FormTimePickerState();
}

class _FormTimePickerState extends State<FormTimePicker>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormFieldState<TimeOfDay>> _fieldKey =
      GlobalKey<FormFieldState<TimeOfDay>>();
  GlobalKey<FormFieldState<TimeOfDay>> get fieldKey =>
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
      builder: (FormFieldState<TimeOfDay> field) {
        var time = field.value ?? TimeOfDay.now();
        var formatted = MaterialLocalizations.of(context).formatTimeOfDay(time);
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

  void _pickDate(FormFieldState<TimeOfDay> field) async {
    var result = await showTimePicker(
      context: field.context,
      initialTime: field.value ?? TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (result != null) {
      field.didChange(result);
      if (widget.onPicked != null) widget.onPicked!(result);
    }
  }
}

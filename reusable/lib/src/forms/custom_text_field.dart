import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reusable/l10n/gen_l10n/reusable_localizations.dart';
import 'package:reusable/reusable.dart';
import 'package:intl/intl.dart';
import 'package:simple/simple.dart';

class CustomTextField extends StatefulWidget {
  final FormFieldSetter<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final String? initialValue;
  final Widget? Function(bool visible) prefexIcon;
  final Widget? Function(bool visible) icon;
  final String? Function(bool visible) prefexText;
  final Widget? Function(bool visible) suffixIcon;
  final String? Function(bool visible) suffixText;
  final String? hint;
  final String? label;
  final int? maxLength;
  final bool enabled;
  final int? maxLines;
  final bool password;
  final FocusNode? node;
  final TextInputType? textInputType;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final TextAlign Function(String value)? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? extraValidator;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefexIconConstraints;
  final GlobalKey<FormFieldState>? fieldKey;
  final InputDecoration? decoration;
  final Iterable<String>? autofillHints;

  const CustomTextField._({
    required this.onChanged,
    required this.initialValue,
    required this.prefexText,
    required this.icon,
    required this.prefexIcon,
    required this.hint,
    required this.validator,
    required this.maxLength,
    required this.password,
    required this.textInputType,
    required this.suffixIcon,
    required this.textAlign,
    required this.inputFormatters,
    required this.maxLines,
    required this.suffixIconConstraints,
    required this.extraValidator,
    required this.node,
    required this.label,
    required this.textInputAction,
    required this.onFieldSubmitted,
    required this.suffixText,
    required this.fieldKey,
    required this.prefexIconConstraints,
    required this.decoration,
    required this.enabled,
    required this.onSaved,
    required this.onEditingComplete,
    required this.onFocusChanged,
    required this.autofillHints,
  });

  factory CustomTextField({
    FormFieldSetter<String>? onChanged,
    FormFieldSetter<String>? onSaved,
    String? initialValue,
    String? prefexText,
    Widget? prefexIcon,
    Widget? suffixIcon,
    String? suffixText,
    Widget? icon,
    String? hint,
    String? label,
    int? maxLength,
    int? maxLines,
    FocusNode? node,
    TextInputType? textInputType,
    ValueChanged<String>? onFieldSubmitted,
    TextInputAction? textInputAction,
    TextAlign Function(String value)? textAlign,
    List<TextInputFormatter>? inputFormatters,
    FormFieldValidator<String>? validator,
    FormFieldValidator<String>? extraValidator,
    VoidCallback? onEditingComplete,
    BoxConstraints? suffixIconConstraints,
    BoxConstraints? prefexIconConstraints,
    GlobalKey<FormFieldState>? key,
    ValueChanged<bool>? onFocusChanged,
    bool enabled = true,
    Iterable<String>? autofillHints,
  }) =>
      CustomTextField._(
        enabled: enabled,
        autofillHints: autofillHints,
        onChanged: onChanged,
        onFocusChanged: onFocusChanged,
        onSaved: onSaved,
        initialValue: initialValue,
        onEditingComplete: onEditingComplete,
        icon: (v) => icon,
        prefexText: (v) => prefexText,
        prefexIcon: (v) => prefexIcon,
        suffixIcon: (v) => suffixIcon,
        suffixText: (v) => suffixText,
        hint: hint,
        validator: validator,
        maxLength: maxLength,
        password: false,
        textInputType: textInputType,
        textAlign: textAlign,
        inputFormatters: inputFormatters,
        maxLines: maxLines ?? 1,
        suffixIconConstraints: suffixIconConstraints,
        prefexIconConstraints: prefexIconConstraints,
        extraValidator: extraValidator,
        node: node,
        label: label,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: onFieldSubmitted,
        fieldKey: key,
        decoration: null,
      );
  factory CustomTextField.password({
    FormFieldSetter<String>? onChanged,
    FormFieldSetter<String>? onSaved,
    String? initialValue,
    Widget Function(bool visible)? prefexIcon,
    Widget Function(bool visible)? icon,
    String Function(bool visible)? prefexText,
    Widget Function(bool visible)? suffixIcon,
    String Function(bool visible)? suffixText,
    String? hint,
    String? label,
    int? maxLength,
    int? maxLines,
    FocusNode? node,
    ValueChanged<String>? onFieldSubmitted,
    TextInputAction? textInputAction,
    TextAlign Function(String value)? textAlign,
    List<TextInputFormatter>? inputFormatters,
    FormFieldValidator<String>? validator,
    FormFieldValidator<String>? extraValidator,
    BoxConstraints? suffixIconConstraints,
    BoxConstraints? prefexIconConstraints,
    GlobalKey<FormFieldState>? key,
    VoidCallback? onEditingComplete,
    ValueChanged<bool>? onFocusChanged,
    Iterable<String>? autofillHints,
    bool enabled = true,
  }) =>
      CustomTextField._(
        enabled: enabled,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSaved: onSaved,
        autofillHints: autofillHints,
        initialValue: initialValue,
        onFocusChanged: onFocusChanged,
        hint: hint,
        icon: icon ?? (v) => null,
        prefexText: prefexText ?? (v) => null,
        prefexIcon: prefexIcon ?? (v) => null,
        suffixIcon: suffixIcon ?? (v) => null,
        suffixText: suffixText ?? (v) => null,
        validator: validator,
        maxLength: maxLength,
        password: true,
        textInputType: TextInputType.visiblePassword,
        textAlign: textAlign,
        inputFormatters: inputFormatters,
        maxLines: maxLines ?? 1,
        suffixIconConstraints: suffixIconConstraints,
        prefexIconConstraints: prefexIconConstraints,
        extraValidator: extraValidator,
        node: node,
        label: label,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: onFieldSubmitted,
        fieldKey: key,
        decoration: null,
      );
  factory CustomTextField.decoration({
    FormFieldSetter<String>? onChanged,
    FormFieldSetter<String>? onSaved,
    required InputDecoration decoration,
    String? initialValue,
    int? maxLength,
    int? maxLines,
    FocusNode? node,
    TextInputType? textInputType,
    ValueChanged<String>? onFieldSubmitted,
    TextInputAction? textInputAction,
    TextAlign Function(String value)? textAlign,
    List<TextInputFormatter>? inputFormatters,
    FormFieldValidator<String>? validator,
    FormFieldValidator<String>? extraValidator,
    VoidCallback? onEditingComplete,
    GlobalKey<FormFieldState>? key,
    bool enabled = true,
    ValueChanged<bool>? onFocusChanged,
    Iterable<String>? autofillHints,
  }) =>
      CustomTextField._(
        enabled: enabled,
        onFocusChanged: onFocusChanged,
        onChanged: onChanged,
        autofillHints: autofillHints,
        onSaved: onSaved,
        initialValue: initialValue,
        validator: validator,
        maxLength: maxLength,
        password: false,
        onEditingComplete: onEditingComplete,
        textInputType: textInputType,
        textAlign: textAlign,
        inputFormatters: inputFormatters,
        maxLines: maxLines ?? 1,
        extraValidator: extraValidator,
        node: node,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: onFieldSubmitted,
        fieldKey: key,
        decoration: decoration,
        hint: null,
        label: null,
        prefexIconConstraints: null,
        icon: (v) => null,
        prefexText: (v) => null,
        prefexIcon: (v) => null,
        suffixIcon: (v) => null,
        suffixText: (v) => null,
        suffixIconConstraints: null,
      );
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> get fieldKey => widget.fieldKey ?? _fieldKey;
  bool passwordVisible = false;
  final FocusNode _node = FocusNode();
  FocusNode get node => widget.node ?? _node;
  void _onFocusChanges() {
    if (widget.onFocusChanged != null) widget.onFocusChanged!(node.hasFocus);
  }

  @override
  void initState() {
    node.addListener(_onFocusChanges);
    super.initState();
  }

  @override
  void dispose() {
    node.removeListener(_onFocusChanges);
    _node.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    var isNumbers = widget.textInputType?.index == TextInputType.number.index ||
        widget.textInputType?.index == TextInputType.phone.index;
    var suffixIcon = widget.suffixIcon(passwordVisible);
    if (widget.password == true && suffixIcon != null) {
      suffixIcon = InkWell(
        onTap: () {
          if (!node.hasFocus) {
            node.canRequestFocus = false;
            Future.delayed(Duration(milliseconds: 300)).then((value) {
              node.canRequestFocus = true;
            });
          }
          setState(() {
            passwordVisible = !passwordVisible;
          });
        },
        child: suffixIcon,
      );
    }

    TextAlign detectTextAlign(String? v) {
      if (v == null || v.isEmpty || (widget.password && !passwordVisible)) {
        return TextAlign.start;
      }
      var isRtl = Bidi.detectRtlDirectionality(v);
      if (isRtl) {
        return TextAlign.right;
      } else {
        return TextAlign.left;
      }
    }

    return TextFormField(
      focusNode: node,
      key: fieldKey,
      autofillHints: widget.autofillHints,
      enabled: widget.enabled,
      onEditingComplete: widget.onEditingComplete,
      onSaved: widget.onSaved,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: (v) {
        if (widget.onChanged != null) widget.onChanged!(v);
        setState(() {});
      },
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      keyboardType: widget.textInputType,
      obscureText: widget.password == true && !passwordVisible,
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters ??
          isNumbers.onTrue([ArabicNumbersToEnglishFormatter()]),
      textAlign: widget.textAlign == null
          ? detectTextAlign(
              fieldKey.currentState?.value ?? widget.initialValue ?? '')
          : widget.textAlign!(fieldKey.currentState?.value ?? ''),
      decoration: widget.decoration ??
          InputDecoration(
            prefixIconConstraints: widget.prefexIconConstraints ??
                BoxConstraints.tightFor(width: 50),
            suffixIconConstraints: widget.suffixIconConstraints ??
                BoxConstraints.tightFor(width: 50),
            hintText: widget.hint,
            icon: widget.icon(passwordVisible),
            prefixIcon: widget.prefexIcon(passwordVisible),
            prefixText: widget.prefexText(passwordVisible),
            labelText: widget.label,
            suffixIcon: suffixIcon,
            suffixText: widget.suffixText(passwordVisible),
          ),
      validator: widget.validator ??
          (v) =>
              (v.isNullOrEmptyOrWhiteSpace).onTrue(
                  ReusableLocalizations.of(context)?.requiredField ??
                      'required field') ??
              (widget.extraValidator == null
                  ? null
                  : widget.extraValidator!(v)),
    );
  }
}

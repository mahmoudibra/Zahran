import 'package:flutter/material.dart';

import 'circular_reveal.dart';
import 'keyboard_unfocus.dart';

typedef OnPostDataCallBack = Future<dynamic> Function();

class CompletedFormKey extends GlobalKey<_CompletedFormState> {
  const CompletedFormKey() : super.constructor();
  void resetAutoValidate() => currentState?.resetAutoValidate();
  Future<dynamic>? onSubmit() => currentState?.onSubmit();
  bool get submitting => currentState?.submitting ?? false;
}

class CompletedForm extends StatefulWidget {
  final OnPostDataCallBack onPostData;
  final Widget child;
  final AutofillContextAction autofillContextAction;
  final bool reveal;
  const CompletedForm({
    CompletedFormKey? key,
    required this.onPostData,
    required this.child,
    this.autofillContextAction = AutofillContextAction.cancel,
    this.reveal = false,
  }) : super(key: key);

  factory CompletedForm.builder({
    CompletedFormKey? key,
    required OnPostDataCallBack onPostData,
    AutofillContextAction autofillContextAction = AutofillContextAction.cancel,
    required Widget Function(BuildContext context, bool submitting) builder,
    bool reveal = false,
  }) =>
      CompletedForm(
        key: key,
        reveal: reveal,
        onPostData: onPostData,
        autofillContextAction: autofillContextAction,
        child: Builder(
          builder: (BuildContext context) {
            return builder(context, CompletedForm.of(context)!.submitting);
          },
        ),
      );

  static _CompletedFormState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CompletedFormState>();
  @override
  _CompletedFormState createState() => _CompletedFormState();
}

class _CompletedFormState extends State<CompletedForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutofillContextAction autofillContextAction = AutofillContextAction.cancel;
  CircularRevealController? controller;
  bool _autoValidate = false;
  bool _submitting = false;
  bool get submitting => _submitting;
  Future<dynamic> onSubmit() async {
    if (_submitting) return;
    setState(() {
      autofillContextAction = AutofillContextAction.cancel;
    });
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await _validationSuccess();
    } else {
      var items = FocusScope.of(context).children.where((element) {
        if (element.context == null) return false;
        var field = element.context!.findAncestorStateOfType<FormFieldState>();
        if (field == null || !field.hasError) return false;
        return true;
      }).toList();
      if (items.isNotEmpty) {
        await Scrollable.ensureVisible(
          items[0].context!,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInCubic,
          alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
        );
      }

      setState(() {
        _autoValidate = true;
      });
    }
  }

  void resetAutoValidate() {
    setState(() {
      _autoValidate = false;
    });
  }

  Future<dynamic> _validationSuccess() async {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {
      _submitting = true;
    });
    try {
      var result = await widget.onPostData();
      setState(() {
        _submitting = false;
        autofillContextAction = widget.autofillContextAction;
      });
      if (controller != null) {
        await controller!.reveal().then((value) async {
          await Future.delayed(Duration(milliseconds: 300));
          await controller?.unReveal();
        });
      }

      return result;
    } catch (e) {
      setState(() {
        _submitting = false;
        autofillContextAction = widget.autofillContextAction;
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reveal) {
      return CircularReveal(
        build: (CircularRevealController ctrl) {
          controller = ctrl;
          return _build(context);
        },
      );
    } else {
      return _build(context);
    }
  }

  Widget _build(BuildContext context) {
    return KeyBoadUnfocusAction(
      child: AutofillGroup(
        onDisposeAction: autofillContextAction,
        child: Form(
          key: formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: widget.child,
        ),
      ),
    );
  }
}

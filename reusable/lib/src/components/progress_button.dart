import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:reusable/reusable.dart';

enum _ButtonState { Initial, Error, Loading, Done }
enum ButtonType { Elevated, Outlined, Text }

class ProgressButtonKey extends GlobalKey<_ProgressButtonState> {
  const ProgressButtonKey() : super.constructor();
  void onPressed() => currentState?._onPressed();
  bool get isLoading => currentState?.state == _ButtonState.Loading;
  bool get isDone => currentState?.state == _ButtonState.Done;
  bool get isError => currentState?.state == _ButtonState.Error;
}

class ProgressButton extends StatefulWidget {
  final OnPostDataCallBack? onPressed;
  final ValueNotifier<double>? progressNotifier;
  final AlignmentGeometry? alignment;
  final Widget? errorIcon;
  final Widget? sucessIcon;
  final Duration duration;
  final Clip clipBehavior;
  final ButtonStyle? style;
  final Widget child;
  final Widget? loadingWidget;
  final ButtonType type;
  final bool checkFormSubmit;

  ProgressButton({
    ProgressButtonKey? key,
    this.onPressed,
    required this.child,
    this.progressNotifier,
    this.alignment = Alignment.center,
    this.errorIcon,
    this.sucessIcon,
    this.duration = const Duration(milliseconds: 300),
    this.loadingWidget,
    this.clipBehavior = Clip.antiAlias,
    this.style,
    this.checkFormSubmit = true,
    this.type = ButtonType.Elevated,
  }) : super(key: key);

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  _ButtonState state = _ButtonState.Initial;
  GlobalKey _butonKey = GlobalKey();
  final GlobalKey _innerKey = GlobalKey();
  Size? _buttomSize;
  Size? _innerSize;
  Duration get duration => widget.duration;

  void _onProgress() {
    setState(() {});
  }

  @override
  void initState() {
    if (widget.progressNotifier != null) {
      widget.progressNotifier!.addListener(_onProgress);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.progressNotifier != null) {
      widget.progressNotifier!.removeListener(_onProgress);
    }

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _butonKey = GlobalKey();
    SchedulerBinding.instance?.addPostFrameCallback(postFrameCallback);
  }

  void _onPressed() {
    var callBack = widget.onPressed ??
        (widget.checkFormSubmit ? CompletedForm.of(context)?.onSubmit : null);
    if (callBack != null) _onCallBack(callBack);
  }

  void postFrameCallback(_) {
    if (state == _ButtonState.Initial) {
      var btnContext = _butonKey.currentContext;
      var innerContext = _innerKey.currentContext;
      if (innerContext != null) {
        var _size = innerContext.size;
        if (widget.type == ButtonType.Text && _size != null) {
          _innerSize = _size;
        } else if (_size != null) {
          var _min = min(_size.width, _size.height);
          _innerSize = Size(_min, _min);
        }
      }
      if (btnContext != null) {
        var _size = btnContext.size;
        if (widget.type == ButtonType.Text && _size != null) {
          _buttomSize = _size;
        } else if (_size != null) {
          var _min = min(_size.width, _size.height);
          _buttomSize = Size(_min, _min);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.alignment == null) return _build(context);
    return Align(
      alignment: widget.alignment ?? Alignment.center,
      child: _build(context),
    );
  }

  T? effectiveValue<T>(T? Function(ButtonStyle? style) getProperty) {
    final widgetStyle = widget.style;
    ButtonStyle? themeStyle;
    ButtonStyle defaultStyle;
    switch (widget.type) {
      case ButtonType.Text:
        themeStyle =
            TextButton(onPressed: () {}, child: Text('')).themeStyleOf(context);
        defaultStyle = TextButton(onPressed: () {}, child: Text(''))
            .defaultStyleOf(context);
        break;
      case ButtonType.Outlined:
        themeStyle = OutlinedButton(onPressed: () {}, child: Text(''))
            .themeStyleOf(context);
        defaultStyle = OutlinedButton(onPressed: () {}, child: Text(''))
            .defaultStyleOf(context);
        break;
      default:
        themeStyle = ElevatedButton(onPressed: () {}, child: Text(''))
            .themeStyleOf(context);
        defaultStyle = ElevatedButton(onPressed: () {}, child: Text(''))
            .defaultStyleOf(context);
    }
    final widgetValue = getProperty(widgetStyle);
    final themeValue = getProperty(themeStyle);
    final defaultValue = getProperty(defaultStyle);
    return widgetValue ?? themeValue ?? defaultValue;
  }

  T? resolve<T>(
      MaterialStateProperty<T?>? Function(ButtonStyle? style) getProperty) {
    return effectiveValue(
      (ButtonStyle? style) => getProperty(style)?.resolve({}),
    );
  }

  EdgeInsetsGeometry getDefaultPadding() {
    final resolvedPadding = resolve((ButtonStyle? style) => style?.padding);
    final resolvedVisualDensity =
        effectiveValue((ButtonStyle? style) => style?.visualDensity);

    final densityAdjustment = resolvedVisualDensity?.baseSizeAdjustment;
    return resolvedPadding
            ?.add(
              EdgeInsets.only(
                left: densityAdjustment?.dx ?? 0,
                top: densityAdjustment?.dy ?? 0,
                right: densityAdjustment?.dx ?? 0,
                bottom: densityAdjustment?.dy ?? 0,
              ),
            )
            .clamp(EdgeInsets.zero, EdgeInsetsGeometry.infinity) ??
        EdgeInsets.zero;
  }

  Color? getDefaulTextColor() {
    return resolve((ButtonStyle? style) => style?.foregroundColor);
  }

  Widget _build(BuildContext context) {
    var callback = widget.onPressed ??
        (widget.checkFormSubmit ? CompletedForm.of(context)?.onSubmit : null);
    var padding =
        state == _ButtonState.Initial ? getDefaultPadding() : EdgeInsets.all(3);
    Widget buttonChild = WillPopScope(
      onWillPop: () async {
        if (state == _ButtonState.Initial) {
          return true;
        } else {
          context.primarySnackBar(ReusableLocalizations.of(context)?.loading ??
              'Loading please wait ...');
          return false;
        }
      },
      child: AnimatedSize(
        alignment: widget.alignment ?? Alignment.center,
        duration: duration,
        child: SizedBox(
          key: _innerKey,
          width: state == _ButtonState.Initial ? null : _innerSize?.width,
          height: state == _ButtonState.Initial ? null : _innerSize?.height,
          child: Padding(
            padding: padding,
            child: _buildChild(),
          ),
        ),
      ),
    );

    var style = (widget.style ?? ButtonStyle()).copyWith(
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      minimumSize: state == _ButtonState.Initial
          ? null
          : MaterialStateProperty.all(_buttomSize),
      shape: state == _ButtonState.Initial
          ? null
          : MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                _buttomSize?.height ?? 50,
              ),
            )),
    );
    if (widget.type == ButtonType.Outlined) {
      return OutlinedButton(
        key: _butonKey,
        onPressed: callback == null ? null : _onPressed,
        clipBehavior: widget.clipBehavior,
        style: style,
        child: buttonChild,
      );
    }
    if (widget.type == ButtonType.Text) {
      return TextButton(
        key: _butonKey,
        onPressed: callback == null ? null : _onPressed,
        clipBehavior: widget.clipBehavior,
        style: style,
        child: buttonChild,
      );
    } else {
      return ElevatedButton(
        key: _butonKey,
        onPressed: callback == null ? null : _onPressed,
        clipBehavior: widget.clipBehavior,
        style: style,
        child: buttonChild,
      );
    }
  }

  void _setButtonState(_ButtonState _state) {
    if (_state == state) return;

    if (mounted == true) {
      setState(() {
        state = _state;
      });
    } else {
      state = _state;
    }
  }

  void _onCallBack(Future<dynamic> Function() callBack) {
    if (state != _ButtonState.Initial) return;
    _setButtonState(_ButtonState.Loading);
    callBack().then((d) {
      _setButtonState(_ButtonState.Done);
    }).catchError((c) {
      _setButtonState(_ButtonState.Error);
    }).whenComplete(() {
      if (widget.errorIcon != null || widget.sucessIcon != null) {
        Future.delayed(Duration(milliseconds: 1000)).then((value) {
          _setButtonState(_ButtonState.Initial);
        });
      } else {
        _setButtonState(_ButtonState.Initial);
      }
    });
  }

  Widget _buildChild() {
    return Builder(
      builder: (context) {
        return ProgressIndicatorTheme(
          data: ProgressIndicatorTheme.of(context).copyWith(
            circularTrackColor: DefaultTextStyle.of(context).style.color,
          ),
          child: (widget.alignment == null || state != _ButtonState.Initial)
              ? _buildInnerChild()
              : Center(child: _buildInnerChild()),
        );
      },
    );
  }

  Widget _buildInnerChild() {
    return LayoutBuilder(builder: (ctx, constrains) {
      var circularLoader = widget.loadingWidget ??
          CircularProgressIndicator(color: getDefaulTextColor());

      if (state == _ButtonState.Loading) {
        return widget.progressNotifier == null
            ? circularLoader
            : _buildCircularIndicator(ctx);
      }
      if (state != _ButtonState.Initial) {
        return (state == _ButtonState.Error
                ? widget.errorIcon
                : widget.sucessIcon) ??
            circularLoader;
      }
      return widget.child;
    });
  }

  Widget _buildCircularIndicator(BuildContext context) {
    return FittedBox(
      child: CircularPercentIndicator(
        radius: _innerSize == null
            ? 30
            : min(_innerSize!.width, _innerSize!.height),
        lineWidth: 5,
        animateFromLastPercent: true,
        animation: true,
        arcType: ArcType.FULL,
        backgroundColor: Theme.of(context).backgroundColor,
        circularStrokeCap: CircularStrokeCap.round,
        percent: widget.progressNotifier?.value ?? 0.5,
        arcBackgroundColor: DefaultTextStyle.of(context).style.color,
        progressColor: ProgressIndicatorTheme.of(context).circularTrackColor,
      ),
    );
  }
}

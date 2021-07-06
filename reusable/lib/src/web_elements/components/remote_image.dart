import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusable/src/web_elements/components/web_image.dart';

class ShapedRemoteImage extends StatelessWidget {
  final _Paramters paramters;
  ShapedRemoteImage._({
    Key? key,
    required this.paramters,
  }) : super(key: key);
  factory ShapedRemoteImage({
    Key? key,
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
    Decoration? forgroundDecoration,
    Widget? errorPlaceholder,
    ImageProvider? loadingPlaceholder,
    Decoration? decoration,
    EdgeInsetsGeometry? outerPadding,
    EdgeInsetsGeometry? innerPadding,
    Decoration? outerDecoration,
    Map<String, String>? queryParamters,
  }) =>
      ShapedRemoteImage._(
        key: key,
        paramters: _Paramters(
          url: url,
          queryParamters: queryParamters,
          width: width,
          height: height,
          fit: fit,
          forgroundDecoration: forgroundDecoration,
          aspectRatio: null,
          errorPlaceholder: errorPlaceholder,
          loadingPlaceholder: loadingPlaceholder,
          decoration: decoration,
          outerPadding: outerPadding,
          innerPadding: innerPadding,
          outerDecoration: outerDecoration,
        ),
      );
  factory ShapedRemoteImage.aspectRatio({
    Key? key,
    required String url,
    double aspectRatio = 1,
    BoxFit? fit,
    Decoration? forgroundDecoration,
    Widget? errorPlaceholder,
    ImageProvider? loadingPlaceholder,
    Decoration? decoration,
    EdgeInsetsGeometry? outerPadding,
    EdgeInsetsGeometry? innerPadding,
    Decoration? outerDecoration,
    Map<String, String>? queryParamters,
  }) =>
      ShapedRemoteImage._(
        key: key,
        paramters: _Paramters(
          url: url,
          queryParamters: queryParamters,
          width: null,
          height: null,
          fit: fit,
          forgroundDecoration: forgroundDecoration,
          aspectRatio: aspectRatio,
          errorPlaceholder: errorPlaceholder,
          loadingPlaceholder: loadingPlaceholder,
          decoration: decoration,
          outerPadding: outerPadding,
          innerPadding: innerPadding,
          outerDecoration: outerDecoration,
        ),
      );

  Decoration? getDecoration(BuildContext context) {
    if (paramters.decoration != null) return paramters.decoration!;
    return ShapedRemoteImageConfig.of(context)?.decoration;
  }

  Decoration? getForgroundDecoration(BuildContext context) =>
      paramters.forgroundDecoration ??
      ShapedRemoteImageConfig.of(context)?.forgroundDecoration;

  Decoration? getOuterDecoration(BuildContext context) =>
      paramters.outerDecoration ??
      ShapedRemoteImageConfig.of(context)?.outerDecoration;
  EdgeInsetsGeometry? getOuterPadding(BuildContext context) =>
      paramters.outerPadding ??
      ShapedRemoteImageConfig.of(context)?.outerPadding;
  EdgeInsetsGeometry? getInnerPadding(BuildContext context) =>
      paramters.innerPadding ??
      ShapedRemoteImageConfig.of(context)?.innerPadding ??
      EdgeInsets.zero;

  BoxFit getFit(BuildContext context) =>
      paramters.fit ??
      ShapedRemoteImageConfig.of(context)?.fit ??
      BoxFit.contain;

  Widget? getErrorPlaceholder(BuildContext context) =>
      paramters.errorPlaceholder ??
      ShapedRemoteImageConfig.of(context)?.errorPlaceholder;
  ImageProvider? getLoadingPlaceholder(BuildContext context) =>
      paramters.loadingPlaceholder ??
      ShapedRemoteImageConfig.of(context)?.loadingPlaceholder;
  Map<String, String>? getQueryParameters(BuildContext context) =>
      paramters.queryParamters ??
      ShapedRemoteImageConfig.of(context)?.queryParamters;
  @override
  Widget build(BuildContext context) {
    var _wrapperDecoration = getOuterDecoration(context);
    var _wrapperPadding = getOuterPadding(context);
    Widget child;
    if (_wrapperDecoration != null || _wrapperPadding != null) {
      child = Container(
        decoration: _wrapperDecoration,
        padding: _wrapperPadding,
        child: _build(context),
      );
    } else {
      child = _build(context);
    }
    if (paramters.aspectRatio != null) {
      return AspectRatio(
        aspectRatio: paramters.aspectRatio!,
        child: child,
      );
    } else {
      return child;
    }
  }

  Uri? _getBaseUrl(
      BuildContext context, String path, Map<String, String>? queryParameters) {
    var _url = Uri.tryParse(path);
    var schemes = ['Http', 'Https'];
    if (schemes.any((element) => _url?.isScheme(element) == true)) return _url;
    var remote = ShapedRemoteImageConfig.of(context)?.baseUrl;
    var _parsed =
        Uri.tryParse("$remote/${path.isNotEmpty == true ? path : ""}");
    var _normalized = _parsed?.replace(
      path: _parsed.path.replaceAll('//', '/'),
      queryParameters: queryParameters,
    );
    return _normalized;
  }

  Widget _build(BuildContext context) {
    var _url = _getBaseUrl(context, paramters.url, getQueryParameters(context));

    var child = _url != null
        ? WebImage(
            url: _url.toString(),
            width: paramters.width,
            height: paramters.height,
            errorPlaceholder: () =>
                buildError(context, paramters.height, paramters.height),
            fit: getFit(context),
          )
        : buildError(context, paramters.height, paramters.height);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: getDecoration(context) ?? BoxDecoration(),
      foregroundDecoration: getForgroundDecoration(context),
      padding: getInnerPadding(context),
      child: child,
    );
  }

  Widget buildError(BuildContext context, double? w, double? h) {
    return SizedBox(
      width: w,
      height: h,
      child: Center(
          child: getErrorPlaceholder(context) ??
              Icon(
                Icons.image,
                size: (paramters.width == null || paramters.width! < 50)
                    ? 20
                    : 40,
              )),
    );
  }
}

class HeroShapedRemoteImage extends StatelessWidget {
  final String tag;
  final _Paramters paramters;
  HeroShapedRemoteImage._({
    Key? key,
    required this.paramters,
    required this.tag,
  }) : super(key: key);
  factory HeroShapedRemoteImage({
    Key? key,
    required String url,
    required String tag,
    double? width,
    double? height,
    BoxFit? fit,
    Decoration? forgroundDecoration,
    ImageProvider? loadingPlaceholder,
    Widget? errorPlaceholder,
    Decoration? decoration,
    EdgeInsetsGeometry? outerPadding,
    EdgeInsetsGeometry? innerPadding,
    Decoration? outerDecoration,
    Map<String, String>? queryParamters,
  }) =>
      HeroShapedRemoteImage._(
        key: key,
        tag: tag,
        paramters: _Paramters(
          url: url,
          width: width,
          queryParamters: queryParamters,
          height: height,
          fit: fit,
          forgroundDecoration: forgroundDecoration,
          aspectRatio: null,
          loadingPlaceholder: loadingPlaceholder,
          errorPlaceholder: errorPlaceholder,
          decoration: decoration,
          outerPadding: outerPadding,
          innerPadding: innerPadding,
          outerDecoration: outerDecoration,
        ),
      );
  factory HeroShapedRemoteImage.aspectRatio({
    Key? key,
    required String url,
    required String tag,
    double aspectRatio = 1,
    Map<String, String>? queryParamters,
    BoxFit? fit,
    Decoration? forgroundDecoration,
    Widget? errorPlaceholder,
    ImageProvider? loadingPlaceholder,
    Decoration? decoration,
    EdgeInsetsGeometry? outerPadding,
    EdgeInsetsGeometry? innerPadding,
    Decoration? outerDecoration,
  }) =>
      HeroShapedRemoteImage._(
        key: key,
        tag: tag,
        paramters: _Paramters(
          url: url,
          width: null,
          queryParamters: queryParamters,
          height: null,
          fit: fit,
          forgroundDecoration: forgroundDecoration,
          aspectRatio: aspectRatio,
          errorPlaceholder: errorPlaceholder,
          loadingPlaceholder: loadingPlaceholder,
          decoration: decoration,
          outerPadding: outerPadding,
          innerPadding: innerPadding,
          outerDecoration: outerDecoration,
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: _flightShuttleBuilder,
      child: ShapedRemoteImage._(
        paramters: paramters,
      ),
    );
  }

  static Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    var fromImage =
        (((fromHeroContext.widget as Hero).child as ShapedRemoteImage));
    var toImage = (((toHeroContext.widget as Hero).child as ShapedRemoteImage));

    var isPush = flightDirection == HeroFlightDirection.push;
    var _animation = Tween(begin: isPush ? 0.0 : 1.0, end: isPush ? 1.0 : 0.0)
        .animate(animation);

    var _decorationTween = _animation.drive(
      DecorationTween(
        begin: fromImage.getDecoration(fromHeroContext) ?? BoxDecoration(),
        end: toImage.getDecoration(toHeroContext) ?? BoxDecoration(),
      ),
    );
    var _forgroundDecorationTween = _animation.drive(DecorationTween(
      begin:
          fromImage.getForgroundDecoration(fromHeroContext) ?? BoxDecoration(),
      end: toImage.getForgroundDecoration(toHeroContext) ?? BoxDecoration(),
    ));

    var _wrapperDecorationTween = _animation.drive(
      DecorationTween(
        begin: fromImage.getOuterDecoration(fromHeroContext) ?? BoxDecoration(),
        end: toImage.getOuterDecoration(toHeroContext) ?? BoxDecoration(),
      ),
    );
    var _wraperPaddingTween = _animation.drive(
      EdgeInsetsGeometryTween(
          begin: fromImage.getOuterPadding(fromHeroContext) ?? EdgeInsets.zero,
          end: toImage.getOuterPadding(toHeroContext) ?? EdgeInsets.zero),
    );
    var _innerPaddingTween = _animation.drive(EdgeInsetsGeometryTween(
      begin: toImage.getInnerPadding(fromHeroContext) ?? EdgeInsets.zero,
      end: toImage.getInnerPadding(toHeroContext) ?? EdgeInsets.zero,
    ));
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return ShapedRemoteImage._(
          paramters: toImage.paramters.copyWith(
            decoration: _decorationTween.value,
            forgroundDecoration: _forgroundDecorationTween.value,
            outerDecoration: _wrapperDecorationTween.value,
            outerPadding: _wraperPaddingTween.value,
            innerPadding: _innerPaddingTween.value,
          ),
        );
      },
    );
  }
}

class ShapedRemoteImageConfig extends StatelessWidget {
  final Widget child;
  final String? baseUrl;
  final Widget? errorPlaceholder;
  final Decoration? forgroundDecoration;
  final Decoration? decoration;
  final Decoration? outerDecoration;
  final EdgeInsetsGeometry? outerPadding;
  final EdgeInsetsGeometry? innerPadding;
  final Map<String, String>? queryParamters;
  final BoxFit fit;
  final ImageProvider? loadingPlaceholder;
  static ShapedRemoteImageConfig? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<ShapedRemoteImageConfig>();
  const ShapedRemoteImageConfig({
    Key? key,
    required this.child,
    this.errorPlaceholder,
    this.forgroundDecoration,
    this.decoration,
    this.outerDecoration,
    this.outerPadding,
    this.innerPadding,
    this.fit = BoxFit.contain,
    this.loadingPlaceholder,
    this.queryParamters,
    this.baseUrl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _Paramters {
  final String url;
  final Map<String, String>? queryParamters;
  final double? width;
  final double? height;

  final Widget? errorPlaceholder;
  final ImageProvider? loadingPlaceholder;
  final Decoration? forgroundDecoration;
  final Decoration? decoration;
  final Decoration? outerDecoration;
  final EdgeInsetsGeometry? outerPadding;
  final EdgeInsetsGeometry? innerPadding;
  final BoxFit? fit;
  final double? aspectRatio;

  _Paramters({
    required this.url,
    this.width,
    this.height,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.forgroundDecoration,
    this.decoration,
    this.outerDecoration,
    this.outerPadding,
    this.innerPadding,
    this.fit,
    this.aspectRatio,
    this.queryParamters,
  });

  _Paramters copyWith({
    String? url,
    double? width,
    double? height,
    ImageProvider? loadingPlaceholder,
    Widget? errorPlaceholder,
    Decoration? forgroundDecoration,
    Decoration? decoration,
    Decoration? outerDecoration,
    EdgeInsetsGeometry? outerPadding,
    EdgeInsetsGeometry? innerPadding,
    BoxFit? fit,
    double? aspectRatio,
    Map<String, String>? queryParamters,
  }) =>
      _Paramters(
        queryParamters: queryParamters ?? this.queryParamters,
        aspectRatio: aspectRatio ?? this.aspectRatio,
        url: url ?? this.url,
        width: width ?? this.width,
        height: height ?? this.height,
        loadingPlaceholder: loadingPlaceholder ?? this.loadingPlaceholder,
        errorPlaceholder: errorPlaceholder ?? this.errorPlaceholder,
        forgroundDecoration: forgroundDecoration ?? this.forgroundDecoration,
        decoration: decoration ?? this.decoration,
        outerDecoration: outerDecoration ?? this.outerDecoration,
        outerPadding: outerPadding ?? this.outerPadding,
        innerPadding: innerPadding ?? this.innerPadding,
        fit: fit ?? this.fit,
      );
}

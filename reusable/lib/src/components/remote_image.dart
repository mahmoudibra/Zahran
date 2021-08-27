import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';

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
    LoadingErrorWidgetBuilder? errorPlaceholder,
    ProgressIndicatorBuilder? loadingPlaceholder,
    Decoration? decoration,
    ImageRenderMethodForWeb? imageRenderMethodForWeb,
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
          imageRenderMethodForWeb: imageRenderMethodForWeb,
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
    LoadingErrorWidgetBuilder? errorPlaceholder,
    ProgressIndicatorBuilder? loadingPlaceholder,
    ImageRenderMethodForWeb? imageRenderMethodForWeb,
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
          imageRenderMethodForWeb: imageRenderMethodForWeb,
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

  ImageRenderMethodForWeb? getImageRenderMethodForWeb(BuildContext context) =>
      paramters.imageRenderMethodForWeb ??
      ShapedRemoteImageConfig.of(context)?.imageRenderMethodForWeb;
  LoadingErrorWidgetBuilder? getErrorPlaceholder(BuildContext context) =>
      paramters.errorPlaceholder ??
      ShapedRemoteImageConfig.of(context)?.errorPlaceholder;
  ProgressIndicatorBuilder? getLoadingPlaceholder(BuildContext context) =>
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
    var uri = Uri.tryParse(path);
    var schemes = ['Http', 'Https'];
    if (schemes.any((element) => uri?.isScheme(element) == true)) return uri;
    var remote = ShapedRemoteImageConfig.of(context)?.baseUrl;
    if (remote?.isNotEmpty != true) return uri;
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
        ? CachedNetworkImage(
            imageUrl: _url.toString(),
            width: paramters.width,
            height: paramters.height,
            imageRenderMethodForWeb: getImageRenderMethodForWeb(context) ??
                ImageRenderMethodForWeb.HtmlImage,
            httpHeaders: {
              'Accept-Language':
                  Localizations.maybeLocaleOf(context)?.languageCode ?? 'en',
            },
            errorWidget: getErrorPlaceholder(context) ??
                (_, __, ___) =>
                    buildError(_, paramters.height, paramters.height),
            fit: getFit(context),
            progressIndicatorBuilder: getLoadingPlaceholder(context) ??
                (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
          )
        : buildError(context, paramters.height, paramters.height);
    var decoration = getDecoration(context) ?? BoxDecoration();
    var radius = (decoration is BoxDecoration)
        ? decoration.borderRadius?.resolve(Directionality.of(context))
        : BorderRadius.zero;
    return Container(
      decoration: decoration,
      foregroundDecoration: getForgroundDecoration(context),
      padding: getInnerPadding(context),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: radius ?? BorderRadius.zero,
        child: child,
      ),
    );
  }

  Widget buildError(BuildContext context, double? w, double? h) {
    return Container(color: Colors.grey[400]);
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
    LoadingErrorWidgetBuilder? errorPlaceholder,
    ProgressIndicatorBuilder? loadingPlaceholder,
    Decoration? decoration,
    EdgeInsetsGeometry? outerPadding,
    EdgeInsetsGeometry? innerPadding,
    Decoration? outerDecoration,
    ImageRenderMethodForWeb? imageRenderMethodForWeb,
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
          imageRenderMethodForWeb: imageRenderMethodForWeb,
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
    LoadingErrorWidgetBuilder? errorPlaceholder,
    ProgressIndicatorBuilder? loadingPlaceholder,
    Decoration? decoration,
    EdgeInsetsGeometry? outerPadding,
    EdgeInsetsGeometry? innerPadding,
    ImageRenderMethodForWeb? imageRenderMethodForWeb,
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
          imageRenderMethodForWeb: imageRenderMethodForWeb,
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
  final LoadingErrorWidgetBuilder? errorPlaceholder;
  final ProgressIndicatorBuilder? loadingPlaceholder;
  final Decoration? forgroundDecoration;
  final Decoration? decoration;
  final Decoration? outerDecoration;
  final EdgeInsetsGeometry? outerPadding;
  final EdgeInsetsGeometry? innerPadding;
  final ImageRenderMethodForWeb? imageRenderMethodForWeb;
  final Map<String, String>? queryParamters;
  final BoxFit fit;
  static ShapedRemoteImageConfig? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<ShapedRemoteImageConfig>();
  const ShapedRemoteImageConfig({
    Key? key,
    required this.child,
    this.errorPlaceholder,
    this.forgroundDecoration,
    this.decoration,
    this.outerDecoration,
    this.imageRenderMethodForWeb,
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
  final ImageRenderMethodForWeb? imageRenderMethodForWeb;
  final LoadingErrorWidgetBuilder? errorPlaceholder;
  final ProgressIndicatorBuilder? loadingPlaceholder;
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
    this.imageRenderMethodForWeb,
  });

  _Paramters copyWith({
    String? url,
    double? width,
    double? height,
    LoadingErrorWidgetBuilder? errorPlaceholder,
    ProgressIndicatorBuilder? loadingPlaceholder,
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

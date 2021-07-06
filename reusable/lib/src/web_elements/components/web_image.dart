import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WebImage extends StatefulWidget {
  final String url;
  final double? width;
  final Widget Function()? errorPlaceholder;
  final double? height;
  final BoxFit fit;

  const WebImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.errorPlaceholder,
    required this.fit,
  }) : super(key: key);
  @override
  _WebImageState createState() => _WebImageState();
}

class _WebImageState extends State<WebImage> {
  StreamSubscription<Event>? lisner;
  bool hasError = false;
  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('imagelement', (int viewId) {
      var elm = ImageElement()
        ..id = viewId.toString()
        // ignore: unsafe_html
        ..src = widget.url;
      if (widget.width != null) {
        elm.width = widget.width!.toInt();
      }
      if (widget.height != null) {
        elm.height = widget.height!.toInt();
      }
      switch (widget.fit) {
        case BoxFit.contain:
          elm.style.objectFit = 'contain';
          break;
        case BoxFit.cover:
          elm.style.objectFit = 'cover';
          break;
        case BoxFit.fitWidth:
        case BoxFit.fitHeight:
        case BoxFit.fill:
          elm.style.objectFit = 'fill';
          break;
        case BoxFit.scaleDown:
          elm.style.objectFit = 'scale-down';
          break;
        case BoxFit.none:
          elm.style.objectFit = 'none';
          break;
      }
      lisner = elm.onError.asBroadcastStream().listen((event) {
        setState(() {
          hasError = true;
        });
      });
      return elm;
    });
    super.initState();
  }

  @override
  void dispose() {
    lisner?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasError && widget.errorPlaceholder != null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.errorPlaceholder!(),
      );
    }
    return HtmlElementView(
      key: UniqueKey(),
      viewType: 'imagelement',
    );
  }
}

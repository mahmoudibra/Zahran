import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../localization/tr.dart';

class ScaffoldListSilverAppBar extends StatefulWidget {
  final String title;
  final Widget content;

  ScaffoldListSilverAppBar({required this.title, required this.content});

  @override
  _ScaffoldListSilverAppBarState createState() =>
      _ScaffoldListSilverAppBarState();
}

class _ScaffoldListSilverAppBarState extends State<ScaffoldListSilverAppBar> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    super.initState();
  }

  Widget build(BuildContext context) {
    var title = widget.title;
    final expandedHeight = 120.0;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    elevation: 0.0,
                    pinned: true,
                    floating: true,
                    stretch: true,
                    centerTitle: true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    expandedHeight: expandedHeight,
                    leading: BackButton(
                        color: Theme.of(context).textTheme.headline6?.color),
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: _horizontalTitlePadding(expandedHeight),
                      ),
                      centerTitle: false,
                      title: ExpandableText(
                        value: title,
                        trimLines: 1,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      stretchModes: [StretchMode.zoomBackground],
                    ),
                  ),
                ];
              },
              body: Padding(
                padding:
                    EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 30),
                child: widget.content,
              )),
        ));
  }

  double _horizontalTitlePadding(double expandedHeight) {
    const kBasePadding = 20.0;
    const kMultiplier = 0.8;

    if (_scrollController.hasClients) {
      print("🚀🚀 offset: ${_scrollController.offset}");
      if (_scrollController.offset < (expandedHeight / 2)) {
        // In case 50%-100% of the expanded height is viewed
        print("🚀 In case 50%-100% value: $kBasePadding");
        return kBasePadding;
      }

      if (_scrollController.offset > (expandedHeight - kToolbarHeight)) {
        // In case 0% of the expanded height is viewed
        print("🚀 In case 50%-100% value: 50");
        return 50;
      }

      var value =
          (_scrollController.offset - (expandedHeight / 2)) * kMultiplier +
              kBasePadding;
      print("🚀In case 0%-50% value: $value");
      // In case 0%-50% of the expanded height is viewed
      return value;
    }

    return kBasePadding;
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    Key? key,
    required this.value,
    this.style,
    this.trimLines = 2,
  }) : super(key: key);

  final TextStyle? style;
  final String value;
  final int trimLines;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  final GlobalKey<State<Tooltip>> tooltipKey = GlobalKey<State<Tooltip>>();
  void _onTap() {
    final dynamic tooltip = tooltipKey.currentState;
    tooltip?.ensureTooltipVisible();
  }

  TextPainter spanPainter(
      BuildContext context, BoxConstraints constraints, InlineSpan span) {
    final double maxWidth = constraints.maxWidth;

    TextPainter textPainter = TextPainter(
      text: span,
      textDirection: Directionality.of(context),
      maxLines: widget.trimLines,
    );

    textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
    return textPainter;
  }

  @override
  Widget build(BuildContext context) {
    var buttonColor =
        Theme.of(context).textButtonTheme.style?.foregroundColor?.resolve({});
    var link = TextSpan(
      style: (widget.style ?? TextStyle()).copyWith(
        color: buttonColor,
        fontSize: 10,
      ),
      text: ' ... ${TR.of(context).showAll}',
      recognizer: TapGestureRecognizer()..onTap = _onTap,
    );
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        // Create a TextSpan with data
        final text = TextSpan(text: widget.value, style: widget.style);

        final linkSize = spanPainter(context, constraints, link).size;
        final textPainter = spanPainter(context, constraints, text);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int? endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        TextSpan? textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: widget.value.substring(0, endIndex),
            children: [link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.value,
          );
        }
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.topCenter,
          child: Tooltip(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10)),
            key: tooltipKey,
            margin: EdgeInsets.all(20).copyWith(top: 0),
            padding: EdgeInsets.zero,
            richMessage: WidgetSpan(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Text(widget.value),
              ),
              style: widget.style,
            ),
            triggerMode: TooltipTriggerMode.manual,
            child: Text.rich(
              textSpan,
              softWrap: true,
              style: widget.style,
              overflow: TextOverflow.clip,
            ),
          ),
        );
      },
    );
    return result;
  }
}

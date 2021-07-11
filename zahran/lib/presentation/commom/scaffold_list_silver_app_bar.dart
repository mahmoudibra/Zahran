import 'package:flutter/material.dart';

class ScaffoldListSilverAppBar extends StatefulWidget {
  final String title;
  final Widget content;

  ScaffoldListSilverAppBar({required this.title, required this.content});

  @override
  _ScaffoldListSilverAppBarState createState() => _ScaffoldListSilverAppBarState();
}

class _ScaffoldListSilverAppBarState extends State<ScaffoldListSilverAppBar> {
  ScrollController _scrollController = ScrollController();
  final expandedHeight = 120.0;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    elevation: 0.0,
                    pinned: true,
                    floating: true,
                    stretch: true,
                    centerTitle: true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    expandedHeight: expandedHeight,
                    leading: BackButton(color: Theme.of(context).textTheme.headline6?.color),
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: _horizontalTitlePadding),
                      centerTitle: false,
                      title: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      stretchModes: [StretchMode.zoomBackground],
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 30),
                child: widget.content,
              )),
        ));
  }

  double get _horizontalTitlePadding {
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

      var value = (_scrollController.offset - (expandedHeight / 2)) * kMultiplier + kBasePadding;
      print("🚀In case 0%-50% value: $value");
      // In case 0%-50% of the expanded height is viewed
      return value;
    }

    return kBasePadding;
  }
}

library complete_list;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

part 'grids.dart';
part 'labels.dart';
part 'list_controller_and_label.dart';
part 'placeholders.dart';
part 'refresh_indecators.dart';

class ShimmerEffect {
  final Widget Function() _builder;
  final BlendMode? blendMode;
  Widget get child => _builder();
  ShimmerEffect({
    required Widget Function() builder,
    this.blendMode,
  }) : _builder = builder;
}

class CompleteList<TItem, TController extends BaseListController<TItem>>
    extends StatefulWidget {
  final bool keepAlive;
  final ScrollController? scrollController;
  final List<Widget> Function(TController controller)? headers;
  final List<Widget> Function(TController controller)? innerHeaders;
  final List<Widget> Function(TController controller)? footers;
  final List<Widget> Function(TController controller)? innerFooters;
  final List<Widget> Function(TController controller)? center;
  final Iterable<TItem> Function(TController controller)? filterItems;
  final ScrollPhysics? physics;
  final bool reverse;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final bool Function(TController controller) shrinkWrap;
  final bool enablePullUp;
  final Axis axis;
  final bool enablePullDown;
  final ListPlaceHolder? placeholder;
  final Widget Function(TItem item, int index)? builItem;
  final ShimmerEffect? shimmer;
  final SliverStaggeredGridDelegate Function(int length)? gridDelegate;
  final TController init;
  final String? tag;
  const CompleteList._(
      {required Key? key,
      required this.init,
      required this.axis,
      required this.headers,
      required this.footers,
      required this.center,
      required this.builItem,
      required this.reverse,
      required this.shrinkWrap,
      required this.enablePullUp,
      required this.enablePullDown,
      required this.padding,
      required this.scrollController,
      required this.keepAlive,
      required this.constraints,
      required this.tag,
      required this.placeholder,
      required this.shimmer,
      required this.gridDelegate,
      required this.innerFooters,
      required this.innerHeaders,
      required this.physics,
      required this.filterItems})
      : super(key: key);

  factory CompleteList.slivers({
    Key? key,
    bool keepAlive = true,
    ScrollController? scrollController,
    List<Widget> Function(TController controller)? headers,
    List<Widget> Function(TController controller)? innerFooters,
    List<Widget> Function(TController controller)? innerHeaders,
    List<Widget> Function(TController controller)? footers,
    required List<Widget> Function(TController controller) center,
    bool enablePullUp = true,
    Axis axis = Axis.vertical,
    BoxConstraints? constraints,
    bool enablePullDown = true,
    ShimmerEffect? shimmerBuilder,
    required TController init,
    ListPlaceHolder? placeholder,
    bool reverse = false,
    ScrollPhysics? physics,
    bool Function(TController controller)? shrinkWrap,
    Iterable<TItem> Function(TController controller)? filterItems,
    String? tag,
  }) =>
      CompleteList._(
        key: key,
        init: init,
        physics: physics,
        filterItems: filterItems,
        placeholder: placeholder,
        tag: tag,
        shimmer: shimmerBuilder,
        gridDelegate: null,
        keepAlive: keepAlive,
        scrollController: scrollController,
        headers: headers,
        innerFooters: innerFooters,
        innerHeaders: innerHeaders,
        axis: axis,
        constraints: constraints,
        footers: footers,
        center: center,
        padding: null,
        builItem: null,
        reverse: reverse,
        shrinkWrap: shrinkWrap ?? (v) => false,
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
      );

  factory CompleteList.sliversWithList(
          {Key? key,
          bool keepAlive = true,
          ScrollController? scrollController,
          List<Widget> Function(TController controller)? headers,
          List<Widget> Function(TController controller)? innerFooters,
          List<Widget> Function(TController controller)? innerHeaders,
          List<Widget> Function(TController controller)? footers,
          Iterable<TItem> Function(TController controller)? filterItems,
          EdgeInsetsGeometry? padding,
          bool enablePullUp = true,
          Axis axis = Axis.vertical,
          ShimmerEffect? itemShimmer,
          BoxConstraints? constraints,
          bool Function(TController controller)? shrinkWrap,
          bool enablePullDown = true,
          required Widget Function(TItem item, int index) builItem,
          required TController init,
          ListPlaceHolder? placeholder,
          bool reverse = false,
          String? tag,
          ScrollPhysics? physics}) =>
      CompleteList._(
        key: key,
        init: init,
        physics: physics,
        tag: tag,
        filterItems: filterItems,
        placeholder: placeholder,
        shrinkWrap: shrinkWrap ?? (v) => false,
        gridDelegate: null,
        axis: axis,
        keepAlive: keepAlive,
        scrollController: scrollController,
        headers: headers,
        innerFooters: innerFooters,
        innerHeaders: innerHeaders,
        constraints: constraints,
        footers: footers,
        center: null,
        padding: padding ?? EdgeInsets.zero,
        builItem: builItem,
        shimmer: itemShimmer,
        reverse: reverse,
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
      );

  /// [SliverStaggeredGridDelegateWithFixedCrossAxisCount]
  /// [SliverStaggeredGridDelegateWithMaxCrossAxisExtent]
  /// You can use [Grids.columns_1] [Grids.columns_2] etc...
  factory CompleteList.sliversWithGrid({
    Key? key,
    bool keepAlive = true,
    ScrollController? scrollController,
    List<Widget> Function(TController controller)? headers,
    List<Widget> Function(TController controller)? innerFooters,
    List<Widget> Function(TController controller)? innerHeaders,
    List<Widget> Function(TController controller)? footers,
    Iterable<TItem> Function(TController controller)? filterItems,
    bool reverse = false,
    bool Function(TController controller)? shrinkWrap,
    EdgeInsetsGeometry? padding,
    bool enablePullUp = true,
    Axis axis = Axis.vertical,
    ScrollPhysics? physics,
    ShimmerEffect? itemShimmer,
    BoxConstraints? constraints,
    bool enablePullDown = true,
    required Widget Function(TItem item, int index) builItem,
    required TController init,
    ListPlaceHolder? placeholder,
    required SliverStaggeredGridDelegate Function(int length) gridDelegate,
    String? tag,
  }) =>
      CompleteList._(
        key: key,
        init: init,
        physics: physics,
        filterItems: filterItems,
        tag: tag,
        placeholder: placeholder,
        gridDelegate: gridDelegate,
        axis: axis,
        keepAlive: keepAlive,
        scrollController: scrollController,
        headers: headers,
        innerFooters: innerFooters,
        innerHeaders: innerHeaders,
        constraints: constraints,
        footers: footers,
        center: null,
        padding: padding ?? EdgeInsets.zero,
        builItem: builItem,
        shimmer: itemShimmer,
        reverse: reverse,
        shrinkWrap: shrinkWrap ?? (v) => false,
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
      );

  static _CompleteListState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CompleteListState>();
  @override
  _CompleteListState<TItem, TController> createState() =>
      _CompleteListState<TItem, TController>();
}

class _CompleteListState<TItem, TController extends BaseListController<TItem>>
    extends State<CompleteList<TItem, TController>>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late AnimationController _rereshController;
  bool refreshing = false;
  bool willRefresh = false;
  final deltaExtent = 75.0;
  bool _firstBuild = true;
  bool get firstBuild => _firstBuild;
  ListPlaceHolder get placeholder =>
      widget.placeholder ??
      CompleteListConfig.of(context)?.widget.placeholder ??
      ListPlaceHolder();
  Labels get labels => placeholder.getLabels(context);

  @override
  void initState() {
    _rereshController = AnimationController(
      upperBound: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _rereshController.dispose();
    super.dispose();
  }

  Future refresh(ListPaging controller) async {
    if (refreshing) return;
    setState(() {
      refreshing = true;
    });
    await _rereshController.animateTo(1.0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInCubic);
    await controller.refreshApi().catchError((e) {});
    refreshing = false;
    willRefresh = false;
    await _rereshController.animateTo(0.0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInCubic);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Localizations.maybeLocaleOf(context);
    return GetBuilder(
      init: widget.init,
      tag: widget.tag,
      builder: (TController _ctrl) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var items = widget.filterItems == null
                ? _ctrl.items
                : widget.filterItems!(_ctrl);
            if (items.isEmpty) _firstBuild = true;
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              if (firstBuild && items.isNotEmpty) _firstBuild = false;
            });
            return _build(_ctrl, items, constraints);
          },
        );
      },
    );
  }

  Widget _build(
      TController _ctrl, Iterable<TItem> items, BoxConstraints constraints) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (_ctrl.paging != null) {
          var __ctrl = _ctrl.paging!;
          if (__ctrl.length > 0 || !__ctrl.hasError) {
            if (scrollInfo.metrics.pixels > 0) {
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
                if (!__ctrl.gotAllItems && !__ctrl.loadingMore) {
                  __ctrl.loadNextApi();
                }
              }
            } else {
              var currentExtent = scrollInfo.metrics.pixels * -1;
              if (currentExtent < 0) currentExtent = 0;

              var percent = (currentExtent / deltaExtent);

              if (!willRefresh || scrollInfo.metrics.pixels > deltaExtent) {
                _rereshController.value = percent;
              } else if (!scrollInfo.metrics.outOfRange && willRefresh) {
                refresh(__ctrl);
              }
              if (percent > 1 && !willRefresh) {
                setState(() {
                  willRefresh = true;
                });
              }
            }
          }
        }
        return false;
      },
      child: CustomScrollView(
        physics: refreshing
            ? ClampingScrollPhysics()
            : (widget.physics ?? BouncingScrollPhysics()),
        scrollDirection: widget.axis,
        shrinkWrap: widget.shrinkWrap(_ctrl),
        reverse: widget.reverse,
        slivers: [
          if (widget.headers != null) ...widget.headers!(_ctrl),
          if (widget.enablePullDown == true && _ctrl.paging != null)
            _RefreshIndicator(
              deltaExtent: deltaExtent,
              lisnable: _rereshController,
              showLoader: refreshing,
            ),
          if (widget.innerHeaders != null) ...widget.innerHeaders!(_ctrl),
          if (items.isEmpty) ...[
            if (_ctrl.paging?.fullScreenLoad == true &&
                widget.shimmer != null) ...[
              sliverShimmers(_ctrl.paging!, context)
            ] else
              buuldPlaceholders(_ctrl, constraints),
          ] else ...[
            if (widget.center != null)
              ...widget.center!(_ctrl)
            else if (widget.gridDelegate != null)
              SliverPadding(
                padding: widget.padding ?? EdgeInsets.zero,
                sliver: SliverStaggeredGrid(
                  gridDelegate: widget.gridDelegate!(items.length),
                  delegate: SliverChildBuilderDelegate((ctx, i) {
                    return buildItem(items, i);
                  }, childCount: items.length),
                ),
              )
            else
              SliverPadding(
                padding: widget.padding ?? EdgeInsets.zero,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((ctx, i) {
                    return buildItem(items, i);
                  }, childCount: items.length),
                ),
              ),
            if (widget.innerFooters != null) ...widget.innerFooters!(_ctrl),
            if (widget.enablePullUp == true &&
                items.isNotEmpty &&
                _ctrl.paging != null)
              _FooterLoading(
                shrinkWrap: widget.shrinkWrap(_ctrl),
                labels: labels,
                controller: _ctrl.paging!,
              ),
          ],
          if (widget.footers != null) ...widget.footers!(_ctrl),
          SliverSpacer.safeArea(),
        ],
      ),
    );
  }

  Widget buuldPlaceholders(TController _ctrl, BoxConstraints constraints) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: SizedBox(
        height: widget.shrinkWrap(_ctrl) == true && widget.axis == Axis.vertical
            ? null
            : constraints.maxHeight == double.infinity
                ? null
                : constraints.maxHeight,
        width:
            widget.shrinkWrap(_ctrl) == true && widget.axis == Axis.horizontal
                ? null
                : constraints.maxWidth == double.infinity
                    ? null
                    : constraints.maxWidth,
        child: _ListPlaceHolder(
          controller: _ctrl,
          child: placeholder.build(context),
        ),
      ),
    );
  }

  SliverPadding sliverShimmers(ListPaging _ctrl, BuildContext context) {
    return SliverPadding(
      padding: widget.padding ?? EdgeInsets.zero,
      sliver: SliverToBoxAdapter(
        child: ShimmerView(
          blendMode: widget.shimmer?.blendMode,
          loading: widget.shimmer != null && _ctrl.fullScreenLoad,
          direction: widget.axis == Axis.horizontal
              ? (Directionality.of(context) == TextDirection.rtl
                  ? ShimmerDirection.rtl
                  : ShimmerDirection.ltr)
              : ShimmerDirection.ttb,
          child: (widget.gridDelegate != null)
              ? StaggeredGridView.builder(
                  shrinkWrap: true,
                  scrollDirection: widget.axis,
                  gridDelegate: widget.gridDelegate!(30),
                  itemBuilder: (BuildContext context, int index) {
                    return widget.shimmer!.child;
                  },
                  itemCount: 30,
                )
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: widget.axis,
                  itemBuilder: (BuildContext context, int index) {
                    return widget.shimmer!.child;
                  },
                  itemCount: 30,
                ),
        ),
      ),
    );
  }

  Widget buildItem(Iterable<TItem> items, int index) {
    if (index >= items.length) {
      if (widget.shimmer != null) return widget.shimmer!.child;
      return SizedBox.shrink();
    }
    Widget child;
    if (widget.builItem == null) {
      child = Card(
        child: Text('Item num: $index'),
      );
    } else {
      child = widget.builItem!(items.elementAt(index), index);
    }

    return AnimatedItemConfig(
      index: index,
      firstBuild: firstBuild,
      child: child,
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}

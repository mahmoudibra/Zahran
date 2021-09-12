part of base_list;

extension DataColumnExtension on List<String> {
  List<DataColumn> toDataColumns() {
    return map((e) {
      return DataColumn(label: Text(e));
    }).toList();
  }
}

extension DataColumnSingleExtension on String {
  DataColumn toDataColumns(
      {bool numeric = false, DataColumnSortCallback? onSort}) {
    return DataColumn(
      label: Text('$this'),
      numeric: numeric,
      onSort: onSort,
    );
  }
}

enum ResponsiveDataTableType { table, list, auto }
enum LayoutType { wide, small, medium }
typedef BuildItemCallBack<T> = List<Widget> Function(int index, T item);

class ResponsiveDataTable<T, TController extends DataTableController<T>>
    extends InheritedWidget {
  final Widget? selectionButton;
  final bool canRefresh;
  final Widget? Function(T item)? expansionTrailing;
  final List<Widget>? options;
  final ResponsiveDataTableType type;
  final VoidCallback? export;
  final List<DataColumn> headers;
  final BuildItemCallBack<T> buildItem;
  final Widget Function(int index, T item, bool phone)? buildPhoneOrTabletItem;
  final Function(BuildContext context)? onCreate;
  final List<DataTableAction<T>> Function(TController controller)? actions;
  final TController controller;
  final int Function(LayoutType type)? listCrossAxis;
  final String? tag;
  final List<Widget> Function(TController controller)? filters;
  final int mobileViewTitleIndex;
  final bool keepAlive;
  ResponsiveDataTable({
    Key? key,
    this.buildPhoneOrTabletItem,
    this.listCrossAxis,
    this.expansionTrailing,
    this.export,
    this.keepAlive = true,
    this.options,
    this.type = ResponsiveDataTableType.auto,
    required this.headers,
    required this.buildItem,
    this.onCreate,
    required this.mobileViewTitleIndex,
    this.actions,
    required this.controller,
    this.tag,
    this.selectionButton,
    this.filters,
    this.canRefresh = true,
  }) : super(
          key: key,
          child: GetBuilder(
            init: controller,
            tag: tag,
            builder: (TController controller) {
              return _ResponsiveDataTable<T, TController>(controller, type);
            },
          ),
        );

  @override
  bool updateShouldNotify(ResponsiveDataTable<T, TController> oldWidget) {
    return export != oldWidget.export ||
        options != oldWidget.options ||
        buildItem != oldWidget.buildItem ||
        expansionTrailing != oldWidget.expansionTrailing ||
        onCreate != oldWidget.onCreate ||
        actions != oldWidget.actions ||
        type != oldWidget.type ||
        tag != oldWidget.tag ||
        filters != oldWidget.filters ||
        canRefresh != oldWidget.canRefresh ||
        selectionButton != oldWidget.selectionButton ||
        headers != oldWidget.headers;
  }
}

class _ResponsiveDataTable<T, TController extends DataTableController<T>>
    extends StatefulWidget {
  final TController controller;
  final ResponsiveDataTableType type;
  _ResponsiveDataTable(this.controller, this.type);

  @override
  __ResponsiveDataTableState<T, TController> createState() =>
      __ResponsiveDataTableState<T, TController>();
}

class __ResponsiveDataTableState<T, TController extends DataTableController<T>>
    extends State<_ResponsiveDataTable<T, TController>>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  ResponsiveDataTable<T, TController>? getOptions(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<
          ResponsiveDataTable<T, TController>>();
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var layout = constraints.maxWidth < 700
            ? LayoutType.small
            : (constraints.maxWidth < 1200
                ? LayoutType.medium
                : LayoutType.wide);
        if (widget.type == ResponsiveDataTableType.list) {
          return list(context, layout);
        }
        if (widget.type == ResponsiveDataTableType.table) {
          return dataTable(context);
        }
        if (constraints.maxWidth < 1000) return list(context, layout);
        return dataTable(context);
      },
    );
  }

  Widget dataTable(BuildContext context) {
    var options = getOptions(context)!;
    return _DataTable<T, TController>(
      controller: widget.controller,
      options: options,
      actions:
          options.actions == null ? [] : options.actions!(widget.controller),
    );
  }

  Widget list(BuildContext context, LayoutType layout) {
    var options = getOptions(context)!;
    var filters = <Widget>[];
    if (options.filters != null) filters = options.filters!(widget.controller);
    var buttons = [
      if (!widget.controller.hasSelection) ...[
        if (options.options != null)
          for (var option in options.options!)
            if (option is IconButton) CircleAvatar(child: option) else option,
        if (filters.isNotEmpty)
          CircleAvatar(
            child: _FiltersButton(
              filters: filters,
              controller: widget.controller,
            ),
          ),
        if (options.export != null)
          CircleAvatar(
            child: _ExportButton(
              export: options.export!,
              controller: widget.controller,
            ),
          ),
        if (options.onCreate != null)
          CircleAvatar(
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: (widget.controller.paging?.loading == true)
                    ? Theme.of(context).disabledColor
                    : null,
              ),
              onPressed: (widget.controller.paging?.loading == true)
                  ? null
                  : () {
                      options.onCreate!(context);
                    },
            ),
          ),
      ],
    ];
    var canSelect = (options.selectionButton != null);
    var crossAxis = 2;
    if (options.listCrossAxis != null) {
      crossAxis = options.listCrossAxis!(layout);
    } else {
      switch (layout) {
        case LayoutType.wide:
          crossAxis = 3;
          break;
        case LayoutType.small:
          crossAxis = 1;
          break;
        case LayoutType.medium:
          crossAxis = 2;
          break;
      }
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: CompleteList.sliversWithGrid(
              key: Key('$layout'),
              keepAlive: options.keepAlive,
              init: widget.controller,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20)
                  .copyWith(bottom: buttons.isNotEmpty || canSelect ? 70 : 20),
              enablePullDown: options.canRefresh,
              builItem: (T item, int index) {
                return slideFadeItem(index, item, context, false);
              },
              headers: (c) {
                return [
                  if (canSelect)
                    _selectionHeader(
                        context,
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: widget.controller.hasSelection ? 1 : 0,
                          child: AbsorbPointer(
                            absorbing: !widget.controller.hasSelection,
                            child: options.selectionButton!,
                          ),
                        )),
                ];
              },
              gridDelegate: (int length) {
                return SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxis,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  staggeredTileCount: length,
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                );
              },
            ),
          ),
        ),
        if (buttons.isNotEmpty || canSelect) ...[
          PositionedDirectional(
            bottom: 20,
            end: 14,
            start: 14,
            height: 50,
            child: SafeArea(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Flow(
                  clipBehavior: Clip.none,
                  delegate: _FlowMenuDelegate(menuAnimation: controller),
                  children: [
                    for (var btn in buttons) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: btn,
                      ),
                    ],
                    _toggleButton(),
                  ],
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }

  SliverAppBar _selectionHeader(BuildContext context, Widget trailing) {
    return SliverAppBar(
      pinned: true,
      leading: SizedBox(),
      leadingWidth: 0,
      title: ListTile(
        contentPadding: EdgeInsets.zero,
        trailing: trailing,
        title: Text(
          MaterialLocalizations.of(context)
              .selectedRowCountTitle(widget.controller.selectedItems.length),
        ),
        leading: Checkbox(
          tristate: true,
          onChanged: (v) {
            return !widget.controller.allSelected
                ? widget.controller.selectAll()
                : widget.controller.unSelectAll();
          },
          value: widget.controller.allSelected
              ? true
              : (widget.controller.hasSelection ? null : false),
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
    );
  }

  Widget _toggleButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        child: IconButton(
          onPressed: () {
            if (controller.isAnimating) {
              if (controller.status == AnimationStatus.forward) {
                controller.reverse();
              } else {
                controller.forward();
              }
            } else {
              if (controller.value == 1) {
                controller.reverse();
              } else {
                controller.forward();
              }
            }
          },
          icon: AnimatedIcon(
            progress: animation,
            icon: AnimatedIcons.menu_close,
          ),
        ),
      ),
    );
  }

  Widget slideFadeItem(int index, T item, BuildContext context, bool phone) {
    var options = getOptions(context)!;
    var widgets = options.buildItem(index, item);
    var actions =
        options.actions == null ? [] : options.actions!(widget.controller);
    if (options.buildPhoneOrTabletItem != null) {
      return options.buildPhoneOrTabletItem!(index, item, phone);
    }
    return SlideFadeItem(
      offset: (c) => Offset(c.maxWidth * (phone || index.isEven ? 1 : -1), 0),
      child: Card(
        child: ExpansionTile(
          title: widgets[options.mobileViewTitleIndex],
          initiallyExpanded: widgets.length < 5,
          trailing: options.expansionTrailing == null
              ? null
              : options.expansionTrailing!(item),
          leading: options.selectionButton == null
              ? null
              : Checkbox(
                  value: widget.controller.isSelected(index),
                  onChanged: (v) {
                    if (v == true) {
                      widget.controller.selectItem(index);
                    } else {
                      widget.controller.unselectItem(index);
                    }
                  }),
          children: [
            for (var i = 0; i < widgets.length; i++)
              if (options.mobileViewTitleIndex != i)
                _Info(
                  title: options.headers[i].label,
                  body: widgets[i],
                ),
            if (actions.isNotEmpty) ...[
              Divider(color: Theme.of(context).dividerColor),
              ButtonBar(
                children: [
                  for (var action in actions)
                    LoadingButton(
                      tooltip: action.toolTip(context, item),
                      enabled: (loading) => action.enabled(item) && !loading,
                      load: () async {
                        await action.action(context, item);
                      },
                      icon: Icon(
                        action.icon(item),
                        color: action.enabled(item) ? action.color(item) : null,
                      ),
                    )
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}

class _FlowMenuDelegate extends FlowDelegate {
  _FlowMenuDelegate({required this.menuAnimation})
      : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(_FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    var dx = 0.0;

    for (var i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i;

      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          dx * menuAnimation.value,
          0,
          0,
        ),
      );
    }
  }
}

class _Info extends StatelessWidget {
  final Widget title;
  final Widget body;
  final CrossAxisAlignment? alignment;
  const _Info(
      {Key? key, required this.title, required this.body, this.alignment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
        children: [
          title,
          SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: AccentText.bodyText2(child: body),
            ),
          ),
        ],
      ),
    );
  }
}

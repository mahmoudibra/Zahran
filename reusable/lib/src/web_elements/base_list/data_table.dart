library base_list;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';

part 'data_table_action.dart';
part 'data_table_controller.dart';
part 'data_table_source.dart';
part 'date_time_filter.dart';
part 'export_button.dart';
part 'filters_button.dart';
part 'interfaces.dart';
part 'loading_button.dart';
part 'responsive_data_table.dart';
part 'search_filter.dart';
part 'single_option_filters.dart';
part 'time_filter.dart';
part 'toggle_filter.dart';

class _DataTable<T, TController extends DataTableController<T>>
    extends StatefulWidget {
  final ResponsiveDataTable<T, TController> options;
  final TController controller;
  final List<DataTableAction<T>> actions;
  const _DataTable({
    Key? key,
    required this.options,
    required this.controller,
    required this.actions,
  }) : super(key: key);
  @override
  __DataTableState<T, TController> createState() =>
      __DataTableState<T, TController>();
}

class __DataTableState<T, TController extends DataTableController<T>>
    extends State<_DataTable<T, TController>>
    with AutomaticKeepAliveClientMixin {
  ResponsiveDataTable<T, TController> get options => widget.options;
  late _DataTableSource<T> source;
  TController get controller => widget.controller;
  int _currentPage = 0;
  @override
  void initState() {
    source = _DataTableSource<T>(
      controller: widget.controller,
      columns: options.headers.length + (widget.actions.isNotEmpty ? 1 : 0),
      buildItem: (controller, index, item) => buildRow(index, item),
      allowSelection: options.selectionButton != null,
    );
    super.initState();
  }

  @override
  void dispose() {
    source.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    source.checkLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Theme(
        data: Theme.of(context).copyWith(
          cardTheme: CardTheme(
            clipBehavior: Clip.none,
            margin: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(),
            elevation: 0,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (controller.paging?.fullScreenLoad == true &&
                ModalRoute.of(context)!.isCurrent)
              Positioned.fill(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
            else
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, size) {
                    var _preferedRows = ((size.maxHeight - 170) ~/ 48);
                    var actions = buildHeaderActions();
                    return Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsetsDirectional.only(end: 20, start: 20),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minWidth: size.minWidth, maxWidth: size.maxWidth),
                          child: PaginatedDataTable(
                            columns: [
                              ...options.headers,
                              if (widget.actions.isNotEmpty)
                                DataColumn(label: Text('')),
                            ],
                            source: source,
                            actions: actions.isEmpty ? null : actions,
                            header: (controller.paging != null &&
                                    options.canRefresh)
                                .onTrue(
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: InkWell(
                                  onTap: (controller.paging?.loading == true)
                                      .onFalse(() {
                                    controller.paging?.refreshApi();
                                  }),
                                  child: (controller.paging?.refreshing == true)
                                      .onTrue(Builder(builder: (context) {
                                    return SizedBox(
                                      width: IconTheme.of(context).size,
                                      height: IconTheme.of(context).size,
                                      child: CircularProgressIndicator(),
                                    );
                                  }), Icon(Icons.refresh)),
                                ),
                              ),
                              actions.isEmpty ? null : SizedBox(),
                            ),
                            availableRowsPerPage:
                                controller._availableRowsCount(_preferedRows),
                            rowsPerPage: controller.rowsPerpage(_preferedRows),
                            onPageChanged: (v) {
                              setState(() {
                                _currentPage = v;
                              });
                              if (controller.rowsPerpage(_preferedRows) *
                                      _currentPage >
                                  controller.length) {
                                print(controller.length);
                                controller.paging!.loadNextApi();
                              }
                            },
                            onRowsPerPageChanged: (v) {
                              if (v == null) return;
                              if (controller.rowsPerpage(_preferedRows) == v) {
                                return;
                              }
                              controller.setRowsPerpage(v);

                              if (controller.rowsPerpage(_preferedRows) *
                                      _currentPage >
                                  controller.length) {
                                controller.paging?.loadNextApi();
                              }
                            },
                            onSelectAll: (v) => v == true
                                ? controller.selectAll()
                                : controller.unSelectAll(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildHeaderActions() {
    var filters = <Widget>[];
    if (options.filters != null) filters = options.filters!(controller);
    return [
      if (options.selectionButton != null)
        AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: widget.controller.hasSelection ? 1 : 0,
          child: AbsorbPointer(
            absorbing: !widget.controller.hasSelection,
            child: options.selectionButton!,
          ),
        ),
      if (options.options != null) ...options.options!,
      if (options.export != null)
        _ExportButton(
          export: options.export!,
          controller: controller,
        ),
      if (filters.isNotEmpty)
        _FiltersButton(
          filters: filters,
          controller: controller,
        ),
      if (options.onCreate != null) ...[
        IconButton(
          iconSize: 35,
          icon: Icon(
            Icons.add,
            color: (controller.paging?.loading == true)
                ? Theme.of(context).disabledColor
                : null,
          ),
          onPressed: (controller.paging?.loading == true)
              ? null
              : () {
                  options.onCreate!(context);
                },
        ),
      ],
    ];
  }

  //! build row and add actions
  List<Widget> buildRow(int index, T item) {
    var items = options.buildItem(index, item);
    var cells = <Widget>[];
    for (var item in items) {
      cells.add(ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300, minWidth: 20),
        child: item,
      ));
    }

    if (widget.actions.isNotEmpty) {
      cells.add(
        Builder(builder: (context) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300, minWidth: 50),
            child: ButtonBar(
              alignment: MainAxisAlignment.end,
              children: buildRowActions(context, item, index),
            ),
          );
        }),
      );
    }
    return cells;
  }

  List<Widget> buildRowActions(BuildContext context, item, int index) {
    return <Widget>[
      if (widget.actions.isNotEmpty)
        for (var action in widget.actions)
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
    ];
  }

  @override
  bool get wantKeepAlive => options.keepAlive;
}

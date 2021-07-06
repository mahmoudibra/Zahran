part of base_list;

class _DataTableSource<T> extends DataTableSource {
  Locale? _lastLocale;
  final int columns;
  final DataTableController<T> controller;
  final List<Widget> Function(DataTableController<T> ctrl, int index, T item)
      buildItem;

  final bool allowSelection;
  void _onChanged() {
    notifyListeners();
  }

  _DataTableSource({
    required this.buildItem,
    required this.columns,
    required this.controller,
    required this.allowSelection,
  }) {
    controller.removeListener(_onChanged);
    controller.addListener(_onChanged);
  }
  @override
  void dispose() {
    controller.removeListener(_onChanged);
    super.dispose();
  }

  void checkLocale(BuildContext context) {
    var _locale = Localizations.maybeLocaleOf(context);
    if (_lastLocale?.languageCode != _locale?.languageCode) notifyListeners();
    _lastLocale = _locale;
  }

  @override
  DataRow getRow(int index) {
    if (index >= controller.length) {
      return DataRow(
        cells: List.filled(
            columns,
            DataCell(controller.paging?.loading == true
                ? ShimmerView(
                    loading: true,
                    child: ShimmerContainer(100, 20),
                  )
                : SizedBox())),
      );
    }
    return DataRow(
      selected: controller.isSelected(index) && allowSelection,
      onSelectChanged: !allowSelection
          ? null
          : (v) {
              if (v == true) {
                controller.selectItem(index);
              } else {
                controller.unselectItem(index);
              }
            },
      cells: buildItem(controller, index, controller[index]).map((e) {
        return DataCell(e);
      }).toList(),
    );
  }

  @override
  bool get isRowCountApproximate {
    if (controller.paging != null) {
      var _ctrl = controller.paging!;
      return _ctrl.total != null &&
          _ctrl.length < _ctrl.total! &&
          !_ctrl.loading;
    }
    return false;
  }

  @override
  int get rowCount {
    if (controller.paging != null) {
      var _ctrl = controller.paging!;
      return _ctrl.total ??
          (_ctrl.length + (_ctrl.loadingMore || _ctrl.fullScreenLoad ? 50 : 0));
    }
    return controller.length;
  }

  @override
  int get selectedRowCount => controller.allSelected
      ? controller.length
      : controller.selectedItems.length;
}

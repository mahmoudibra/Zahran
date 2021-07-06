part of base_list;

mixin DataTableController<T> on BaseListController<T> {
  List<int> _selectedItems = List<int>.empty(growable: true);
  List<int> get selectedItems => _selectedItems;
  List<int> get availableounts => [10, 25, 50, 75, 100];
  List<int> _availableRowsCount(int _prefered) {
    var list = [rowsPerpage(_prefered), _prefered, ...availableounts];
    list = list.toSet().toList();
    list.sort();
    return list;
  }

  int? _rowsPerpage;
  int rowsPerpage(int _default) => _rowsPerpage ?? _default;
  void setRowsPerpage(int i) {
    _rowsPerpage = i;
    update();
  }

  bool get allSelected => selectedItems.length == items.length;

  void selectAll() {
    if (!allSelected) {
      _selectedItems = List.generate(items.length, (index) => index);
      update();
    }
  }

  void unSelectAll() {
    selectedItems.clear();
    update();
  }

  void selectItem(int index) {
    if (!selectedItems.contains(index)) {
      selectedItems.add(index);
      update();
    }
  }

  void unselectItem(int index) {
    if (selectedItems.contains(index)) {
      selectedItems.remove(index);
      update();
    }
  }

  bool isSelected(int index) => selectedItems.contains(index);

  bool get hasSelection => selectedItems.isNotEmpty;

  @override
  void update([List<Object>? ids, bool condition = true]) {
    selectedItems.removeWhere((a) => a >= items.length);

    super.update(ids, condition);
  }
}

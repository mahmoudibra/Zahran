part of complete_list;

abstract class BaseListController<TItem> extends GetxController {
  Iterable<TItem> get items;
  int get length => items.length;
  TItem operator [](int index) => items.elementAt(index);
  ListPaging<TItem>? get paging =>
      this is ListPaging<TItem> ? this as ListPaging<TItem> : null;
}

mixin ListPaging<TItem> on BaseListController<TItem> {
  int? _total;
  int? get total => _total;
  bool get gotAllItems => total != null && total! <= items.length;
  bool _loadingMore = false;
  bool _refreshing = false;
  bool _fullScreenLoad = false;
  String? _error;
  bool get loadingMore => _loadingMore;
  bool get refreshing => _refreshing;
  bool get fullScreenLoad => _fullScreenLoad;
  bool get loading => loadingMore || refreshing || fullScreenLoad;
  bool get hasError => _error != null;
  String? get error => _error;
  Future reloadApi() async {
    _fullScreenLoad = true;
    update();
    await beforeLoad();
    var _items = items.map((e) => e).toList();
    var _total = total;
    await clearItems();
    return loadData(0).then((value) async {
      _fullScreenLoad = false;
      _error = null;
      await setItems(value.data!, value.total);
      afterLoad();
    }).catchError((e) async {
      _error = e.toString();
      _fullScreenLoad = false;
      await setItems(_items, _total);
      afterLoad();
      throw e;
    });
  }

  Future refreshApi() async {
    await beforeLoad();
    _refreshing = true;
    update();
    return loadData(0).then((value) async {
      _refreshing = false;
      _error = null;
      await setItems(value.data!, value.total);
      afterLoad();
    }).catchError((e) {
      _error = e.toString();
      _refreshing = false;
      update();
      afterLoad();
      throw e;
    });
  }

  Future loadNextApi() async {
    await beforeLoad();
    _loadingMore = true;
    update();
    return loadData(length).then((value) async {
      _loadingMore = false;
      _error = null;
      await addAll(value.data!, value.total);
      afterLoad();
    }).catchError((e) {
      _error = e.toString();
      _loadingMore = false;
      update();
      afterLoad();
      throw e;
    });
  }

  Future<ApiListResponse<TItem>> loadData(int skip);
  Future addAll(List<TItem> items, [int? total]);

  Future clearItems();

  Future setItems(List<TItem> items, [int? total]);

  Future beforeLoad() => Future.value();
  void afterLoad() {}
}

abstract class ListController<TItem> extends BaseListController<TItem>
    with ListPaging<TItem> {
  List<TItem> _items = List<TItem>.empty(growable: true);

  @override
  Iterable<TItem> get items => _items;

  void replaceItems(TItem Function(TItem) fn) {
    _items = _items.map(fn).toList();
    update();
  }

  bool loadOnInt() => true;

  @override
  void onInit() {
    super.onInit();
    if (length == 0 && !loading && loadOnInt() == true) reloadApi();
  }

  Future add(TItem item, [int? total]) async {
    _total = total ?? (_total == null ? _total : _total! + 1);
    _items.add(item);
    update();
  }

  @override
  Future addAll(List<TItem> items, [int? total]) async {
    try {
      _total = total ?? (_total == null ? _total : _total! + items.length);
      _items.addAll(items);
      update();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future clearItems() async {
    _items.clear();
    update();
  }

  @override
  Future setItems(List<TItem> items, [int? total]) async {
    _total = total ?? (_total == null ? _total : _total! + items.length);
    _items = List<TItem>.from(items, growable: true);
    update();
  }

  Future removeWhere(bool Function(TItem element) test) async {
    var _length = length;
    _items.removeWhere(test);
    var removed = _length - length;
    _total = (_total == null ? _total : _total! - removed);
    if (_total != null && _total! < 0) _total = 0;
    update();
  }

  Future replace(int index, TItem item) async {
    if (index < items.length) {
      _items.removeAt(index);
      _items.insert(index, item);
    }
    update();
  }

  Future removeAt(int index) async {
    if (index < items.length) {
      _items.removeAt(index);
    }
    if (_total != null && _total! > 0) _total = _total! - 1;
    update();
  }

  Future remove(TItem item) async {
    _items.remove(item);
    if (_total != null && _total! > 0) _total = _total! - 1;
    update();
  }

  Future removeRange(int start, int end) async {
    _items.removeRange(start, end);
    if (_total != null && _total! > 0) _total = _total! - (end - start);
    update();
  }

  Future insert(int index, TItem item) async {
    if (index <= items.length) {
      _items.insert(index, item);
      if (_total != null) _total = _total! + 1;
    }
    update();
  }
}

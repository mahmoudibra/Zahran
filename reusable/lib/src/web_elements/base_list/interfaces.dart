part of base_list;

abstract class _DataTableFilter<T> extends StatefulWidget {
  T? get intialValue;
  ValueChanged<T?> get onChange;
}

mixin _DataTableFiltersMixin<TValue, T extends _DataTableFilter<TValue>>
    on State<T> {
  TValue? _value;
  @override
  void initState() {
    super.initState();
    _value = widget.intialValue;
  }

  set value(TValue? v) {
    if (v != _value) {
      widget.onChange(v);
      setState(() {
        _value = v;
      });
    }
  }

  TValue? get value => _value;
}

class BaseListLoadResponse<T> {
  final List<T> items;
  final int total;

  BaseListLoadResponse({
    required this.items,
    required this.total,
  });
}

part of base_list;

class OptionFilterItem<T> {
  final String display;
  final T? value;

  OptionFilterItem({this.display = '', this.value});
}

class SingleOptionFilter<T> extends StatefulWidget
    implements _DataTableFilter<T?> {
  @override
  final T? intialValue;
  final String display;
  final bool canReset;
  final List<OptionFilterItem<T>> items;
  @override
  final ValueChanged<T?> onChange;
  const SingleOptionFilter({
    Key? key,
    required this.onChange,
    required this.items,
    this.intialValue,
    required this.display,
    this.canReset = true,
  }) : super(key: key);

  @override
  _SingleOptionFilterState<T> createState() => _SingleOptionFilterState<T>();
}

class _SingleOptionFilterState<T> extends State<SingleOptionFilter<T>>
    with
        _DataTableFiltersMixin<T?, SingleOptionFilter<T>>,
        TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var selected =
        widget.items.firstWhere((el) => el.value == value, orElse: () {
      return OptionFilterItem<T>(
        display: widget.display,
      );
    });
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PopupMenuButton<OptionFilterItem<T>>(
            initialValue: widget.items
                .firstOrDefault((e) => e.value == widget.intialValue),
            tooltip: widget.display,
            onSelected: (v) async {
              value = v.value;
              FocusScope.of(context).requestFocus(FocusNode());
            },
            itemBuilder: (BuildContext context) {
              return [
                ...widget.items
                    .map(
                      (e) => PopupMenuItem<OptionFilterItem<T>>(
                        value: e,
                        child: Text(e.display),
                      ),
                    )
                    .toList()
              ];
            },
            child: TextButton.icon(
              onPressed: null,
              icon: Icon(Icons.more_vert),
              label: Text(selected.display),
            ),
          ),
          if (widget.canReset == true && value != null)
            IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  value = null;
                  FocusScope.of(context).requestFocus(FocusNode());
                })
        ],
      ),
    );
  }
}

class BooleanFilter extends StatelessWidget {
  final ValueChanged<bool?> onChange;
  final bool? intialValue;
  final bool disableNull;
  final String trueDisplay;
  final String falseDisplay;
  final String nullDisplay;
  final String display;
  const BooleanFilter({
    Key? key,
    required this.onChange,
    this.intialValue,
    this.disableNull = false,
    this.trueDisplay = 'مفعل',
    this.falseDisplay = 'غير مفعل',
    this.nullDisplay = 'الكل',
    this.display = 'الحالة',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleOptionFilter<bool>(
      intialValue: intialValue,
      display: display,
      items: <OptionFilterItem<bool>>[
        if (disableNull != true)
          OptionFilterItem<bool>(value: null, display: nullDisplay),
        OptionFilterItem<bool>(value: true, display: trueDisplay),
        OptionFilterItem<bool>(value: false, display: falseDisplay),
      ],
      onChange: onChange,
    );
  }
}

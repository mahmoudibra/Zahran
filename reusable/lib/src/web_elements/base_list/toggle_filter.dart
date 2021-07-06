part of base_list;

class ToggleFilter extends StatefulWidget implements _DataTableFilter<bool> {
  @override
  final ValueChanged<bool?> onChange;
  final String activeText;
  final String inActiveText;
  @override
  final bool intialValue;
  const ToggleFilter({
    Key? key,
    required this.onChange,
    this.activeText = 'مفعل',
    this.inActiveText = 'غير مفعل',
    this.intialValue = false,
  }) : super(key: key);
  @override
  _ToggleFilterState createState() => _ToggleFilterState();
}

class _ToggleFilterState extends State<ToggleFilter>
    with _DataTableFiltersMixin<bool, ToggleFilter> {
  @override
  Widget build(BuildContext context) {
    var _value = value;
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: ActionChip(
        key: Key('$_value'),
        avatar: Icon(_value == true ? Icons.check_circle : Icons.remove_circle),
        backgroundColor: _value == true ? Colors.greenAccent : Colors.redAccent,
        label:
            Text(_value == true ? (widget.activeText) : (widget.inActiveText)),
        onPressed: () {
          if (value == null) {
            value = true;
          } else {
            value = !_value!;
          }
        },
      ),
    );
  }
}

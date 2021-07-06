part of base_list;

class TimeFilter extends StatefulWidget
    implements _DataTableFilter<TimeOfDay?> {
  @override
  final ValueChanged<TimeOfDay?> onChange;
  final String display;
  @override
  final TimeOfDay? intialValue;
  const TimeFilter({
    Key? key,
    required this.onChange,
    this.intialValue,
    required this.display,
  }) : super(key: key);
  @override
  _TimeFilterState createState() => _TimeFilterState();
}

class _TimeFilterState extends State<TimeFilter>
    with _DataTableFiltersMixin<TimeOfDay?, TimeFilter> {
  @override
  Widget build(BuildContext context) {
    var _display = value == null ? widget.display : value!.format(context);
    return TextButton.icon(
      onPressed: () {
        buildShowTimePicker().then((_value) {
          value = _value;
        });
      },
      icon: Icon(Icons.timer),
      label: Text(_display),
    );
  }

  Future<TimeOfDay?> buildShowTimePicker() {
    return showTimePicker(
      context: context,
      initialTime: value ?? TimeOfDay.fromDateTime(DateTime.now()),
    );
  }
}

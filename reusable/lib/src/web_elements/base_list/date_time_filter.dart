part of base_list;

class DateFilter extends StatefulWidget implements _DataTableFilter<DateTime?> {
  final String display;
  @override
  final DateTime? intialValue;
  final DateTime? minDte;
  @override
  final ValueChanged<DateTime?> onChange;
  const DateFilter({
    Key? key,
    this.intialValue,
    this.minDte,
    required this.display,
    required this.onChange,
  }) : super(key: key);
  @override
  _DateFilterState createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> with _DataTableFiltersMixin {
  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    var _display =
        value == null ? widget.display : localizations.formatFullDate(value);
    return TextButton.icon(
      onPressed: () {
        buildShowDatePicker().then((_value) {
          value = _value;
        });
      },
      icon: Icon(Icons.calendar_today),
      label: Text(_display),
    );
  }

  Future<DateTime?> buildShowDatePicker() {
    var min = widget.minDte ?? DateTime(1900);
    return showDatePicker(
      context: context,
      selectableDayPredicate: (DateTime date) {
        if (date.isAfter(min) || date.isAtSameMomentAs(min)) return true;
        if (value != null || date.isAtSameMomentAs(value)) return true;
        return false;
      },
      initialDate: value ?? DateTime.now(),
      firstDate: value == null ? min : (value.isBefore(min) ? value : min),
      lastDate: DateTime(2077),
    );
  }
}

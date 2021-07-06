part of base_list;

class _ExportButton<T> extends StatelessWidget {
  final VoidCallback export;
  final DataTableController<T> controller;
  const _ExportButton({
    Key? key,
    required this.export,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.assignment),
      color: (controller.paging?.loading == true)
          ? Theme.of(context).disabledColor
          : null,
      onPressed: () {
        export();
      },
    );
  }
}

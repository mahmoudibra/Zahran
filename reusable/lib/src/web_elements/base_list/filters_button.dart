part of base_list;

class _FiltersButton<T, TController extends DataTableController<T>>
    extends StatelessWidget {
  final List<Widget> filters;
  final TController controller;
  const _FiltersButton({
    Key? key,
    required this.filters,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.sort,
        color: (controller.paging?.loading == true)
            ? Theme.of(context).disabledColor
            : null,
      ),
      onPressed: () {
        if (controller.paging?.loading == true) return;

        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return GetBuilder<TController>(
                init: controller,
                builder: (TController t) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (controller.paging?.loading == true)
                        LinearProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Wrap(
                          spacing: 20,
                          children: filters,
                        ),
                      ),
                    ],
                  );
                },
              );
            });
      },
    );
  }
}

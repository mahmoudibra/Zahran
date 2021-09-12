part of select_form_feilds;

class _SelectorSheet<TItem, TController extends SelectFormController<TItem>>
    extends StatefulWidget {
  final TController controller;
  final String? tag;
  final List<TItem> selectdItems;
  final bool allowMultible;
  final Color? inActiveColor;
  final Color? activeColor;
  final TextStyle? textStyle;
  final Labels Function(BuildContext context)? labels;
  const _SelectorSheet({
    Key? key,
    required this.controller,
    required this.selectdItems,
    required this.allowMultible,
    this.inActiveColor,
    this.activeColor,
    this.textStyle,
    this.labels,
    this.tag,
  }) : super(key: key);
  @override
  __SelectorSheetState<TItem, TController> createState() =>
      __SelectorSheetState<TItem, TController>();
}

class __SelectorSheetState<TItem,
        TController extends SelectFormController<TItem>>
    extends State<_SelectorSheet<TItem, TController>>
    with SingleTickerProviderStateMixin {
  late List<TItem> selectdItems;
  bool changed = false;
  @override
  void initState() {
    selectdItems = widget.selectdItems.map((e) => e).toList();
    super.initState();
  }

  Color getActiveColor() {
    return widget.activeColor ?? Theme.of(context).colorScheme.secondary;
  }

  Color getInActiveColor() {
    return widget.inActiveColor ?? Theme.of(context).disabledColor;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .75),
      child: SafeArea(
        top: false,
        child: AnimatedSize(
          duration: Duration(milliseconds: 300),
          child: GetBuilder(
            init: widget.controller,
            tag: widget.tag,
            builder: (TController controller) {
              return buildInner(controller);
            },
          ),
        ),
      ),
    );
  }

  Widget buildInner(TController controller) {
    if (controller.length == 0) {
      return AspectRatio(
        aspectRatio: 1,
        child: ListPlaceHolder(
                controller: widget.controller, labels: widget.labels)
            .build(context),
      );
    }
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        if (widget.allowMultible == true)
          SliverAppBar(
            pinned: true,
            actions: [
              if (changed == true)
                IconButton(
                    icon: Icon(Icons.done),
                    onPressed: () {
                      Navigator.pop(context, selectdItems);
                    })
            ],
          ),
        SliverSpacer(),
        for (var item in controller.items)
          SliverToBoxAdapter(child: buildItem(controller, item)),
        SliverSpacer(),
      ],
    );
  }

  Widget buildItem(TController controller, TItem item) {
    var isSelected = selectdItems.any((element) {
      return controller.checkSelected(element, item);
    });
    return ListTile(
      onTap: () {
        if (widget.allowMultible == true) {
          if (isSelected) {
            selectdItems.removeWhere((element) {
              return controller.checkSelected(element, item);
            });
          } else {
            selectdItems.add(item);
          }
          setState(() {
            changed = true;
          });
        } else {
          Navigator.pop(context, item);
        }
      },
      trailing: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? getActiveColor().withOpacity(0.1)
              : getInActiveColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.check,
          color: isSelected ? getActiveColor() : getInActiveColor(),
        ),
      ),
      title: DefaultTextStyle.merge(
        style: TextStyle(color: isSelected ? getActiveColor() : null),
        child: Text(
          controller.getItemDisplay(context, item),
          style: widget.textStyle,
        ),
      ),
    );
  }
}

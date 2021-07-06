part of web_admin_layout;

class _DashBoardAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AnimationController expansionController;
  final bool isPhone;
  const _DashBoardAppBar({
    Key? key,
    required this.expansionController,
    required this.isPhone,
  }) : super(key: key);

  @override
  __DashBoardAppBarState createState() => __DashBoardAppBarState();

  @override
  Size get preferredSize {
    var size = AppBar().preferredSize;
    if (isPhone) return size;
    return Size(size.width - 40, size.height + 20);
  }
}

class __DashBoardAppBarState extends State<_DashBoardAppBar>
    with TickerProviderStateMixin {
  List<DashboardItem> items(DashboardItem e) {
    if (e.builder != null) {
      return [e];
    } else {
      return e.subItems
          .map((e) => items(e))
          .expand((element) => element)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    var options = AdminDashboard.of(context);
    return TabControllerLisner(
      builder: (int index) {
        var _items = [
          for (var item in options?.items ?? []) ...items(item),
        ];
        var selected = _items[index];
        if (widget.isPhone) {
          return AppBar(
            leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
            centerTitle: true,
            title: Text(selected.label),
            actions: [
              if (selected.actions != null) ...selected.actions!,
              if (options?.actions != null) ...options!.actions!,
            ],
          );
        }
        return buildPadding(context, selected);
      },
    );
  }

  Padding buildPadding(BuildContext context, DashboardItem selected) {
    var options = AdminDashboard.of(context);
    return Padding(
      padding: EdgeInsets.all(20).copyWith(bottom: 0),
      child: Row(
        children: [
          Container(
            width: 90,
            alignment: Alignment.center,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              onPressed: () {
                if (widget.expansionController.isAnimating) {
                  if (widget.expansionController.status ==
                      AnimationStatus.forward) {
                    widget.expansionController.reverse();
                  } else {
                    widget.expansionController.forward();
                  }
                } else if (widget.expansionController.value ==
                    widget.expansionController.lowerBound) {
                  widget.expansionController.forward();
                } else {
                  widget.expansionController.reverse();
                }
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: Tween(begin: 0.0, end: 1.0)
                    .animate(widget.expansionController),
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: AppBar(
              centerTitle: true,
              title: Text(selected.label),
              actions: [
                if (selected.actions != null) ...selected.actions!,
                if (options?.actions != null) ...options!.actions!,
              ],
              shape: widget.isPhone.onFalse(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

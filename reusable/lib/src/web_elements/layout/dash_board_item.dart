part of web_admin_layout;

class DashboardItem {
  final String id;
  final String label;
  final Widget icon;
  final Widget? selectedIcon;
  final Widget Function(Map<String, dynamic> paramters)? builder;
  final List<Widget>? actions;
  final List<DashboardItem> subItems;
  DashboardItem({
    required this.id,
    required this.label,
    required this.builder,
    required this.icon,
    this.selectedIcon,
    this.actions,
  }) : subItems = [];
  DashboardItem.items({
    required this.label,
    required this.icon,
    required this.id,
    this.actions,
    required this.subItems,
  })   : selectedIcon = null,
        builder = null;
}

class PageInfo extends StatefulWidget {
  final DashboardItem item;
  final Widget child;

  const PageInfo({Key? key, required this.item, required this.child})
      : super(key: key);
  @override
  _PageInfoState createState() => _PageInfoState();

  static PageInfo? of(BuildContext context) =>
      context.findAncestorStateOfType<_PageInfoState>()?.widget;
}

class _PageInfoState extends State<PageInfo> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

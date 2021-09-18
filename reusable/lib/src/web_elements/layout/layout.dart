part of web_admin_layout;

class AdminDashboard extends StatefulWidget {
  final List<DashboardItem> items;
  final int? initialIndex;
  final Widget? drawerLeading;
  final Widget? drawerTrailing;
  final List<Widget>? actions;
  AdminDashboard({
    required this.items,
    this.drawerLeading,
    this.drawerTrailing,
    this.actions,
    this.initialIndex,
  }) : assert(items.isNotEmpty);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();

  static AdminDashboard? of(BuildContext context) =>
      context.findAncestorStateOfType<_AdminDashboardState>()?.widget;
}

class _AdminDashboardState extends State<AdminDashboard>
    with TickerProviderStateMixin {
  late AnimationController expansionController;

  @override
  void initState() {
    expansionController = AnimationController(
      duration: Duration(milliseconds: 350),
      value: 1.0,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    expansionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[for (var item in widget.items) ...children(item)];
    return DefaultTabController(
      length: widgets.length,
      initialIndex: widget.initialIndex ?? 0,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 500) return phone(context, widgets);
          return desktop(context, widgets);
        },
      ),
    );
  }

  Widget desktop(BuildContext context, List<Widget> widgets) {
    return Scaffold(
      appBar: _DashBoardAppBar(
        isPhone: false,
        expansionController: expansionController,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(width: 15),
          dashBoardDrawer(context, false),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 20),
              child: tabView(widgets),
            ),
          )
        ],
      ),
    );
  }

  Widget phone(BuildContext context, List<Widget> widgets) {
    return Scaffold(
      appBar: _DashBoardAppBar(
        isPhone: true,
        expansionController: expansionController,
      ),
      drawer: dashBoardDrawer(context, true),
      body: tabView(widgets),
    );
  }

  _DashBoardDrawer dashBoardDrawer(BuildContext context, bool phone) {
    return _DashBoardDrawer(
      isPhone: phone,
      expansionController: expansionController,
    );
  }

  bool checkSelected(String base, String fragment) {
    return base == fragment;
  }

  List<Widget> children(DashboardItem e) {
    if (e.builder != null) {
      return [e.builder!({})];
    } else {
      return e.subItems
          .map((e) => children(e))
          .expand((element) => element)
          .toList();
    }
  }

  Widget tabView(List<Widget> widgets) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: widgets,
    );
  }
}

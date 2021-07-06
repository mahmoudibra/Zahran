part of web_admin_layout;

class _DashBoardDrawer extends StatelessWidget {
  final bool isPhone;
  final AnimationController expansionController;
  const _DashBoardDrawer(
      {Key? key, required this.expansionController, required this.isPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isPhone) return phone(context);
    return desktop(context);
  }

  Widget phone(BuildContext context) {
    var items = AdminDashboard.of(context)?.items ?? [];
    assert(items.isNotEmpty);
    return TabControllerLisner(
      builder: (int index) {
        return Drawer(
          child: _listView(context, items, isPhone, index),
        );
      },
    );
  }

  Widget desktop(BuildContext context) {
    var items = AdminDashboard.of(context)?.items ?? [];
    return SafeArea(
      left: Directionality.of(context) == TextDirection.rtl ? true : false,
      right: Directionality.of(context) == TextDirection.ltr ? false : true,
      child: TabControllerLisner(builder: (int index) {
        return AnimatedBuilder(
            animation: expansionController,
            builder: (context, snapshot) {
              return Container(
                constraints: BoxConstraints(
                    maxWidth: 60 + expansionController.value * 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      100 - 75 * expansionController.value),
                  color: NavigationRailTheme.of(context).backgroundColor ??
                      Theme.of(context).colorScheme.surface,
                ),
                margin: EdgeInsetsDirectional.only(
                  start: 20,
                  top: 20,
                  bottom: 20,
                  end: isPhone ? 0 : 20,
                ),
                child: _listView(context, items, isPhone, index),
              );
            });
      }),
    );
  }

  Widget buildTile(BuildContext context, DashboardItem item, int index,
      int selected, ValueChanged<int> setIndex) {
    if (item.builder != null) {
      var child = ListTile(
        onTap: () {
          DefaultTabController.of(context)?.index = index;
        },
        selected: selected == index,
        title: Text(item.label),
        leading:
            selected == index ? (item.selectedIcon ?? item.icon) : item.icon,
      );
      setIndex(index + 1);
      return child;
    } else {
      return ExpansionTile(
        key: PageStorageKey('${DateTime.now().millisecondsSinceEpoch}'),
        title: Text(item.label),
        maintainState: true,
        initiallyExpanded:
            selected >= index && selected <= index + item.subItems.length,
        leading: item.icon,
        children: [
          for (var i = 0; i < item.subItems.length; i++)
            buildTile(context, item.subItems[i], i + index, selected, setIndex),
        ],
      );
    }
  }

  List<Widget> iconButtons(BuildContext context, DashboardItem e, int index,
      int selected, ValueChanged<int> setIndex) {
    if (e.builder != null) {
      var res = [
        IconButton(
          color: selected == index ? Theme.of(context).accentColor : null,
          onPressed: () {
            DefaultTabController.of(context)?.index = index;
          },
          icon: index == selected ? (e.selectedIcon ?? e.icon) : e.icon,
        )
      ];
      setIndex(index + 1);
      return res;
    } else {
      return [
        for (var i = 0; i < e.subItems.length; i++)
          ...iconButtons(context, e.subItems[i], i + index, selected, setIndex),
      ];
    }
  }

  ListView _listView(BuildContext context, List<DashboardItem> items,
      bool phone, int selected) {
    var index = 0;
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 15),
      children: [
        for (var i = 0; i < items.length; i++)
          if (phone || expansionController.value != 0) ...[
            buildTile(context, items[i], index, selected, (v) => index = v)
          ] else
            ...iconButtons(context, items[i], index, selected, (v) => index = v)
      ],
    );
  }
}

class RoutingDrawerObserver extends ChangeNotifier with NavigatorObserver {
  bool _expanded = true;
  Duration get duration => Duration(milliseconds: 300);
  bool get expanded => _expanded;
  set expanded(bool v) {
    _expanded = v;
    notifyListeners();
  }

  String? _routeName;
  String? get routeName => _routeName;
  final int navigatorId;
  RoutingDrawerObserver(this.navigatorId);
  @override
  void didPop(Route route, Route? previousRoute) {
    _routeName = previousRoute?.settings.name;
    notifyListeners();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _routeName = route.settings.name;
    notifyListeners();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {}

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _routeName = newRoute?.settings.name;
    notifyListeners();
  }

  @override
  void didStartUserGesture(Route? route, Route? previousRoute) {}

  @override
  void didStopUserGesture() {}
}

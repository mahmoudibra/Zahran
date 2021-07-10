import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/profile_tab/profile_tab.dart';
import 'package:zahran/presentation/business/visits/visits_tab.dart';

import 'home_app_bar.dart';
import 'home_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: HomeAppBar(innerBoxIsScrolled: innerBoxIsScrolled),
              ),
            ];
          },
          body: TabBarView(
            children: [
              VisitsTab(),
              ProfileTab(),
            ],
          ),
        ),
        bottomNavigationBar: HomeBottomBar(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'report_list_tab.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  pinned: true,
                  floating: true,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight * 2),
                    child: SizedBox(
                      height: kToolbarHeight * 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              TR.of(context).reports,
                              style: context.headline2,
                            ),
                          ),
                          Expanded(
                            child: TabControllerLisner(builder: (int index) {
                              return ListView(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _buildTab(TR.of(context).all, 0),
                                  SizedBox(width: 20),
                                  _buildTab(TR.of(context).today, 1),
                                  SizedBox(width: 20),
                                  _buildTab(TR.of(context).this_weak, 2),
                                ],
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ReportListTab(type: 'All'),
              ReportListTab(type: 'Today'),
              // ReportListTab(type: 'Tomorrow'),
              ReportListTab(type: 'Week'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return Builder(builder: (context) {
      var ctrl = DefaultTabController.of(context)!;
      var active = ctrl.index == index;
      return Center(
        child: InkWell(
          onTap: () {
            ctrl.index = index;
          },
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: active.onTrue(
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.surface,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 300),
              style: TextStyle(
                color: active.onTrue(
                  Theme.of(context).colorScheme.onSecondary,
                  Theme.of(context).colorScheme.onSurface,
                ),
              ),
              child: Text(title),
            ),
          ),
        ),
      );
    });
  }
}

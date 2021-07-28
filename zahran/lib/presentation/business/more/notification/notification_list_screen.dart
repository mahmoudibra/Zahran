import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/scaffold_list_silver_app_bar.dart';
import 'package:zahran/presentation/localization/tr.dart';

import 'notification_row.dart';
import 'notification_view_model.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: NotificationListViewModel(),
        builder: (NotificationListViewModel vm) {
          return ScaffoldListSilverAppBar(
            content: buildBranchList(context, vm),
            title: TR.of(context).notification,
          );
        });
  }

  Widget buildBranchList(BuildContext context, NotificationListViewModel vm) {
    return CompleteList.sliversWithList(
      enablePullUp: false,
      padding: EdgeInsets.all(0).copyWith(top: 0),
      builItem: (NotificationModel item, index) {
        return FadeItem(
            child: NotificationRow(
          notification: item,
          onNotificationClicked: () {
            vm.routeToNotificationDetailsDetails(index);
          },
        ));
      },
      init: vm,
    );
  }
}

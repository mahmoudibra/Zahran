import 'package:flutter/material.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/presentation/commom/rounded_image.dart';
import 'package:zahran/presentation/commom/scaffold_silver_app_bar.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/helpers/date/date-manager.dart';

import 'notification_details_view_model.dart';

class NotificationDetailsScreen extends StatelessWidget {
  NotificationDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NotificationDetailsViewModel(context),
      builder: (NotificationDetailsViewModel vm) {
        return ScaffoldSilverAppBar(
          content: buildBody(context, vm),
          title: vm.notification.title.format(context),
        );
      },
    );
  }

  Widget buildBody(BuildContext context, NotificationDetailsViewModel vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        createdBy(context, vm),
        ViewsToolbox.emptySpaceWidget(height: 8),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 16, end: 16),
          child: Text(
            vm.notification.body.format(context),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        ViewsToolbox.emptySpaceWidget(height: 8),
        // Visibility(
        //     visible: notification.media.length != 0,
        //     child: Padding(
        //       padding: EdgeInsetsDirectional.only(start: 16),
        //       child: HorizontalImageList(
        //         onImageClicked: onImageClicked,
        //         mediaList: notification.media,
        //       ),
        //     )),
      ],
    );
  }

  Widget createdBy(BuildContext context, NotificationDetailsViewModel vm) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16, end: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RoundedImage(
            radius: 42,
            borderSize: 2,
            imageUrl: vm.notification.sender.avatar,
            borderColor: Colors.white,
            loadingIndicatorSize: 20,
          ),
          ViewsToolbox.emptySpaceWidget(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  vm.notification.sender.name,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                ViewsToolbox.emptySpaceWidget(height: 2),
                Text(
                  DateTimeManager.convertDateTimeToAppFormat(vm.notification.sendDate),
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

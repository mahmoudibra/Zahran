import 'package:flutter/material.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/commom/toolbox.helper.dart';
import 'package:zahran/presentation/helpers/date/date-manager.dart';

import '../../../../r.dart';

class NotificationRow extends StatelessWidget {
  final VoidCallback onNotificationClicked;
  final NotificationModel notification;

  NotificationRow({required this.onNotificationClicked, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNotificationClicked,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(R.assetsImagesNotificationMessageIcon),
                ViewsToolbox.emptySpaceWidget(width: 8),
                notificationDetails(context),
              ],
            ),
            ViewsToolbox.emptySpaceWidget(height: 12),
            Divider(height: 1),
          ],
        ),
      ),
    );
  }

  Widget notificationDetails(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  notification.title.format(context),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              Text(
                DateTimeManager.convertDateTimeToAppFormat(notification.sendDate),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ],
          ),
          ViewsToolbox.emptySpaceWidget(height: 4),
          Text(
            notification.body.format(context),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }
}

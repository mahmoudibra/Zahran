import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class NotificationListViewModel extends ListController<NotificationModel> {
  @override
  Future<ApiListResponse<NotificationModel>> loadData(int skip) {
    return Repos.notificationRepo.pagination(skip);
  }

  Future<void> routeToNotificationDetailsDetails(int index) async {
    var notifications = items;
    var selectedNotification = notifications.toList()[index];
    ScreenNames.NOTIFICATION_DETAILS.push(selectedNotification);
  }
}

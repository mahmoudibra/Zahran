import 'package:zahran/presentation/helpers/enums/enumeration.dart';

class PushNotificationTypes extends Enum<String> {
  const PushNotificationTypes(String val) : super(val);

  static const PushNotificationTypes MESSAGE = const PushNotificationTypes('message');
}

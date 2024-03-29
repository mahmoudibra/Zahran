import 'package:android_intent/android_intent.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zahran/presentation/external/permission/permission_handler.manager.dart';

class PermissionManagerImpl implements PermissionManager {
  @override
  Future<PermissionState> checkPermission({required PermissionType service}) {
    switch (service) {
      case PermissionType.Microphone:
        return _checkPermission(Permission.microphone);
      case PermissionType.Camera:
        return _checkPermission(Permission.camera);

      case PermissionType.Gallery:
        return _checkPermission(Permission.photos);

      case PermissionType.Location:
        return _checkPermission(Permission.location);
    }
  }

  @override
  Future<void> openSettings() {
    return openAppSettings();
  }

  // Helpers
  Future<PermissionState> _checkPermission(Permission permission) async {
    var status = await permission.status;
    if (status.isLimited || status.isDenied) {
      status = await permission.request();
    }

    switch (status) {
      case PermissionStatus.granted:
        return PermissionState.Granted;
      case PermissionStatus.restricted:
        return PermissionState.Restricted;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        return PermissionState.Denied;
      case PermissionStatus.limited:
        return PermissionState.Granted;
    }
  }

  @override
  Future<void> openAndroidLocationSetting() {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    return intent.launch();
  }
}

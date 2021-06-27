abstract class PermissionManager {
  Future<PermissionState> checkPermission({PermissionType service});

  Future<void> openSettings();

  Future<void> openAndroidLocationSetting();
}

enum PermissionState { Resolving, Granted, Denied, Restricted }

enum PermissionType {
  Microphone,
  Camera,
  Gallery,
  Location,
  // Feel free to add permission incrementally as you need
}

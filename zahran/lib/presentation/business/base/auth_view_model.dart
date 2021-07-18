import 'dart:async';

import 'package:hive/hive.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/helpers/enums/enumeration.dart';

class HiveCachingKey extends Enum<String> {
  const HiveCachingKey(String val) : super(val);
  static const HiveCachingKey AUTH_KEY = const HiveCachingKey('auth_key');
  static const HiveCachingKey USER_INFO_KEY = const HiveCachingKey('user_info');
}

class AuthViewModel extends GetxController {
  Box<LoginModel>? _box;
  StreamSubscription<BoxEvent>? _lisner;

  AuthViewModel();

  LoginModel? get user {
    return _box != null && _box!.isOpen && _box!.length > 0 ? _box!.getAt(0) : null;
  }

  UserModel? get profile => user?.userProfile;

  bool get authenticated => profile != null;

  double get targetPercentage {
    if (profile!.target.target > 0) {
      return (profile!.target.totalSellOut / profile!.target.target);
    }
    return 0;
  }

  Future saveUser(LoginModel response) async {
    await openBox();
    await _box?.clear();
    await _box?.add(response);
  }

  Future removeUser() async {
    await openBox();
    await _box?.clear();
  }

  Future<Map<String, String>> getHeaders() async {
    return {
      "Authorization": "Bearer ${user?.authToken}",
    };
  }

  @override
  void onClose() {
    _lisner?.cancel();
    super.onClose();
  }

  Future openBox() async {
    if (!Hive.isBoxOpen(HiveCachingKey.AUTH_KEY.value) || _box == null) {
      _box = Hive.isBoxOpen(HiveCachingKey.AUTH_KEY.value)
          ? Hive.box(HiveCachingKey.AUTH_KEY.value)
          : (await Hive.openBox<LoginModel>(HiveCachingKey.AUTH_KEY.value));
      await _lisner?.cancel();
      _lisner = _box!.watch().listen((event) {
        update();
      });
    }
  }

  @override
  void onInit() async {
    openBox();
    super.onInit();
  }
}

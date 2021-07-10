import 'dart:async';

import 'package:hive/hive.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/source/local/shared_prefrence/local_data_manager.dart';
import 'package:zahran/domain/models/models.dart';

var _auth_key = "auth_key";

class AuthViewModel extends GetxController {
  final LocalDataManager localDataManager;
  Box<LoginModel>? _box;
  StreamSubscription<BoxEvent>? _lisner;

  AuthViewModel(this.localDataManager);
  LoginModel? get user {
    return _box != null && _box!.isOpen && _box!.length > 0
        ? _box!.getAt(0)
        : null;
  }

  UserModel? get profile => user?.userProfile;
  bool get authenticated => profile != null;

  Future saveUser(LoginModel response) async {
    await openBox();
    await _box?.clear();
    await _box?.add(response);
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
    if (!Hive.isBoxOpen(_auth_key) || _box == null) {
      _box = Hive.isBoxOpen(_auth_key)
          ? Hive.box(_auth_key)
          : (await Hive.openBox<LoginModel>(_auth_key));
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

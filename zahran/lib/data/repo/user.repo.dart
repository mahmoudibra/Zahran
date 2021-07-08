import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reusable/reusable.dart';
import 'package:zahran/data/repo/base.repo.dart';
import 'package:zahran/data/source/local/shared_prefrence/local_data_manager.dart';
import 'package:zahran/domain/mappers/domain_mapper.dart';
import 'package:zahran/domain/models/models.dart';
import 'package:zahran/presentation/navigation/screen_router.dart';

class UserRepo extends BaseRepositryImpl {
  @override
  BuildContext get context => ScreenRouter.key.currentContext;

  Future<LoginResponse> login(String sub, String password) async {
    var result = await post(
      path: '/v1/mobile/login',
      data: {
        "sab_number": sub,
        "password": password,
        "fcm_device_token": await FCMConfig.messaging.getToken(),
      },
      mapItem: (json) => LoginResponse.fromJson(json),
    );
    return result.data;
  }
}

class AuthViewModel extends GetxController {
  final LocalDataManager localDataManager;
  LoginResponse _user;

  AuthViewModel(this.localDataManager);
  LoginResponse get user => _user;
  UserModel get profile => _user?.userProfile?.dtoToDomainModel();

  Future saveUser(LoginResponse response) async {
    _user = response;
    update();
    //TODO save user
  }

  Future<Map<String, String>> getHeaders() async {
    return {
      "Authorization": "Bearer ${_user?.authToken}",
    };
  }

  Future initUser() async {
    //TODO  Get user from local storage and save it to _user variable
  }
}

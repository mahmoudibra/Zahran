import 'package:connectivity/connectivity.dart';

import 'internet_connectivity_manager.dart';

class InternetConnectivityManagerImpl implements InternetConnectivityManager {
  Connectivity _connectivity;

  InternetConnectivityManagerImpl({Connectivity connectivity}) {
    _connectivity = connectivity ?? Connectivity();
  }

  @override
  Future<bool> checkConnectivity() async {
    ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      print("💪 Internet Connectivity status is: $connectivityResult ");
      return Future.value(true);
    } else {
      print("🙅 Internet Connectivity status is: $connectivityResult ");
      return Future.value(false);
    }
    ;
  }
}

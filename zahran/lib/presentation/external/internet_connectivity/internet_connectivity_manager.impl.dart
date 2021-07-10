import 'package:connectivity/connectivity.dart';

import 'internet_connectivity_manager.dart';

class InternetConnectivityManagerImpl implements InternetConnectivityManager {
  Connectivity connectivity;

  InternetConnectivityManagerImpl({required this.connectivity});

  @override
  Future<bool> checkConnectivity() async {
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print("💪 Internet Connectivity status is: $connectivityResult ");
      return Future.value(true);
    } else {
      print("🙅 Internet Connectivity status is: $connectivityResult ");
      return Future.value(false);
    }
  }
}

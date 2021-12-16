import 'package:connectivity/connectivity.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';

class ConnectivityService {
  AppNotifiers _appNotifiers;
  static ConnectivityService _instance;
  Connectivity _connectivity;

  ConnectivityService._() {
    _connectivity = Connectivity();
  }
  // ||.. singleton pattern ..||
  static ConnectivityService get instance {
    if (_instance != null) return _instance;
    return _instance = ConnectivityService._();
  }

  // listen to connection.
  void listenToConnection(AppNotifiers appNotifiers) async {
    this._appNotifiers = appNotifiers;
    _connectivity.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        AppShared.connectivity = Constants.INTERNET_STATUS_CONNECTING;
        _appNotifiers.connectivity = Constants.INTERNET_STATUS_CONNECTING;
        while (
            AppShared.connectivity != Constants.INTERNET_STATUS_NOT_CONNECTED) {
          try {
            await AppShared.dio.get('https://www.google.com');
            AppShared.connectivity = Constants.INTERNET_STATUS_CONNECTED;
            _appNotifiers.connectivity = Constants.INTERNET_STATUS_CONNECTED;
          } catch (error) {
            AppShared.connectivity = Constants.INTERNET_STATUS_CONNECTING;
            _appNotifiers.connectivity = Constants.INTERNET_STATUS_CONNECTING;
          }
          await Future.delayed(Duration(seconds: 3));
        }
      } else if (connectivityResult == ConnectivityResult.none) {
        AppShared.connectivity = Constants.INTERNET_STATUS_NOT_CONNECTED;
        _appNotifiers.connectivity = Constants.INTERNET_STATUS_NOT_CONNECTED;
      }
    });
  }

  // check connection.
  Future<void> checkConnection() async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      try {
        await AppShared.dio.get('https://www.google.com');
        AppShared.connectivity = Constants.INTERNET_STATUS_CONNECTED;
      } catch (error) {
        AppShared.connectivity = Constants.INTERNET_STATUS_CONNECTING;
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      AppShared.connectivity = Constants.INTERNET_STATUS_NOT_CONNECTED;
    }
  }
}

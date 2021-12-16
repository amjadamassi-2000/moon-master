import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AppNotifiers with ChangeNotifier {
  int _connectivity;
  bool _refreshApp = false;

  int get connectivity => _connectivity;

  set connectivity(int value) {
    _connectivity = value;
    notifyListeners();
  }

  bool get refreshApp => _refreshApp;

  set refreshApp(bool value) {
    _refreshApp = value;
    notifyListeners();
  }

  Map<String, dynamic> notification;
  GlobalKey<NavigatorState> navigatorKey;
}

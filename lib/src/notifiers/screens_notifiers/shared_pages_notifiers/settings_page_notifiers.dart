import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/app_shared.dart';

class SettingsPageNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isNotificationEnabled =
      AppShared.sharedPreferencesController.isNotificationEnabled();

  bool get isNotificationEnabled => _isNotificationEnabled;

  set isNotificationEnabled(bool value) {
    _isNotificationEnabled = value;
    AppShared.sharedPreferencesController.setIsNotificationEnabled(value);
    notifyListeners();
  }

  //--------------------------------------------------------------------------------------------------//

  // ||... constructor ...||

// ||...................... logic methods ............................||

// ||...................... logic methods ............................||
}

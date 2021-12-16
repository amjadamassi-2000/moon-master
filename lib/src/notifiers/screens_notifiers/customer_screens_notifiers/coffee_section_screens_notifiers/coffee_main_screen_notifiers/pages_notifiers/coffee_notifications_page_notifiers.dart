import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/user_controller.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/notifications_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class CoffeeNotificationsPageNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

// ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  UserController userController;
  NotificationsResponse notificationsResponse;

  bool isError = false;

  // ||... constructor ...||
  CoffeeNotificationsPageNotifiers(this.context) {
    userController = UserController.instance;
  }

// ||...................... logic methods ............................||

  // init.
  void init({bool isInit = true}) async {
    try {
      if (!isInit) {
        isError = false;
        isLoading = true;
      }
      notificationsResponse = await userController.getNotifications();
      isLoading = false;
    } catch (error) {
      isError = true;
      isLoading = false;
      print(error.toString());
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }
  }

// ||...................... logic methods ............................||
}

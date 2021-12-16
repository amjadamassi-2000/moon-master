import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/configs_controller.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/faq_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class FaqScreenNotifiers with ChangeNotifier {
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
  ConfigsController configsController;
  FaqResponse faqResponse;

  bool isError = false;

  // ||... constructor ...||
  FaqScreenNotifiers(this.context) {
    configsController = ConfigsController.instance;
  }

// ||...................... logic methods ............................||

  // init.
  void init({bool isInit = true}) async {
    try {
      if (!isInit) {
        isError = false;
        isLoading = true;
      }
      faqResponse = await configsController.getFaq();
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

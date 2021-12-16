import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/configs_controller.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/static_pages_response.dart';
import 'package:moonapp/src/utils/constants.dart';

class PrivacyPolicyScreenNotifiers with ChangeNotifier {
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
  StaticPagesResponse staticPagesResponse;

  // ||... constructor ...||
  PrivacyPolicyScreenNotifiers(this.context) {
    configsController = ConfigsController.instance;
  }

// ||...................... logic methods ............................||

  // init.
  void init() async {
    staticPagesResponse = await configsController
        .getStaticPages(Constants.STATIC_PAGES_PRIVACY_POLICY);
    isLoading = false;
  }

// ||...................... logic methods ............................||
}

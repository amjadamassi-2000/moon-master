import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/auth_controller.dart';
import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class ForgetPasswordScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
// ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  AuthController authController;
  GlobalKey<FormState> forgotPasswordFormState;

  // ||... form fields ...|
  String email;

  // ||... constructor ...||
  ForgetPasswordScreenNotifiers(this.context) {
    authController = AuthController.instance;
    forgotPasswordFormState = GlobalKey();
  }

// ||...................... logic methods ............................||

  // forgot password
  void forgotPassword(startLoading, stopLoading, btnState) async {
    if (!forgotPasswordFormState.currentState.validate()) return;
    forgotPasswordFormState.currentState.save();
    startLoading();
    try {
      BaseResponse baseResponse =
          await authController.forgotPassword(email: email);
      stopLoading();
      if (baseResponse.status)
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_SUCCESS);
      else
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
    } catch (error) {
      stopLoading();
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }
// ||...................... logic methods ............................||
}

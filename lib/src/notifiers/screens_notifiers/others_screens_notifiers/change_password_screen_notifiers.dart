import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/auth_controller.dart';
import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class ChangePasswordScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = false;
  bool _isOldPasswordVisible = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  set isConfirmPasswordVisible(bool value) {
    _isConfirmPasswordVisible = value;
    notifyListeners();
  }

  bool get isPasswordVisible => _isPasswordVisible;

  set isPasswordVisible(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  bool get isOldPasswordVisible => _isOldPasswordVisible;

  set isOldPasswordVisible(bool value) {
    _isOldPasswordVisible = value;
    notifyListeners();
  }
// ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  AuthController authController;
  GlobalKey<FormState> changePasswordFormState;

  // ||... form fields ...|
  String oldPassword;
  String password;
  String confirmPassword;

  // ||... focus nodes ...||
  FocusNode passwordFocusNode;
  FocusNode confirmPasswordFocusNode;

  // ||... constructor ...||
  ChangePasswordScreenNotifiers(this.context) {
    authController = AuthController.instance;
    changePasswordFormState = GlobalKey();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

// ||...................... logic methods ............................||

  // change password.
  void changePassword(startLoading, stopLoading, btnState) async {
    if (!changePasswordFormState.currentState.validate()) return;
    changePasswordFormState.currentState.save();
    try {
      startLoading();
      BaseResponse baseResponse = await authController.changePassword(
        password: password,
        oldPassword: oldPassword,
        confirmPassword: confirmPassword,
      );
      stopLoading();
      if (baseResponse.status) {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_SUCCESS);
        Navigator.pop(context);
      } else {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
      }
    } catch (error) {
      stopLoading();
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

// ||...................... logic methods ............................||

}

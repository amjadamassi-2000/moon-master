import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/auth_controller.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/user_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class SignUpScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
// ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  AuthController authController;
  GlobalKey<FormState> signUpFormState;
  TextEditingController cityTextController;

  // ||... form fields ...|
  String name;
  String email;
  String mobile;
  int cityId;
  String password;
  String confirmPassword;

  // ||... focus nodes ...||
  FocusNode emailFocusNode;
  FocusNode passwordFocusNode;
  FocusNode confirmPasswordFocusNode;
  FocusNode mobileFocusNode;
  FocusNode cityFocusNode;

  // ||... constructor ...||
  SignUpScreenNotifiers(this.context) {
    authController = AuthController.instance;
    signUpFormState = GlobalKey();
    cityTextController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    cityFocusNode = FocusNode();
  }

  // ||...................... logic methods ............................||

  // sign up method
  void signUp(startLoading, stopLoading, btnState) async {
    if (!signUpFormState.currentState.validate()) return;
    signUpFormState.currentState.save();
    if (password != confirmPassword) {
      Helpers.showMessage(
          AppShared.appLang['ConfirmPasswordDoesNotMatchPassword' ],
          MessageType.MESSAGE_FAILED);
      return;
    }
    try {
      startLoading();
      UserResponse userResponse = await authController.signUp(
          name: name,
          email: email,
          password: password,
          mobile: mobile,
          cityId: cityId);
      stopLoading();
      if (userResponse.status) {
        Navigator.pushNamedAndRemoveUntil(
            context, Constants.SCREEN_CHOOSE_SECTION_SCREEN, (route) => false);
      } else {
        Helpers.showMessage(userResponse.message, MessageType.MESSAGE_FAILED);
      }
    } catch (error) {
      stopLoading();
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

// ||...................... logic methods ............................||

}

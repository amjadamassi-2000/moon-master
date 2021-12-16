import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/auth_controller.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/user_response.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class SignInScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  set isPasswordVisible(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  AuthController authController;
  GlobalKey<FormState> signInFormState;

  // ||... form fields ...|
  String email;
  String password;

  // ||... focus nodes ...||
  FocusNode passwordFocusNode;

  // ||... constructor ...||
  SignInScreenNotifiers(this.context) {
    authController = AuthController.instance;
    signInFormState = GlobalKey();
    passwordFocusNode = FocusNode();
  }

  // ||...................... logic methods ............................||

  // sign in method
  void signIn(startLoading, stopLoading, btnState) async {
    if (!signInFormState.currentState.validate()) return;
    signInFormState.currentState.save();
    try {
      startLoading();
      UserResponse userResponse = await authController.signIn(
        email: email,
        password: password,
      );
      stopLoading();
      if (userResponse.status) {
        if (userResponse.user.type == Constants.USER_TYPE_CUSTOMER) {
          Navigator.pushNamedAndRemoveUntil(context,
              Constants.SCREEN_CHOOSE_SECTION_SCREEN, (route) => false);
        } else if (userResponse.user.type == Constants.USER_TYPE_DRIVER) {
          Navigator.pushNamedAndRemoveUntil(context,
              Constants.SCREENS_DRIVER_ORDERS_SCREEN, (route) => false);
        } else if (userResponse.user.type == Constants.USER_TYPE_WAITER) {
          Navigator.pushNamedAndRemoveUntil(
              context, Constants.SCREENS_COFFEE_MAIN_SCREEN, (route) => false);
        }
        else{
          Navigator.pushNamedAndRemoveUntil(context,
              Constants.SCREEN_CHOOSE_SECTION_SCREEN, (route) => false);
        }
      } else {
        Helpers.showMessage(userResponse.message, MessageType.MESSAGE_FAILED);
      }
    }

    catch (error) {
      stopLoading();
      print(error);
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }


  }

  // skip
  void skip() {
    Navigator.pushNamedAndRemoveUntil(
        context, Constants.SCREEN_CHOOSE_SECTION_SCREEN, (route) => false);
  }
// ||...................... logic methods ............................||

}

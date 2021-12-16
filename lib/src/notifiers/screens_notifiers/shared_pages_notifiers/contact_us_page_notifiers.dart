import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/configs_controller.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/contact_response.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class ContactUsPageNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  ConfigsController configsController;
  GlobalKey<FormState> contactUsFormState;

  // ||... form fields ...|
  String name;
  String email;
  String mobile;
  String message;

  // ||... focus nodes ...||
  FocusNode emailFocusNode;
  FocusNode mobileFocusNode;
  FocusNode messageFocusNode;

  // ||... constructor ...||
  ContactUsPageNotifiers(this.context) {
    configsController = ConfigsController.instance;
    contactUsFormState = GlobalKey();
    emailFocusNode = FocusNode();
    messageFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
  }

// ||...................... logic methods ............................||

  // send.
  void send(startLoading, stopLoading, btnState) async {
    if (!contactUsFormState.currentState.validate()) return;
    contactUsFormState.currentState.save();
    startLoading();
    try {
      ContactResponse contactResponse = await configsController.sendContact(
        mobile: mobile,
        message: message,
        email: email,
        name: name,
      );
      stopLoading();
      if (contactResponse.status) {
        contactUsFormState.currentState.reset();
        Helpers.showMessage(
            contactResponse.message, MessageType.MESSAGE_SUCCESS);
      } else {
        if (contactResponse.validator != null)
          Helpers.showMessage(
              contactResponse.validator, MessageType.MESSAGE_FAILED);
      }
    } catch (error) {
      stopLoading();
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }
// ||...................... logic methods ............................||
}

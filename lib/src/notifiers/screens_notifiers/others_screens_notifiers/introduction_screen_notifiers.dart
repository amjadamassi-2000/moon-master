import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';

class IntroductionScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;

  // ||... constructor ...||
  IntroductionScreenNotifiers(this.context);

// ||...................... logic methods ............................||

  // init.
  void init() async {
    if (AppShared.sharedPreferencesController.getAppLang() == null) {
      Navigator.of(context)
          .pushReplacementNamed(Constants.SCREEN_CHOOSE_LANGUAGE_SCREEN);
      return;
    }
    if (AppShared.sharedPreferencesController.getIsLogin()) {
      AppShared.currentUser =
          AppShared.sharedPreferencesController.getUserData();
      if (AppShared.currentUser.type == Constants.USER_TYPE_CUSTOMER) {
        Navigator.of(context)
            .pushReplacementNamed(Constants.SCREEN_CHOOSE_SECTION_SCREEN);
      } else if (AppShared.currentUser.type == Constants.USER_TYPE_DRIVER) {
        Navigator.of(context)
            .pushReplacementNamed(Constants.SCREENS_DRIVER_ORDERS_SCREEN);
      } else if (AppShared.currentUser.type == '2') {}
    } else {
      Navigator.pushReplacementNamed(context, Constants.SCREEN_SIGN_IN_SCREEN);
    }
    AppShared.introAdsResponse = null;
  }

// ||...................... logic methods ............................||
}

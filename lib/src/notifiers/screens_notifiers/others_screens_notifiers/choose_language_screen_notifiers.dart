import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/configs_controller.dart';
import 'package:moonapp/src/models/api_models/sub_models/category.dart' as cat;
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class ChooseLanguageScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = false;
  String _selectedLanguage = 'en';

  String get selectedLanguage => _selectedLanguage;

  set selectedLanguage(String value) {
    _selectedLanguage = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  ConfigsController configsController;

  // ||... constructor ...||
  ChooseLanguageScreenNotifiers(this.context) {
    configsController = ConfigsController.instance;
  }

// ||...................... logic methods ............................||

  // send and get app config.
  Future<void> getConfigs() async {
    AppShared.settingResponse = await configsController.getSetting();
    AppShared.settingResponse.settings.coffeeCategory.insert(0, cat.Category(id: 0, name: AppShared.appLang['All']));
    AppShared.settingResponse.settings.salonCategory.insert(0, cat.Category(id: 0, name: AppShared.appLang['All']));
    AppShared.settingResponse.settings.serviceCategory.insert(0, cat.Category(id: 0, name: AppShared.appLang['All']));
    AppShared.introAdsResponse = await configsController.getIntroAds();
  }

  // on lang chose.
  Future<void> onLangChose() async {
    isLoading = true;
  // try {
      await AppShared.sharedPreferencesController.setAppLang(selectedLanguage);
      await getConfigs();
      isLoading = false;
      if (AppShared.introAdsResponse.ads.isEmpty) {
        Navigator.pushReplacementNamed(
            context, Constants.SCREEN_SIGN_IN_SCREEN);
      } else
        Navigator.of(context)
            .pushReplacementNamed(Constants.SCREEN_INTRODUCTION_SCREEN);
    //}
//    catch (error) {
//      isLoading = false;
//      print(error);
//      Helpers.showMessage(
//          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
//    }
  }

// ||...................... logic methods ............................||
}

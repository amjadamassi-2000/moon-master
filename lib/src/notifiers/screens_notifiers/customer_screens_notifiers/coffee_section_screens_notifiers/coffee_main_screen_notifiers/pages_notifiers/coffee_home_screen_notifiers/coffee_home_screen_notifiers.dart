import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/app_shared.dart';

class CoffeeHomeScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  int _selectedScreen = 0;

  int get selectedScreen => _selectedScreen;

  set selectedScreen(int value) {
    _selectedScreen = value;
    notifyListeners();
  }
// ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  PageController pageController;
  List<String> titles;

  // ||... constructor ...||
  CoffeeHomeScreenNotifiers(this.context) {
    titles = [
      AppShared.appLang['Home'],
      AppShared.appLang['Cart'],
      AppShared.appLang['Offers'],
      AppShared.appLang['Profile']
    ];
    pageController = PageController(initialPage: _selectedScreen);
  }

// ||...................... logic methods ............................||

// ||...................... logic methods ............................||

}

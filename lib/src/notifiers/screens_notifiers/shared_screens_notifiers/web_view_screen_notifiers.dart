import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebViewScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isBtnVisible = false;

  bool get isBtnVisible => _isBtnVisible;

  set isBtnVisible(bool value) {
    _isBtnVisible = value;
    notifyListeners();
  }
  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  String paymentStatus;

  // ||... constructor ...||
  WebViewScreenNotifiers(this.context);

// ||...................... logic methods ............................||

// ||...................... logic methods ............................||

}

import 'package:flutter/foundation.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';

class CoffeeMainScreenNotifiers with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  ZoomDrawerController zoomDrawerController;

  CoffeeMainScreenNotifiers() {
    zoomDrawerController = ZoomDrawerController();
  }
}

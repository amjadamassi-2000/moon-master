import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';

class BeautyProductDetailsScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  int _selectedSlider = 0;
  int _selectedTab = 0;
  int _quantity = 0;
  int _selectedSizeIndex = 0;
  bool _isLoading = false;

  int get selectedSlider => _selectedSlider;

  set selectedSlider(int value) {
    _selectedSlider = value;
    notifyListeners();
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  int get selectedTab => _selectedTab;

  set selectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }

  int get selectedSizeIndex => _selectedSizeIndex;

  set selectedSizeIndex(int value) {
    _selectedSizeIndex = value;
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
  ProductsController _productsController;

  // ||... constructor ...||
  BeautyProductDetailsScreenNotifiers(this.context) {
    _productsController = ProductsController.instance;
  }

// ||...................... logic methods ............................||

// ||...................... logic methods ............................||

}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class ProductComponentNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = false;

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
  ProductComponentNotifiers(this.context) {
    _productsController = ProductsController.instance;
  }

// ||...................... logic methods ............................||

// add product to cart.
  void addProductToCart({
    @required int productId,
    int sizeId,
  }) async {
    try {
      isLoading = true;
      BaseResponse baseResponse = await _productsController.addProductToCart(
        productId: productId,
        sizeId: sizeId,
        quantity: 1,
      );
      isLoading = false;
      if (baseResponse.status) {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_SUCCESS);
      } else {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
      }
    } catch (error) {
      isLoading = false;
      print(error);
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }

// ||...................... logic methods ............................||

}

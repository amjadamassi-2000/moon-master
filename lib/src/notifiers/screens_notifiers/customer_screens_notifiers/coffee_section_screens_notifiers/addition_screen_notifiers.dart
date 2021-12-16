import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/cart_resposne.dart';
import 'package:moonapp/src/models/api_models/sub_models/addition.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/models/api_models/sub_models/size.dart';
import 'package:moonapp/src/utils/constants.dart';

class AdditionScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = true;
  bool _refreshList = false;

  num _subTotal = 0;
  num _totalAdditions = 0;
  num _total = 0;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get refreshList => _refreshList;

  set refreshList(bool value) {
    _refreshList = value;
    notifyListeners();
  }

  num get subTotal => _subTotal;

  set subTotal(num value) {
    _subTotal = value;
    notifyListeners();
  }

  num get total => _total;

  set total(num value) {
    _total = value;
    notifyListeners();
  }

  num get totalAdditions => _totalAdditions;

  set totalAdditions(num value) {
    _totalAdditions = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  ProductsController _productsController;
  CartResponse cartResponse;
  Cart cart;

  // ||... constructor ...||
  AdditionScreenNotifiers(this.context, this.cart) {
    _productsController = ProductsController.instance;
    calculateProductPrice(cart);
  }

  // ||...................... logic methods ............................||

  // get size by id.
  Size getCartProductSize(int sizeId, Product product) {
    return product
        .sizes[product.sizes.indexWhere((element) => element.id == sizeId)];
  }

  // on addition unselected.
  void onAdditionUnselected(Addition addition) {
    totalAdditions -= addition.addition.price * addition.quantity;
    total = subTotal + totalAdditions;
  }

// on quantity changed.
  void onQuantityChanged(num value, int type) {
    if (type == Constants.CHANGE_QUANTITY_TYPE_INCREMENT) {
      totalAdditions += value;
      total += value;
    } else {
      totalAdditions -= value;
      total -= value;
    }
  }

  void calculateProductPrice(Cart cart) {
    if (cart.product.sizes.isEmpty) {
      if (cart.product.discount == 0)
        _subTotal = cart.product.price * cart.quantity;
      else
        _subTotal = cart.product.discount * cart.quantity;
    } else {
      _subTotal =
          num.parse(getCartProductSize(cart.sizeId, cart.product).price) *
              cart.quantity;
    }

    cart.additions.forEach((element) {
      _totalAdditions += element.addition.price * element.quantity;
    });
    _total = _totalAdditions + _subTotal;
  }
// ||...................... logic methods ............................||
}

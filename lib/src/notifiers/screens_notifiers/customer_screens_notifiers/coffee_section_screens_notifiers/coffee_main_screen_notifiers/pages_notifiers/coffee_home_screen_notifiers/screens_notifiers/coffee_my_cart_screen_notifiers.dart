import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/cart_resposne.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/models/api_models/sub_models/size.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class CoffeeMyCartScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = true;
  bool _refreshList = false;

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

  num get total => _total;

  set total(num value) {
    _total = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  ProductsController _productsController;
  CartResponse cartResponse;

  bool isError = false;

  // ||... constructor ...||
  CoffeeMyCartScreenNotifiers(this.context) {
    _productsController = ProductsController.instance;

  }

  // ||...................... logic methods ............................||



  // get cart.
  void getCart({bool isInit = true}) async {
    //try {
      if (!isInit) {
        isError = false;
        isLoading = true;
      }
      cartResponse = await _productsController.getCart();
      calculate();
      isLoading = false;
      if (!cartResponse.status)
        Helpers.showMessage(cartResponse.message, MessageType.MESSAGE_FAILED);
   // }
//    catch (error) {
//      isError = true;
//      isLoading = false;
//      print(error.toString());
//      Helpers.showMessage(
//          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
//    }
  }







  // on product removed from cart.
  void onProductRemoved(Cart cart) {
    if (cart.product.sizes.isEmpty) {
      if (cart.product.discount == 0)
        total -= cart.product.price * cart.quantity;
      else
        total -= cart.product.discount * cart.quantity;
    } else {
      total -= num.parse(getCartProductSize(cart.sizeId, cart.product).price) *
          cart.quantity;
    }
    cartResponse.cart.remove(cart);
    refreshList = !refreshList;
  }

  // on quantity changed.
  void onQuantityChanged(Cart cart, int type) {
    if (type == Constants.CHANGE_QUANTITY_TYPE_INCREMENT) {
      if (cart.product.sizes.isEmpty) {
        if (cart.product.discount == 0)
          total += cart.product.price;
        else
          total += cart.product.price;
      } else {
        total += num.parse(getCartProductSize(cart.sizeId, cart.product).price);
      }
    } else {
      if (cart.product.sizes.isEmpty) {
        if (cart.product.discount == 0)
          total -= cart.product.price;
        else
          total -= cart.product.price;
      } else {
        total -= num.parse(getCartProductSize(cart.sizeId, cart.product).price);
      }
    }
  }

  // get size by id.
  Size getCartProductSize(int sizeId, Product product) {
    return product
        .sizes[product.sizes.indexWhere((element) => element.id == sizeId)];
  }

  // calculate.
  void calculate() {
    num subTotal = 0;
    num discount = 0;
    cartResponse.cart.forEach((element) {
      if (element.product.sizes.isEmpty) {

        if (element.product.discount == 0)
          subTotal += element.product.price * element.quantity;
        else
          subTotal += element.product.price * element.quantity;
      } else
        subTotal += num.parse(
                getCartProductSize(element.sizeId, element.product).price) *
            element.quantity;
      if (element.product.additions.isNotEmpty && element.additions.isNotEmpty)
        element.additions.forEach((element) {
          subTotal += element.quantity * element.addition.price;
        });
    });
    _total = subTotal;
  }

// ||...................... logic methods ............................||
}

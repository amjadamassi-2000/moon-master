import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/coffee_section_controllers/checkout_controller.dart';
import 'package:moonapp/src/models/api_models/customer_models/coffee_section_models/responses/coffee_checkout_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/coffee_section_models/responses/coffee_promo_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/cart_resposne.dart';
import 'package:moonapp/src/models/api_models/sub_models/order.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/models/api_models/sub_models/size.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class CoffeeCheckoutScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isPromoLoading = false;
  bool _refreshBill = false;
  bool _isPromoCodeWrong;
   Order order;


  num _deliveryCost = Helpers.getCityById(AppShared.currentUser.cityId).deliveryCost;

  int _orderReceiveMethod = 1;
  int _paymentMethod = 1;

  bool get isPromoLoading => _isPromoLoading;

  set isPromoLoading(bool value) {
    _isPromoLoading = value;
    notifyListeners();
  }

  bool get isPromoCodeWrong => _isPromoCodeWrong;

  set isPromoCodeWrong(bool value) {
    _isPromoCodeWrong = value;
    notifyListeners();
  }

  int get orderReceiveMethod => _orderReceiveMethod;

  set orderReceiveMethod(int value) {
    _orderReceiveMethod = value;
    notifyListeners();
  }

  bool get refreshBill => _refreshBill;

  set refreshBill(bool value) {
    _refreshBill = value;
    notifyListeners();
  }

  List<String> orderReceiveOptions = [
    AppShared.appLang['Delivery'],
    AppShared.appLang['Takeout']
  ];

  num get deliveryCost => _deliveryCost;

  set deliveryCost(num value) {

    _deliveryCost = value;


    notifyListeners();
    calculate();
  }

  int get paymentMethod => _paymentMethod;

  set paymentMethod(int value) {
    _paymentMethod = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  CheckoutController coffeeCheckoutController;
  GlobalKey<FormState> checkoutFormState;

  List<Cart> products;


  TextEditingController promoTextEditingController;
  TextEditingController deliveryTimeTextEditingController;

  String promoCodeStatus = '';

  String name;
  int cityId;
  String mobile;
  String address;
  String details;
  String tableNumber;
  LatLng selectedPosition;

  num total = 0;
  num subTotal = 0;
  num discount = 0;

  // ||... constructor ...||
  CoffeeCheckoutScreenNotifiers(this.context, this.products) {
    coffeeCheckoutController = CheckoutController.instance;
    checkoutFormState = GlobalKey();
    promoTextEditingController = TextEditingController();
    deliveryTimeTextEditingController = TextEditingController();
    deliveryTimeTextEditingController.text = Helpers.formatTime(TimeOfDay.now());
    cityId = AppShared.currentUser.cityId ;
    calculate();
  }

  // ||...................... logic methods ............................||

  //check promo.
  void checkPromo() async {
    try {
      if (promoTextEditingController.text.isEmpty) return;
      isPromoCodeWrong = null;
      isPromoLoading = true;
      CoffeePromoResponse coffeePromoResponse =
          await coffeeCheckoutController.checkPromo(
        code: promoTextEditingController.text,
      );
      isPromoLoading = false;
      if (coffeePromoResponse.status) {
        Helpers.showMessage(
            coffeePromoResponse.message, MessageType.MESSAGE_SUCCESS);
        discount += (coffeePromoResponse.discount / 100) * subTotal;
        isPromoCodeWrong = false;
        promoTextEditingController.clear();
        promoCodeStatus =
            '${AppShared.appLang['YouHaveDiscount']} ${coffeePromoResponse.discount}%';
        calculate(isFirstTime: false);
      }


      else {
        Helpers.showMessage(
            coffeePromoResponse.message, MessageType.MESSAGE_FAILED);
        isPromoCodeWrong = true;
        promoCodeStatus = AppShared.appLang['DiscountCodeIsInvalid'];
      }
   }

    catch (error) {
      isPromoLoading = false;
      print(error);
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }

  }





  // checkout.
  void checkout(startLoading, stopLoading, btnState) async {
   // try {
      if (!checkoutFormState.currentState.validate()) return;
      if (orderReceiveMethod == 1 && selectedPosition == null) {
        Helpers.showMessage(AppShared.appLang['YouMustSelectALocation'],
            MessageType.MESSAGE_FAILED);
        return;
      }
      checkoutFormState.currentState.save();
      startLoading();
      CoffeeCheckoutResponse coffeeCheckoutResponse =
          await coffeeCheckoutController.checkout(
        deliveryMethod: _orderReceiveMethod,
        address: address,
        name: name,
        cityId: cityId ?? AppShared.currentUser.cityId,
        mobile: mobile,
        paymentMethod: paymentMethod,
        promoCodeName: promoTextEditingController.text,
        deliveryTime: deliveryTimeTextEditingController.text,
        tableNumber: tableNumber,
        details: details,
        longitude: selectedPosition == null
            ? '0'
            : selectedPosition.longitude.toString(),
        latitude: selectedPosition == null
            ? '0'
            : selectedPosition.latitude.toString(),
      );
      stopLoading();
      if (coffeeCheckoutResponse.status) {
        if (coffeeCheckoutResponse.link == null) {
          Helpers.showMessage(
              coffeeCheckoutResponse.message, MessageType.MESSAGE_SUCCESS);
          Navigator.pushNamedAndRemoveUntil(
              context, Constants.SCREENS_COFFEE_MAIN_SCREEN, (route) => false);
        } else {
          Navigator.of(context).pushNamed(Constants.SCREENS_WEB_VIEW_SCREEN,
              arguments: coffeeCheckoutResponse.link);
        }
      } else
        Helpers.showMessage(
            coffeeCheckoutResponse.message, MessageType.MESSAGE_FAILED);
    //}
//    catch (error) {
//      stopLoading();
//      print(error);
//      Helpers.showMessage(
//          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
//    }

  }

  // get size by id.
  Size getCartProductSize(int sizeId, Product product) {
    return product
        .sizes[product.sizes.indexWhere((element) => element.id == sizeId)];
  }

// calculate.
  void calculate({bool isFirstTime = true}) {
    if (isFirstTime)
      products.forEach((element) {
        if (element.product.sizes.isEmpty) {
          if (element.product.discount == 0)
            subTotal += element.product.price * element.quantity;
          else
            subTotal += element.product.price * element.quantity;
        } else
          subTotal += num.parse(getCartProductSize(element.sizeId, element.product).price) *
              element.quantity;
        if (element.product.additions.isNotEmpty &&
            element.additions.isNotEmpty)
          element.additions.forEach((element) {
            subTotal += element.quantity * element.addition.price;
          });
      });
    total = subTotal - discount + deliveryCost;
    if (!isFirstTime) refreshBill = !refreshBill;
  }

  // calculate product price.
  num calculateProductPrice(Cart element) {
    num total = 0;
    num subTotal = 0;
    num discount = 0;
    if (element.product.sizes.isEmpty) {
      if (element.product.discount == 0)
        subTotal += element.product.price * element.quantity;
      else
        subTotal += element.product.price * element.quantity;
    } else
      subTotal +=
          num.parse(getCartProductSize(element.sizeId, element.product).price) *
              element.quantity;
    if (element.product.additions.isNotEmpty && element.additions.isNotEmpty)
      element.additions.forEach((element) {
        subTotal += element.quantity * element.addition.price;
      });
    return total = subTotal ;
  }

  Future<String> GetAddressFromLatLong(LatLng latLng)async {
    final coordinates = new Coordinates(latLng.latitude, latLng.longitude);
    List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    Address  first = addresses.first;
    print("GetAddressFromLatLong ${first.featureName} : ${first.addressLine}");
    return first.addressLine ;
  }
// ||...................... logic methods ............................||
}

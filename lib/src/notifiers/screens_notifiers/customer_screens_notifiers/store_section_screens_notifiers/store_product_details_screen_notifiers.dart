import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/product_details_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/similar_products_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class StoreProductDetailsScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  int _selectedSlider = 0;
  int _selectedTab = 0;
  int _quantity = 0;
  int _selectedSizeIndex = 0;
  bool _isLoading = false;



  bool _isRateLoading = false;
  bool _isReviewsLoading = true;
  bool _isSimilarProductsLoading = true;

  int get selectedSlider => _selectedSlider;

  set selectedSlider(int value) {
    _selectedSlider = value;
    notifyListeners();
  }

  bool get isRateLoading => _isRateLoading;

  set isRateLoading(bool value) {
    _isRateLoading = value;
    notifyListeners();
  }

  int get selectedTab => _selectedTab;

  set selectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  bool get isReviewsLoading => _isReviewsLoading;

  set isReviewsLoading(bool value) {
    _isReviewsLoading = value;
    notifyListeners();
  }

  bool get isSimilarProductsLoading => _isSimilarProductsLoading;

  set isSimilarProductsLoading(bool value) {
    _isSimilarProductsLoading = value;
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
  ProductsController productsController;
  GlobalKey<FormState> rateFromState;

  ProductDetailsResponse productDetailsResponse;
  SimilarProductsResponse similarProductsResponse;

  num rate = 1;
  String comment;

  // ||... constructor ...||
  StoreProductDetailsScreenNotifiers(this.context) {
    productsController = ProductsController.instance;
    rateFromState = GlobalKey();
  }

// ||...................... logic methods ............................||

// add product to cart.
  void addProductToCart({
    @required int productId,
    int sizeId,
  }) async {
  //  try {
      print(sizeId);


      if (quantity == 0) {
        Helpers.showMessage(AppShared.appLang['PleaseDetermineAQuantity'],
            MessageType.MESSAGE_FAILED);
        return;
      }

      isLoading = true;
      BaseResponse baseResponse = await productsController.addProductToCart(
        productId: productId,
        sizeId: sizeId,
        quantity: quantity,
      );
      isLoading = false;
      if (baseResponse.status) {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_SUCCESS);
      } else {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
      }
   // }

//    catch (error) {
//      isLoading = false;
//      print(error);
//      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
//    }

  }

  // get product details.
  void getProductDetails(int productId) async {
    try {
      productDetailsResponse =
          await productsController.getProductDetails(productId: productId);
      isReviewsLoading = false;
      if (!productDetailsResponse.status)
        Helpers.showMessage(
            productDetailsResponse.message, MessageType.MESSAGE_FAILED);
    } catch (error) {
      isReviewsLoading = false;
      print(error.toString());
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }
  }

  // get similar products.
  void getSimilarProducts(int productId) async {
    try {
      similarProductsResponse =
          await productsController.getSimilarProducts(productId);
      isSimilarProductsLoading = false;
      if (!similarProductsResponse.status)
        Helpers.showMessage(
            similarProductsResponse.message, MessageType.MESSAGE_FAILED);
    } catch (error) {
      isSimilarProductsLoading = false;
      print(error.toString());
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }
  }

  // rate a product.
  void rateProduct(int productId) async {
    if (!rateFromState.currentState.validate()) return;
    rateFromState.currentState.save();
    try {
      isRateLoading = true;
      BaseResponse baseResponse = await productsController.rateProduct(
          productId: productId, rate: rate, comment: comment);
      isRateLoading = false;
      if (baseResponse.status) {
        rateFromState.currentState.reset();
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_SUCCESS);
      } else
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
    } catch (error) {
      isRateLoading = false;
      print(error.toString());
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }
  }

// ||...................... logic methods ............................||

}

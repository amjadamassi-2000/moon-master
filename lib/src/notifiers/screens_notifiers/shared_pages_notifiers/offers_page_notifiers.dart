import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/products_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class OffersPageNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = true;
  bool _isNewDataLoaded = false;
  bool _isPagingLoading = false;

  bool get isPagingLoading => _isPagingLoading;

  set isPagingLoading(bool value) {
    _isPagingLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isNewDataLoaded => _isNewDataLoaded;

  set isNewDataLoaded(bool value) {
    _isNewDataLoaded = value;
    notifyListeners();
  }
  // ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  ProductsController _productsController;
  ProductsResponse productsResponse;
  ScrollController offersScrollController;
  int page = 1;

  bool isError = false;

  // ||... constructor ...||
  OffersPageNotifiers(this.context) {
    _productsController = ProductsController.instance;
    offersScrollController = ScrollController();
    offersScrollController.addListener(() {
      if (offersScrollController.position.pixels ==
          offersScrollController.position.maxScrollExtent) {
        if (isLoading || isPagingLoading) return;
        getOffers();
      }
    });
  }

// ||...................... logic methods ............................||

  // get offers.
  void getOffers({bool isInit = true}) async {
    if (page == 1) {
    //  try {
        if (!isInit) {
          isError = false;
          isLoading = true;
        }
        productsResponse = await _productsController.getOffers();
        isLoading = false;
        if (!productsResponse.status)
          Helpers.showMessage(
              productsResponse.message, MessageType.MESSAGE_FAILED);
        else
          page++;
     // }

//      catch (error) {
//        isError = true;
//        isLoading = false;
//        print(error.toString());
//        Helpers.showMessage(AppShared.appLang['SomethingWentWrong'],
//            MessageType.MESSAGE_FAILED);
//      }
    } else {
    //  try {
        if (page > productsResponse.products.lastPage) return;
        isPagingLoading = true;
        ProductsResponse response =
            await _productsController.getOffers(page: page);
        isPagingLoading = false;
        if (response.status) {
          productsResponse.products.data.addAll(response.products.data);
          isNewDataLoaded = !isNewDataLoaded;
          page++;
        } else {
          Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
        }
      //}

//      catch (error) {
//        print(error.toString());
//        Helpers.showMessage(AppShared.appLang['SomethingWentWrong'],
//            MessageType.MESSAGE_FAILED);
//      }

    }
  }









// ||...................... logic methods ............................||
}

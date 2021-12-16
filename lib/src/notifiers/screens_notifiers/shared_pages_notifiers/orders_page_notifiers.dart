import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/shared_controllers/orders_controller.dart';
import 'package:moonapp/src/models/api_models/shared_models/orders_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class OrdersPageNotifiers with ChangeNotifier {
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
  OrdersController ordersController;
  OrdersResponse ordersResponse;
  ScrollController ordersScrollController;
  int page = 1;

  bool isError = false;

  // ||... constructor ...||
  OrdersPageNotifiers(this.context) {
    ordersController = OrdersController.instance;
    ordersScrollController = ScrollController();
    ordersScrollController.addListener(() {
      if (ordersScrollController.position.pixels ==
          ordersScrollController.position.maxScrollExtent) {
        if (isLoading || isPagingLoading) return;
        getOrders();
      }
    });
  }

// ||...................... logic methods ............................||

  // get orders.
  Future getOrders({bool isInit = true}) async {
    if (page == 1) {
      try {
        if (!isInit) {
          isError = false;
          isLoading = true;
        }
        ordersResponse = await ordersController.getOrdersForCustomer();
        isLoading = false;
        if (!ordersResponse.status)
          Helpers.showMessage(
              ordersResponse.message, MessageType.MESSAGE_FAILED);
        else
          page++;
      } catch (error) {
        isError = true;
        isLoading = false;
        print(error.toString());
        Helpers.showMessage(AppShared.appLang['SomethingWentWrong'],
            MessageType.MESSAGE_FAILED);
      }
    } else {
      //  try {
      if (page > ordersResponse.orders.lastPage) return;
      isPagingLoading = true;
      OrdersResponse response =
          await ordersController.getOrdersForCustomer(page: page);
      isPagingLoading = false;
      if (response.status) {
        ordersResponse.orders.data.addAll(response.orders.data);
        isNewDataLoaded = !isNewDataLoaded;
        page++;
      } else {
        Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
      }
      //  }
//      catch (error) {
//        print(error.toString());
//        Helpers.showMessage(AppShared.appLang['SomethingWentWrong'],
//            MessageType.MESSAGE_FAILED);
//      }

    }
  }

// ||...................... logic methods ............................||
}

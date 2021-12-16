import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/shared_models/order_details_response.dart';
import 'package:moonapp/src/models/api_models/shared_models/orders_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';

class OrdersController {
  static OrdersController _instance;

  // ||.. private constructor ..||
  OrdersController._();

  // ||.. singleton pattern ..||
  static OrdersController get instance {
    if (_instance != null) return _instance;
    return _instance = OrdersController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  // ||.. get orders for customer ..||
  Future<OrdersResponse> getOrdersForCustomer({int page = 1}) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getMyOrdersAsUser/${AppShared.sharedPreferencesController.getSectionType()}?page=$page',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${AppShared.currentUser.accessToken}',
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );
    OrdersResponse ordersResponse = OrdersResponse.fromJson(response.data);
    return ordersResponse;
  }

  // ||.. get orders for customer ..||
  Future<OrdersResponse> getOrdersForDriver({int page = 1}) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getMyOrdersAsDriver?page=$page',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${AppShared.currentUser.accessToken}',
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );
    OrdersResponse ordersResponse = OrdersResponse.fromJson(response.data);
    return ordersResponse;
  }

  // ||.. get order details ..||
  Future<OrderDetailsResponse> getOrderDetails({
    @required int orderId,
  }) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getOrderDetails/$orderId',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${AppShared.currentUser.accessToken}',
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );
    OrderDetailsResponse orderDetailsResponse = OrderDetailsResponse.fromJson(response.data);
    return orderDetailsResponse;
  }

  // ||..change order status ..||
  Future<BaseResponse> changeOrderStatus(int orderId, int status) async {
    Response response =
        await AppShared.dio.post('${Constants.API_BASE_URL}changeOrderStatus',
            options: Options(
              headers: {
                'Authorization': 'Bearer ${AppShared.currentUser.accessToken}',
                'fcmToken': AppShared.firebaseToken,
                'Accept-Language':
                    AppShared.sharedPreferencesController.getAppLang(),
              },
            ),
            data: {
          'order_id': orderId,
          'status': status,
        });
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    return baseResponse;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moonapp/src/models/api_models/customer_models/coffee_section_models/requests/coffee_checkout_request.dart';
import 'package:moonapp/src/models/api_models/customer_models/coffee_section_models/responses/coffee_checkout_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/coffee_section_models/responses/coffee_promo_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';

class CheckoutController {
  static CheckoutController _instance;

  // ||.. private constructor ..||
  CheckoutController._();

  // ||.. singleton pattern ..||
  static CheckoutController get instance {
    if (_instance != null) return _instance;
    return _instance = CheckoutController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  // checkout
  Future<CoffeeCheckoutResponse> checkout({
    String tableNumber,
    int deliveryMethod,
    int paymentMethod,
    String address,
    String deliveryTime,
    String bookTime,
    String bookDate,
    String promoCodeName,
    String name,
    String mobile,
    int cityId,
    String details,
    String latitude,
    String longitude,
  }) async {
    CheckoutRequest checkoutRequest = CheckoutRequest(
      paymentMethod: paymentMethod,
      type: AppShared.sharedPreferencesController.getSectionType(),
      cityId: cityId,
      mobile: mobile,
      customerName: name,
      address: address,
      deliveryMethod: deliveryMethod,
      deliveryTime: deliveryTime,
      details: details,
      latitude: latitude,
      longitude: longitude,
      promoCodeName: promoCodeName,
      tableNumber: tableNumber,
      date: bookDate,
      time: bookTime,
    );
    print(checkoutRequest.toJson());
    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}checkOut',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${AppShared.currentUser.accessToken}',
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
      data: AppShared.sharedPreferencesController.getSectionType() == 3
          ? {
              'type': AppShared.sharedPreferencesController.getSectionType(),
              'customer_name': name,
              'city_id': cityId,
              'payment_method': paymentMethod,
              'service_date': bookDate,
              'service_time': bookTime,
              "mobile" : mobile,
              "details" : details,
            }
          : checkoutRequest.toJson(),
    );
    var m = response.data['message'];
    print(response.data);
    print(m.runtimeType.toString());
    CoffeeCheckoutResponse coffeeCheckoutResponse =
        CoffeeCheckoutResponse.fromJson(response.data);
    return coffeeCheckoutResponse;
  }

  // check promo
  Future<CoffeePromoResponse> checkPromo({
    @required String code,
  }) async {
    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}checkPromoCode',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${AppShared.currentUser.accessToken}',
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
      data: {
        'promoCode_name': code,
      },
    );
    CoffeePromoResponse coffeePromoResponse =
        CoffeePromoResponse.fromJson(response.data);
    return coffeePromoResponse;
  }

  // checkout service
  Future<CoffeeCheckoutResponse> checkoutService({
    @required int deliveryMethod,
    @required int paymentMethod,
    @required int serviceId,
    @required String bookTime,
    @required String bookDate,
    String promoCodeName,
    String details,
  }) async {
    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}checkOutService',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${AppShared.currentUser.accessToken}',
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
      data: {
        'service_id': serviceId,
        'date': bookDate,
        'time': bookTime,
        'payment_method': paymentMethod,
        'details': details,
        'promoCode_name': promoCodeName,
      },
    );
    print(response.data);
    CoffeeCheckoutResponse coffeeCheckoutResponse =
        CoffeeCheckoutResponse.fromJson(response.data);
    return coffeeCheckoutResponse;
  }
}

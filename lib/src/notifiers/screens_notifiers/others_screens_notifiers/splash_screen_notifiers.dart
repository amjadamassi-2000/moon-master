import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/configs_controller.dart';
import 'package:moonapp/src/controllers/api_controllers/shared_controllers/orders_controller.dart';
import 'package:moonapp/src/models/api_models/shared_models/order_details_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/category.dart' as cat;
import 'package:moonapp/src/models/api_models/sub_models/order.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/services/firebase_messaging_service.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:provider/provider.dart';

class SplashScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||

  // ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  ConfigsController configsController;
  AppNotifiers _appNotifiers;
  OrdersController ordersController;

  // ||... constructor ...||
  SplashScreenNotifiers(this.context) {
    configsController = ConfigsController.instance;
    ordersController = OrdersController.instance;
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
  }

// ||...................... logic methods ............................||

  // init.
  void init() async {
    await Future.delayed(Duration(seconds: 2));
    AppShared.isTablet = MediaQuery.of(context).size.width >= 600;
    print(AppShared.isTablet);
    AppShared.dio = Dio();
//    AppShared.sharedPreferencesController.clear();
    AppShared.deviceType = Platform.isAndroid ? 'android' : 'ios';
    AppShared.firebaseToken =
        await FirebaseMessagingService.instance.getToken();
    print(AppShared.firebaseToken);
    if (_appNotifiers.notification != null) {
      if (AppShared.sharedPreferencesController.getIsLogin()) {
        AppShared.currentUser =
            AppShared.sharedPreferencesController.getUserData();
        AppShared.sharedPreferencesController.setIsLogin(true);
      }
      if (_appNotifiers.notification['data'] == null) {
        String orderId = _appNotifiers.notification['target_id'];
        if (orderId == null) {
          checkOnStart();
        } else {
          Order order = await getOrderDetails(int.parse(orderId));
          if (order.type == Constants.SECTION_TYPE_COFFEE) {
            Navigator.of(context).pushNamed(
                Constants.SCREENS_COFFEE_PRODUCTS_ORDER_DETAILS_SCREEN,
                arguments: order);
          } else if (order.type == Constants.SECTION_TYPE_STORE) {
            Navigator.of(context).pushNamed(
                Constants.SCREENS_STORE_PRODUCTS_ORDER_DETAILS_SCREEN,
                arguments: order);
          } else if (order.type == Constants.SECTION_TYPE_SALON) {
            Navigator.of(context).pushNamed(
                Constants.SCREENS_BEAUTY_PRODUCTS_ORDER_DETAILS_SCREEN,
                arguments: order);
          }
        }
      } else {
        String orderId = _appNotifiers.notification['target_id'];
        if (orderId == null) {
          checkOnStart();
        } else {
          Order order = await getOrderDetails(int.parse(orderId));
          if (order.type == Constants.SECTION_TYPE_COFFEE) {
            Navigator.of(context).pushNamed(
                Constants.SCREENS_COFFEE_PRODUCTS_ORDER_DETAILS_SCREEN,
                arguments: order);
          } else if (order.type == Constants.SECTION_TYPE_STORE) {
            Navigator.of(context).pushNamed(
                Constants.SCREENS_STORE_PRODUCTS_ORDER_DETAILS_SCREEN,
                arguments: order);
          } else if (order.type == Constants.SECTION_TYPE_SALON) {
            Navigator.of(context).pushNamed(
                Constants.SCREENS_BEAUTY_PRODUCTS_ORDER_DETAILS_SCREEN,
                arguments: order);
          }
        }
      }
    } else {
      checkOnStart();
    }
  }

  //get order details
  Future<Order> getOrderDetails(int orderId) async {
    try {
      OrderDetailsResponse orderDetailsResponse =
          await ordersController.getOrderDetails(orderId: orderId);
      if (orderDetailsResponse.status) {
        return orderDetailsResponse.orders;
      } else {
        print(orderDetailsResponse.message);
        return null;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // check on start.
  void checkOnStart() async {
    if (AppShared.sharedPreferencesController.getAppLang() != null) {
      AppShared.settingResponse = await configsController.getSetting();
      AppShared.settingResponse.settings.coffeeCategory
          .insert(0, cat.Category(id: 0, name: AppShared.appLang['All']));
      AppShared.settingResponse.settings.salonCategory
          .insert(0, cat.Category(id: 0, name: AppShared.appLang['All']));
      AppShared.settingResponse.settings.serviceCategory
          .insert(0, cat.Category(id: 0, name: AppShared.appLang['All']));
      if (AppShared.sharedPreferencesController.getIsLogin()) {
        AppShared.currentUser =
            AppShared.sharedPreferencesController.getUserData();
        AppShared.sharedPreferencesController.setIsLogin(true);
        if (AppShared.currentUser.type == Constants.USER_TYPE_CUSTOMER) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Constants.SCREEN_CHOOSE_SECTION_SCREEN, (route) => false);
        } else if (AppShared.currentUser.type == Constants.USER_TYPE_DRIVER) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Constants.SCREENS_DRIVER_ORDERS_SCREEN, (route) => false);
        } else if (AppShared.currentUser.type == Constants.USER_TYPE_WAITER)
          Navigator.pushNamedAndRemoveUntil(
              context, Constants.SCREENS_COFFEE_MAIN_SCREEN, (route) => false);
      } else {
        Navigator.pushReplacementNamed(
            context, Constants.SCREEN_SIGN_IN_SCREEN);
      }
    } else
      Navigator.pushReplacementNamed(
          context, Constants.SCREEN_CHOOSE_LANGUAGE_SCREEN);
  }

// ||...................... logic methods ............................||
}

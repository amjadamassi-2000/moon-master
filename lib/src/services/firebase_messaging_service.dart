import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moonapp/src/controllers/api_controllers/shared_controllers/orders_controller.dart';
import 'package:moonapp/src/models/api_models/shared_models/order_details_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/order.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';

import 'local_notifications_service.dart';

class FirebaseMessagingService {
  AppNotifiers appNotifiers;
  static FirebaseMessagingService _instance;
  FirebaseMessaging _fcm;
  LocalNotificationsService _localNotificationsService;
  OrdersController ordersController;

  FirebaseMessagingService._() {
    _fcm = FirebaseMessaging();
    _localNotificationsService = LocalNotificationsService.instance;
    ordersController = OrdersController.instance;
  }

  // ||.. singleton pattern ..||
  static FirebaseMessagingService get instance {
    if (_instance != null) return _instance;
    return _instance = FirebaseMessagingService._();
  }

  Future<String> getToken() async {
    return _fcm.getToken();
  }

  void init(AppNotifiers appNotifiers) async {
    this.appNotifiers = appNotifiers;
    _fcm.requestNotificationPermissions(IosNotificationSettings());
    _fcm.subscribeToTopic(Constants.FIREBASE_MESSAGING_TOPIC);
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        if (message['data'] == null) {
          if (AppShared.sharedPreferencesController.isNotificationEnabled())
            _localNotificationsService.showNotification(
              message['title'],
              message['body'],
              payload: jsonEncode(appNotifiers.notification),
            );
        } else {
          if ((message['data'] as Map).isEmpty) {
            if (AppShared.sharedPreferencesController.isNotificationEnabled())
              _localNotificationsService.showNotification(
                message['notification']['title'],
                message['notification']['body'],
                payload: jsonEncode(appNotifiers.notification),
              );
          } else {
            if (AppShared.sharedPreferencesController.isNotificationEnabled())
              _localNotificationsService.showNotification(
                message['data']['title'],
                message['data']['body'],
                payload: jsonEncode(appNotifiers.notification),
              );
          }
        }
//        appNotifiers.notificationsCount = ++appNotifiers.notificationsCount;
//        AppShared.sharedPreferencesController
//            .setNotificationsCount(appNotifiers.notificationsCount);
//        if (appNotifiers.notification['msgType'] == null) {

//        return;
//        }
//        if (appNotifiers.notification['data']['msgType'] == '2') {
//          if (appNotifiers.isInsideChatScreen) {
//            appNotifiers.chatRefresh = !appNotifiers.chatRefresh;
//          } else {
//            if (AppShared.sharedPreferencesController
//                .isNotificationsAvailable())
//              _localNotificationsService.showNotification(
//                message['notification']['title'],
//                message['notification']['body'],
//                payload: jsonEncode(appNotifiers.notification),
//              );
//          }
//        } else if (appNotifiers.notification['data']['msgType'] == '1') {
//          if (appNotifiers.isInsideOrderScreen) {
//            appNotifiers.canLoadNewOffers = true;
//            appNotifiers.offersRefresh = !appNotifiers.offersRefresh;
//          } else if (AppShared.sharedPreferencesController
//              .isNotificationsAvailable())
//            _localNotificationsService.showNotification(
//              message['notification']['title'],
//              message['notification']['body'],
//              payload: jsonEncode(appNotifiers.notification),
//            );
//        }
//        if (appNotifiers.isInsideOffersScreen) {
//          appNotifiers.canRefreshOffers = true;
//          appNotifiers.offersScreenRefresh = !appNotifiers.offersScreenRefresh;
//          if (AppShared.sharedPreferencesController.isNotificationsAvailable())
//            _localNotificationsService.showNotification(
//              message['notification']['title'],
//              message['notification']['body'],
//              payload: jsonEncode(appNotifiers.notification),
//            );
//        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        appNotifiers.notification = message;
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        try {
          Map<String, dynamic> notification = message;
          String orderId;
          if (notification['data'] == null) {
            orderId = notification['target_id'];
          } else {
            orderId = notification['data']['target_id'];
          }
          if (orderId == null) return;
          OrderDetailsResponse orderDetailsResponse = await ordersController
              .getOrderDetails(orderId: int.parse(orderId));
          Order order = orderDetailsResponse.orders;
          if (order.type == Constants.SECTION_TYPE_COFFEE) {
            appNotifiers.navigatorKey.currentState.pushNamed(
              Constants.SCREENS_COFFEE_PRODUCTS_ORDER_DETAILS_SCREEN,
              arguments: order,
            );
          } else if (order.type == Constants.SECTION_TYPE_STORE) {
            appNotifiers.navigatorKey.currentState.pushNamed(
              Constants.SCREENS_STORE_PRODUCTS_ORDER_DETAILS_SCREEN,
              arguments: order,
            );
          } else if (order.type == Constants.SECTION_TYPE_SALON) {
            appNotifiers.navigatorKey.currentState.pushNamed(
              Constants.SCREENS_BEAUTY_PRODUCTS_ORDER_DETAILS_SCREEN,
              arguments: order,
            );
          }
        } catch (error) {
          print(error.toString());
//    }
        }
//        String targetId = message['data']['target_id'];
//        if (appNotifiers.notification['data']['msgType'] == '1')
//          appNotifiers.navigatorKey.currentState.pushNamed(
//            Constants.SCREENS_ORDER_DETAILS_SCREEN,
//            arguments: [int.parse(targetId), false],
//          );
//        else if (appNotifiers.notification['data']['msgType'] == '2')
//          appNotifiers.navigatorKey.currentState.pushNamed(
//            Constants.SCREENS_CHAT_SCREEN,
//            arguments: [int.parse(targetId), false],
//          );
      },
    );
  }
}

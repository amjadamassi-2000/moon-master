import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moonapp/src/controllers/api_controllers/shared_controllers/orders_controller.dart';
import 'package:moonapp/src/models/api_models/shared_models/order_details_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/order.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/utils/constants.dart';

class LocalNotificationsService {
  static LocalNotificationsService _instance;
  BuildContext _context;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  AppNotifiers _appNotifiers;
  int _id = 0;
  OrdersController ordersController;

  // ||.. private constructor ..||
  LocalNotificationsService._() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    ordersController = OrdersController.instance;
  }

  // ||.. singleton pattern ..||
  static LocalNotificationsService get instance {
    if (_instance != null) return _instance;
    return _instance = LocalNotificationsService._();
  }

  //init.
  Future<void> init(BuildContext context, AppNotifiers appNotifiers) async {
    this._context = context;
    _appNotifiers = appNotifiers;
    await _initLocalNotifications();
  }

  // local notifications init.
  Future<void> _initLocalNotifications() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _selectNotification);
  }

  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: _context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
            },
          )
        ],
      ),
    );
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

  // select notification.
  Future _selectNotification(String payload) async {
    try {
      Map<String, dynamic> notification =
          await jsonDecode(payload) as Map<String, dynamic>;
      String orderId;
      if (notification['data'] == null) {
        orderId = notification['target_id'];
      } else {
        orderId = notification['data']['target_id'];
      }
      if (orderId == null) return;
      _appNotifiers.navigatorKey.currentState
          .pushNamed(Constants.SCREENS_LOADING_SCREEN);
      Order order = await getOrderDetails(int.parse(orderId));
      if (order.type == Constants.SECTION_TYPE_COFFEE) {
        _appNotifiers.navigatorKey.currentState.pushReplacementNamed(
          Constants.SCREENS_COFFEE_PRODUCTS_ORDER_DETAILS_SCREEN,
          arguments: order,
        );
      } else if (order.type == Constants.SECTION_TYPE_STORE) {
        _appNotifiers.navigatorKey.currentState.pushNamed(
          Constants.SCREENS_STORE_PRODUCTS_ORDER_DETAILS_SCREEN,
          arguments: order,
        );
      } else if (order.type == Constants.SECTION_TYPE_SALON) {
        _appNotifiers.navigatorKey.currentState.pushNamed(
          Constants.SCREENS_BEAUTY_PRODUCTS_ORDER_DETAILS_SCREEN,
          arguments: order,
        );
      }
      _appNotifiers.notification = null;
    } catch (error) {
      print(error.toString());
//    }
    }
  }

  // show notification.
  void showNotification(String title, String message, {String payload}) {
    _flutterLocalNotificationsPlugin.show(
      ++_id,
      title,
      message,
      NotificationDetails(
        AndroidNotificationDetails(
          'moonId',
          'moon',
          'this is for app notifications.',
          enableVibration: true,
          importance: Importance.Max,
          priority: Priority.Max,
        ),
        IOSNotificationDetails(),
      ),
      payload: payload,
    );
  }
}

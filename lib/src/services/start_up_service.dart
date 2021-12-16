import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/local_controllers/shared_preferences_controller.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/services/connectivity_service.dart';
import 'package:moonapp/src/services/local_notifications_service.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/helpers.dart';

import 'firebase_messaging_service.dart';

class StartUpService {
  static StartUpService _instance;
  BuildContext _context;
  AppNotifiers _appNotifiers;
  LocalNotificationsService _localNotificationsService;
  ConnectivityService _connectivityService;

  // ||.. private constructor ..||
  StartUpService._() {
    AppShared.dio = Dio();
    _localNotificationsService = LocalNotificationsService.instance;
    _connectivityService = ConnectivityService.instance;
  }

  // ||.. singleton pattern ..||
  static StartUpService get instance {
    if (_instance != null) return _instance;
    return _instance = StartUpService._();
  }

  // init.
  Future<void> init() async {
    AppShared.sharedPreferencesController =
        await SharedPreferencesController.instance;
    Helpers.changeAppLang(AppShared.sharedPreferencesController.getAppLang());
//    await _connectivityService.checkConnection();
  }

  // init after build.
  void initAfterBuild(AppNotifiers appNotifiers, BuildContext context) async {
    this._context = context;
    this._appNotifiers = appNotifiers;
    FirebaseMessagingService.instance.init(_appNotifiers);
    await _localNotificationsService.init(_context, _appNotifiers);
//    _connectivityService.listenToConnection(appNotifiers);
  }
}

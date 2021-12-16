//||... File for app routes ...||
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moonapp/src/controllers/local_controllers/shared_preferences_controller.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/intro_ads_response.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/setting_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/user.dart';

class AppShared {
  // ||... shared var for SharedPreferencesController ...||
  static SharedPreferencesController sharedPreferencesController;
  // ||... app lang ...||
  static Map<String, String> appLang;
  // ||... screen_utils ...||
  static ScreenUtil screenUtil;
  // ||... current_user ...||
  static User currentUser;
  // ||... dio instance ...||
  static Dio dio;
  // ||... firebase token ...||
  static String firebaseToken;
  // ||... firebase messaging ...||
//  static FirebaseMessaging firebaseMessaging;
  // ||... device type ...||
  static String deviceType;
  // ||... connectivity ...||
  static int connectivity;
  // ||... setting ...||
  static SettingResponse settingResponse;
  // ||... intro ads ...||
  static IntroAdsResponse introAdsResponse;
  // ||... intro ads ...||
  static bool isTablet = false;
}

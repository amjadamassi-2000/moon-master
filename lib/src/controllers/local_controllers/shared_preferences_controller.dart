//||... Controller for controlling the shared preferences ...||
import 'dart:async';

import 'package:moonapp/src/models/api_models/sub_models/user.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {
  static Future<SharedPreferencesController> _instance;
  static SharedPreferences _sharedPreferences;
  static Completer<SharedPreferencesController> _completer;

  // ||.. private constructor ..||
  SharedPreferencesController._();

  // ||.. singleton pattern ..||
  static Future<SharedPreferencesController> get instance async {
    if (_instance != null) return _instance;
    _completer = Completer<SharedPreferencesController>();
    await _init();
    _completer.complete(SharedPreferencesController._());
    return _instance = _completer.future;
  }

  // ||. init the shared preferences object .||
  static Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //       ------------------ || .. usable  methods ..|| ----------------------

  //------------- ||. app lang .||
  // get the current app lang
  String getAppLang() {
    return _sharedPreferences.getString(Constants.SHARED_APP_LANG);
//        ??
//        Constants.SHARED_APP_LANG_DEFAULT_VALUE;
  }

  // set the current app lang
  Future<void> setAppLang(String lang) async {
    await _sharedPreferences.setString(Constants.SHARED_APP_LANG, lang);
    Helpers.changeAppLang(lang);
  }

  //------------- ||. is login .||

  // get the current user login status.
  bool getIsLogin() {
    return _sharedPreferences.getBool(Constants.SHARED_IS_LOGIN) ??
        Constants.SHARED_IS_LOGIN_DEFAULT_VALUE;
  }

  // set the current user login status.
  Future<void> setIsLogin(bool isLogin) async {
    await _sharedPreferences.setBool(Constants.SHARED_IS_LOGIN, isLogin);
  }

  //------------- ||. is intro visible .||

//  // get if can view intro or not.
//  bool getIsIntroVisible() {
//    return _sharedPreferences.getBool(Constants.SHARED_IS_INTRO_VISIBLE) ??
//        Constants.SHARED_IS_INTRO_VISIBLE_DEFAULT_VALUE;
//  }
//
//  // set if can view intro or not.
//  Future<void> setIsIntroVisible(bool isIntroVisible) async {
//    await _sharedPreferences.setBool(
//        Constants.SHARED_IS_INTRO_VISIBLE, isIntroVisible);
//  }

  //------------- ||. is notifications enabled .||

  // get notification status.
  bool isNotificationEnabled() {
    return _sharedPreferences.getBool(Constants.SHARED_NOTIFICATION_STATUS) ??
        Constants.SHARED_NOTIFICATION_STATUS_DEFAULT_VALUE;
  }

  // set notification status.
  Future<void> setIsNotificationEnabled(bool isEnabled) async {
    await _sharedPreferences.setBool(
        Constants.SHARED_NOTIFICATION_STATUS, isEnabled);
  }

  //------------- ||. user id .||

//   get the current user data.
  User getUserData() {
    return userFromJson(
      _sharedPreferences.getString(Constants.SHARED_USER_DATA),
    );
  }

//   set the current user data.
  Future<void> setUserData(User user) async {
    await _sharedPreferences.setString(
      Constants.SHARED_USER_DATA,
      user == null ? null : userToJson(user),
    );
  }

  //------------- ||. is remember me .||

  // method for setting the user status is remembered or not  >>>
  Future<void> setRememberedUser(bool value) async {
    return _sharedPreferences.setBool(Constants.SHARED_IS_REMEMBER_ME, value);
  }

// method for getting the user status is remembered or not  >>>
  bool isRememberedUser() {
    return _sharedPreferences.getBool(Constants.SHARED_IS_REMEMBER_ME) ??
        Constants.SHARED_REMEMBER_ME_DEFAULT_VALUE;
  }

  // section type >>>
  Future<void> setSectionType(int value) async {
    return _sharedPreferences.setInt(Constants.SHARED_SECTION_TYPE, value);
  }

// section type  >>>
  int getSectionType() {
    return _sharedPreferences.getInt(Constants.SHARED_SECTION_TYPE);
  }

//------------- ||. clear all shared preferences.||
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }

  //------------- ||. clear user data.||
  Future<void> clearUserData() async {
    await setUserData(null);
    await setIsLogin(false);
  }
}

import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';

ThemeData lightTheme() => ThemeData(
      primarySwatch: Colors.yellow,
      primaryColor: Color(0xffD3B056),
      fontFamily: Helpers.changeAppFont(
        AppShared.sharedPreferencesController.getAppLang() ?? Constants.LANG_AR,
      ),
    );

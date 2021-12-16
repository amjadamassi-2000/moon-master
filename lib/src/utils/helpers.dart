//||... Class for all helpers methods ...||

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:intl/intl.dart' as intl;
import 'package:moonapp/src/langs/ar_lang.dart';
import 'package:moonapp/src/langs/en_lang.dart';
import 'package:moonapp/src/models/api_models/sub_models/city.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/screens/customer_screens/beauty_section_screens/beauty_main_screen/pages/beauty_home_screen/beauty_home_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_main_screen/pages/coffee_home_screen/coffee_home_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/store_section_screens/store_main_screen/pages/store_home_screen/store_home_screen.dart';
import 'package:moonapp/src/views/screens/drivers_screens/driver_main_screen/pages/driver_orders_page.dart';
import 'package:moonapp/src/views/screens/shared_pages/about_us_page.dart';
import 'package:moonapp/src/views/screens/shared_pages/contact_us_page.dart';
import 'package:moonapp/src/views/screens/shared_pages/favorites_page.dart';
import 'package:moonapp/src/views/screens/shared_pages/my_orders_page.dart';
import 'package:moonapp/src/views/screens/shared_pages/notifications_page.dart';
import 'package:moonapp/src/views/screens/shared_pages/settings_page.dart';
import 'package:moonapp/src/views/screens/shared_screens/faq_screen.dart';

import 'app_shared.dart';
import 'enums.dart';

class Helpers {
  // method for showing an message .
  static void showMessage(String message, MessageType messageType) {
    if (message == null) return;
    if (messageType == MessageType.MESSAGE_FAILED)
      BotToast.showNotification(
        // textDirection: getDirectionByLang(
        //     AppShared.sharedPreferencesController.getAppLang()),
        trailing: (_) => Icon(
          Icons.arrow_forward_ios,
          color: Colors.red,
        ),
        title: (_) => Text(
          AppShared.appLang['Failed'],
          style: TextStyle(color: Colors.red),
        ),
        subtitle: (_) => Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
        leading: (_) => Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    else
      BotToast.showNotification(
        // textDirection: getDirectionByLang(
        //     AppShared.sharedPreferencesController.getAppLang()),
        trailing: (_) => Icon(
          Icons.arrow_forward_ios,
          color: Colors.teal,
        ),
        title: (_) => Text(
          AppShared.appLang['Success'],
          style: TextStyle(color: Colors.teal),
        ),
        subtitle: (_) => Text(
          message,
          style: TextStyle(color: Colors.teal),
        ),
        leading: (_) => Icon(
          Icons.done,
          color: Colors.teal,
        ),
      );
  }

  // method for setting the app lang.
  static void changeAppLang(String lang) {
    switch (lang) {
      case 'ar':
        AppShared.appLang = ar;
        break;
      case 'en':
        AppShared.appLang = en;
        break;
    }
  }

  // method for setting the app direction according to app lang.
  static TextDirection getDirectionByLang(String lang) {
    switch (lang) {
      case Constants.LANG_AR:
        return TextDirection.rtl;
        break;
      case Constants.LANG_EN:
        return TextDirection.ltr;
        break;
      default:
        return null;
    }
  }

  // method for setting the app font according to app lang.
  static String changeAppFont([String lang]) {
    if (lang == null) lang = AppShared.sharedPreferencesController.getAppLang();
    switch (lang) {
      case Constants.LANG_EN:
        return 'Ubuntu';
        break;
      case Constants.LANG_AR:
        return 'Cairo';
        break;
      default:
        return 'Ubuntu';
    }
  }

  // method for handling zoom drawer
  static void handleDrawer(ZoomDrawerController zoomDrawerController) {
    zoomDrawerController.isOpen()
        ? zoomDrawerController.close()
        : zoomDrawerController.open();
  }

  //method for changing the main page in coffee section
  static Widget coffeeChangePage(
      int index, ZoomDrawerController _zoomDrawerController) {
    switch (index) {
      case 0:
        return CoffeeHomeScreen();
        break;
      case 1:
        return NotificationsPage(_zoomDrawerController);
        break;
      case 2:
        return OrdersPage(_zoomDrawerController);
        break;
      case 3:
        return FavoritesPage(_zoomDrawerController);
        break;
      case 5:
        return AboutUsPage(_zoomDrawerController);
        break;
      case 6:
        return FaqScreen(_zoomDrawerController);
        break;
      case 7:
        return SettingsPage(_zoomDrawerController);
        break;
      case 8:
        return ContactUsPage(_zoomDrawerController);
        break;
      default:
        return null;
    }
  }

  //method for changing the main page in store section
  static Widget storeChangePage(
      int index, ZoomDrawerController _zoomDrawerController) {
    switch (index) {
      case 0:
        return StoreHomeScreen();
        break;
      case 1:
        return NotificationsPage(_zoomDrawerController);
        break;
      case 2:
        return OrdersPage(_zoomDrawerController);
        break;
      case 3:
        return FavoritesPage(_zoomDrawerController);
        break;
      case 5:
        return AboutUsPage(_zoomDrawerController);
        break;
      case 6:
        return FaqScreen(_zoomDrawerController);
        break;
      case 7:
        return SettingsPage(_zoomDrawerController);
        break;
      case 8:
        return ContactUsPage(_zoomDrawerController);
        break;
      default:
        return null;
    }
  }

  //method for changing the main page in beauty section
  static Widget beautyChangePage(
      int index, ZoomDrawerController _zoomDrawerController) {
    switch (index) {
      case 0:
        return BeautyHomeScreen();
        break;
      case 1:
        return NotificationsPage(_zoomDrawerController);
        break;
      case 2:
        return OrdersPage(_zoomDrawerController);
        break;
      case 3:
        return FavoritesPage(_zoomDrawerController);
        break;
      case 5:
        return AboutUsPage(_zoomDrawerController);
        break;
      case 6:
        return FaqScreen(_zoomDrawerController);
        break;
      case 7:
        return SettingsPage(_zoomDrawerController);
        break;
      case 8:
        return ContactUsPage(_zoomDrawerController);
        break;
      default:
        return null;
    }
  }

  //method for changing the main page in driver section
  static Widget driverChangePage(
      int index, ZoomDrawerController _zoomDrawerController) {
    switch (index) {
      case 0:
        return DriverOrdersPage(_zoomDrawerController);
        break;
      case 1:
        return AboutUsPage(_zoomDrawerController);
        break;
      case 2:
        return FaqScreen(_zoomDrawerController);
        break;
      case 3:
        return SettingsPage(_zoomDrawerController);
        break;
      case 4:
        return ContactUsPage(_zoomDrawerController);
        break;
      default:
        return null;
    }
  }

  // get city by id.
  static City getCityById(int cityId) {
    for (City c in AppShared.settingResponse.settings.cities) {
      if (c.id == cityId) {
        return c;
      }
    }
    return null;
  }

  //get image according to info component type.
  static String getImageForInfoComponentType(
      InfoComponentType infoComponentType) {
    switch (infoComponentType) {
      case InfoComponentType.INFO_COMPONENT_TYPE_NO_CART:
        return '${Constants.ASSETS_IMAGES_PATH}empty_cart.svg';
        break;
      case InfoComponentType.INFO_COMPONENT_TYPE_NO_FAVORITES:
        return '${Constants.ASSETS_IMAGES_PATH}no_favorites.svg';
        break;
      case InfoComponentType.INFO_COMPONENT_TYPE_NO_INTERNET:
        return '${Constants.ASSETS_IMAGES_PATH}no_internet.svg';
        break;
      case InfoComponentType.INFO_COMPONENT_TYPE_NO_NOTIFICATIONS:
        return '${Constants.ASSETS_IMAGES_PATH}no_notifications.svg';
        break;
      case InfoComponentType.INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS:
        return '${Constants.ASSETS_IMAGES_PATH}no_search_results.svg';
        break;
      case InfoComponentType.INFO_COMPONENT_TYPE_NO_ORDERS:
        return '${Constants.ASSETS_IMAGES_PATH}no_orders.svg';
        break;
      case InfoComponentType.INFO_COMPONENT_TYPE_NO_OFFERS:
        return '${Constants.ASSETS_IMAGES_PATH}no_offers.svg';
        break;
      default:
        return null;
        break;
    }
  }

  // format date.
  static String formatDate(DateTime dateTime) {
    return intl.DateFormat('dd-MM-yyyy').format(dateTime);
  }
  static String formatDate2(DateTime dateTime) {
    return intl.DateFormat('yyyy-MM-dd').format(dateTime);
  }
  // format time of a day.
  static String formatTime(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour < 10 ? '0${timeOfDay.hour}' : timeOfDay.hour}:${timeOfDay.minute < 10 ? '0${timeOfDay.minute}' : timeOfDay.minute}';
  }

  // get order status name.
  static getOrderStatusName(int status) {
    switch (status) {
      case Constants.ORDER_STATUS_NEW:
        return AppShared.appLang['New'];
        break;
      case Constants.ORDER_STATUS_PREPARING:
        return AppShared.appLang['Preparing'];
        break;
      case Constants.ORDER_STATUS_READY:
        return AppShared.appLang['Ready'];
        break;
      case Constants.ORDER_STATUS_ON_DELIVERY:
        return AppShared.appLang['OnDelivery'];
        break;
      case Constants.ORDER_STATUS_ON_DELIVERED:
        return AppShared.appLang['Delivered'];
        break;
    }
  }
}

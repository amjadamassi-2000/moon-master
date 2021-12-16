//||... File for app routes ...||

import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/screens/customer_screens/beauty_section_screens/beauty_checkout_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/beauty_section_screens/beauty_main_screen/beauty_main_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/beauty_section_screens/beauty_service_details_screen/beauty_service_details_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/beauty_section_screens/beauty_services_order_details_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/additions_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_checkout_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_filter_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_filter_second_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_main_screen/coffee_main_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_product_details_screen/coffee_product_details_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_products_order_details_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/store_section_screens/store_checkout_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/store_section_screens/store_filter_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/store_section_screens/store_main_screen/store_main_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/store_section_screens/store_product_details_screen/store_product_details_screen.dart';
import 'package:moonapp/src/views/screens/customer_screens/store_section_screens/store_products_order_details_screen.dart';
import 'package:moonapp/src/views/screens/drivers_screens/driver_main_screen/driver_orders_screen.dart';
import 'package:moonapp/src/views/screens/others_screens/choose_language_screen.dart';
import 'package:moonapp/src/views/screens/others_screens/choose_section_screen.dart';
import 'package:moonapp/src/views/screens/others_screens/forgot_password_screen.dart';
import 'package:moonapp/src/views/screens/others_screens/introduction_screen.dart';
import 'package:moonapp/src/views/screens/others_screens/signin_screen.dart';
import 'package:moonapp/src/views/screens/others_screens/signup_screen.dart';
import 'package:moonapp/src/views/screens/others_screens/splash_screen.dart';
import 'package:moonapp/src/views/screens/shared_pages/my_cart_screen.dart';
import 'package:moonapp/src/views/screens/shared_pages/search_about_product_screen.dart';
import 'package:moonapp/src/views/screens/shared_screens/change_password_screen.dart';
import 'package:moonapp/src/views/screens/shared_screens/edit_profile_screen.dart';
import 'package:moonapp/src/views/screens/shared_screens/google_map_screen.dart';
import 'package:moonapp/src/views/screens/shared_screens/loading_screen.dart';
import 'package:moonapp/src/views/screens/shared_screens/privacy_screen.dart';
import 'package:moonapp/src/views/screens/shared_screens/profile_screen.dart';
import 'package:moonapp/src/views/screens/shared_screens/reviews_screen.dart';
import 'package:moonapp/src/views/screens/shared_screens/terms_of_use_screen.dart';
import 'package:moonapp/src/views/screens/shared_screens/web_view_screen.dart';

Map<String, Widget Function(BuildContext context)> appRoutes = {
  Constants.SCREENS_SPLASH_SCREEN: (_) => SplashScreen(),
  Constants.SCREEN_CHOOSE_LANGUAGE_SCREEN: (_) => ChooseLanguageScreen(),
  Constants.SCREEN_SIGN_IN_SCREEN: (_) => SignInScreen(),
  Constants.SCREEN_SIGN_UP_SCREEN: (_) => SignUpScreen(),
  Constants.SCREEN_FORGOT_PASSWORD_SCREEN: (_) => ForgotPasswordScreen(),
  Constants.SCREEN_CHOOSE_SECTION_SCREEN: (_) => ChooseSectionScreen(),
  Constants.SCREEN_INTRODUCTION_SCREEN: (_) => IntroductionScreen(),
  Constants.SCREENS_COFFEE_SEARCH_ABOUT_PRODUCT_SCREEN: (_) =>
      SearchAboutProductScreen(),
  Constants.SCREENS_TERMS_OF_USE_SCREEN: (_) => TermOfUseScreen(),
  Constants.SCREENS_PRIVACY_SCREEN: (_) => PrivacyScreen(),
  Constants.SCREENS_COFFEE_PRODUCTS_ORDER_DETAILS_SCREEN: (_) =>
      CoffeeProductsOrderDetailsScreen(),
  Constants.SCREENS_COFFEE_PRODUCT_DETAILS_SCREEN: (_) =>
      CoffeeProductDetailsScreen(),
  Constants.SCREENS_BEAUTY_PRODUCTS_ORDER_DETAILS_SCREEN: (_) =>
      BeautyProductsOrderDetailsScreen(),
  Constants.SCREENS_CHANGE_PASSWORD_SCREEN: (_) => ChangePasswordScreen(),
  Constants.SCREENS_EDIT_PROFILE_SCREEN: (_) => EditProfileScreen(),
  Constants.SCREENS_PROFILE_SCREEN: (_) => ProfileScreen(),
  Constants.SCREENS_COFFEE_MY_CART_SCREEN: (_) => MyCartScreenBody(),
  Constants.SCREENS_COFFEE_MAIN_SCREEN: (_) => CoffeeMainScreen(),
  Constants.SCREENS_BEAUTY_MAIN_SCREEN: (_) => BeautyMainScreen(),
  Constants.SCREENS_COFFEE_FILTER_SCREEN: (_) => CoffeeFilterScreen(),
  Constants.SCREENS_COFFEE_FILTER_SECOND_SCREEN: (_) =>
      CoffeeFilterSecondScreen(),
  Constants.SCREENS_DRIVER_ORDERS_SCREEN: (_) => DriverOrdersScreen(),
  Constants.SCREENS_ADDITION_SCREEN: (_) => AdditionScreen(),
  Constants.SCREENS_COFFEE_CHECKOUT_SCREEN: (_) => CoffeeCheckoutScreen(),
  Constants.SCREENS_GOOGLE_MAP_SCREEN: (_) => GoogleMapScreen(),
  Constants.SCREENS_BEAUTY_CHECKOUT_SCREEN: (_) => BeautyCheckoutScreen(),
  Constants.SCREENS_BEAUTY_SERVICE_DETAILS_SCREEN: (_) =>
      BeautyServiceDetailsScreen(),
  Constants.SCREENS_REVIEWS_SCREEN: (_) => ReviewsScreen(),
  Constants.SCREENS_WEB_VIEW_SCREEN: (_) => WebViewScreen(),
  Constants.SCREENS_LOADING_SCREEN: (_) => LoadingScreen(),

  // store.
  Constants.SCREENS_STORE_CHECKOUT_SCREEN: (_) => StoreCheckoutScreen(),
  Constants.SCREENS_STORE_FILTER_SCREEN: (_) => StoreFilterScreen(),
  Constants.SCREENS_STORE_FILTER_SECOND_SCREEN: (_) =>
      CoffeeFilterSecondScreen(),
  Constants.SCREENS_STORE_MAIN_SCREEN: (_) => StoreMainScreen(),
  Constants.SCREENS_STORE_PRODUCTS_ORDER_DETAILS_SCREEN: (_) =>
      StoreProductsOrderDetailsScreen(),
  Constants.SCREENS_STORE_PRODUCT_DETAILS_SCREEN: (_) =>
      StoreProductDetailsScreen(),
};

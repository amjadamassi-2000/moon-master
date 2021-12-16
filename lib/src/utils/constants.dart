//||... Class for all constants inside the app ...||

class Constants {
// start : ||... APP_NAME ...||
  static const String APP_NAME = 'MoonApp';
// end : ||... APP_NAME ...||

//           ||-------------------------------------------||
// start : ||... SCREENS_NAMES ...||

  //Store Section
  static const String SCREENS_STORE_MAIN_SCREEN = 'StoreMainScreen';
  static const String SCREENS_STORE_SEARCH_ABOUT_PRODUCT_SCREEN =
      'StoreSearchAboutProductScreen';
  static const String SCREENS_STORE_PRODUCT_DETAILS_SCREEN =
      'StoreProductDetailsScreen';
  static const String SCREENS_STORE_PRODUCTS_OFFERS_SCREEN =
      'StoreProductsOffersScreen';
  static const String SCREENS_STORE_PRODUCTS_FAVORITES_SCREEN =
      'StoreProductsFavoritesScreen';
  static const String SCREENS_STORE_PRODUCTS_ORDER_DETAILS_SCREEN =
      'StoreProductsOrderDetailsScreen';
  static const String SCREENS_STORE_NOTIFICATIONS_SCREEN =
      'StoreNotificationsScreen';
  static const String SCREENS_STORE_QF_SCREEN = 'StoreQFScreen';
  static const String SCREENS_STORE_MY_CART_SCREEN = 'StoreMyCartScreen';
  static const String SCREENS_STORE_FILTER_SCREEN = 'StoreFilterScreen';
  static const String SCREENS_STORE_FILTER_SECOND_SCREEN =
      'StoreFilterSecondScreen';
  static const String SCREENS_STORE_CHECKOUT_SCREEN = 'StoreCheckoutScreen';

  //Coffee Section
  static const String SCREENS_COFFEE_MAIN_SCREEN = 'CoffeeMainScreen';
  static const String SCREENS_COFFEE_SEARCH_ABOUT_PRODUCT_SCREEN =
      'CoffeeSearchAboutProductScreen';
  static const String SCREENS_COFFEE_PRODUCT_DETAILS_SCREEN =
      'CoffeeProductDetailsScreen';
  static const String SCREENS_COFFEE_PRODUCTS_OFFERS_SCREEN =
      'CoffeeProductsOffersScreen';
  static const String SCREENS_COFFEE_PRODUCTS_FAVORITES_SCREEN =
      'CoffeeProductsFavoritesScreen';
  static const String SCREENS_COFFEE_PRODUCTS_ORDER_DETAILS_SCREEN =
      'CoffeeProductsOrderDetailsScreen';
  static const String SCREENS_COFFEE_NOTIFICATIONS_SCREEN =
      'CoffeeNotificationsScreen';
  static const String SCREENS_COFFEE_QF_SCREEN = 'CoffeeQFScreen';
  static const String SCREENS_COFFEE_MY_CART_SCREEN = 'CoffeeMyCartScreen';
  static const String SCREENS_COFFEE_FILTER_SCREEN = 'CoffeeFilterScreen';
  static const String SCREENS_COFFEE_FILTER_SECOND_SCREEN =
      'CoffeeFilterSecondScreen';
  static const String SCREENS_ADDITION_SCREEN = 'AdditionScreen';
  static const String SCREENS_COFFEE_CHECKOUT_SCREEN = 'CoffeeCheckoutScreen';
  static const String SCREENS_GOOGLE_MAP_SCREEN = 'GoogleMapScreen';

  //Beauty Section
  static const String SCREENS_BEAUTY_MAIN_SCREEN = 'BeautyMainScreen';
  static const String SCREENS_BEAUTY_PRODUCTS_SCREEN = 'BeautyProductsScreen';
  static const String SCREENS_BEAUTY_SERVICES_SCREEN = 'BeautyServicesScreen';
  static const String SCREENS_SERVICE_CHECKOUT_SCREEN = 'ServiceCheckoutScreen';
  static const String SCREENS_BEAUTY_CHECKOUT_SCREEN = 'BeautyCheckoutScreen';
  static const String SCREENS_BEAUTY_SEARCH_ABOUT_SERVICE_SCREEN =
      'BeautySearchAboutServiceScreen';
  static const String SCREENS_BEAUTY_SERVICE_DETAILS_SCREEN =
      'BeautyServiceDetailsScreen';
  static const String SCREENS_BEAUTY_PRODUCT_DETAILS_SCREEN =
      'BeautyProductDetailsScreen';
  static const String SCREENS_BEAUTY_BOOKING_DETAILS_SCREEN =
      'BeautyBookingDetailsScreen';
  static const String SCREENS_BEAUTY_PRODUCTS_ORDER_DETAILS_SCREEN =
      'BeautyProductsOrderDetailsScreen';
  static const String SCREENS_BEAUTY_SERVICES_ORDER_DETAILS_SCREEN =
      'BeautyServicesOrderDetailsScreen';

  // Driver Section

  static const String SCREENS_DRIVER_ORDERS_SCREEN = 'DriverOrdersScreen';

  //Others
  static const String SCREENS_SPLASH_SCREEN = 'SplashScreen';
  static const String SCREEN_CHOOSE_LANGUAGE_SCREEN = 'ChooseLanguageScreen';
  static const String SCREEN_SIGN_IN_SCREEN = 'SignInScreen';
  static const String SCREEN_SIGN_UP_SCREEN = 'SignUpScreen';
  static const String SCREEN_FORGOT_PASSWORD_SCREEN = 'ForgotPasswordScreen';
  static const String SCREEN_THANKS_SCREEN = 'ThanksScreen';
  static const String SCREEN_CHOOSE_SECTION_SCREEN = 'ChooseSectionScreen';
  static const String SCREEN_INTRODUCTION_SCREEN = 'IntroductionScreen';
  static const String SCREENS_SUCCESS_SCREEN = 'SuccessScreen';

  //Shared Screens
  static const String SCREENS_PRIVACY_SCREEN = 'PrivacyScreen';
  static const String SCREENS_CHANGE_PASSWORD_SCREEN = 'ChangePasswordScreen';
  static const String SCREENS_CONTACT_US_SCREEN = 'ContactUsScreen';
  static const String SCREENS_EDIT_PROFILE_SCREEN = 'EditProfileScreen';
  static const String SCREENS_PROFILE_SCREEN = 'ProfileScreen';
  static const String SCREENS_SETTINGS_SCREEN = 'SettingsScreen';
  static const String SCREENS_TERMS_OF_USE_SCREEN = 'TermsOfUseScreen';
  static const String SCREENS_REVIEWS_SCREEN = 'ReviewsScreen';
  static const String SCREENS_WEB_VIEW_SCREEN = 'WebViewScreen';
  static const String SCREENS_LOADING_SCREEN = 'LoadingScreen';

// end : ||... SCREENS_NAMES ...||

//           ||-------------------------------------------||

// start : ||... SHARED_PREFERENCES ...||
  static const String SHARED_IS_LOGIN = 'isLogin';
  static const bool SHARED_IS_LOGIN_DEFAULT_VALUE = false;

  static const String SHARED_SELECTED_SECTION = 'selectedSection';

  static const String SHARED_IS_REMEMBER_ME = 'isRememberMe';
  static const bool SHARED_REMEMBER_ME_DEFAULT_VALUE = false;

//  static const String SHARED_IS_INTRO_VISIBLE = 'isIntroVisible';
//  static const bool SHARED_IS_INTRO_VISIBLE_DEFAULT_VALUE = true;

  static const String SHARED_SECTION_TYPE = 'sectionType';

  static const String SHARED_APP_LANG = 'appLang';
  static const String SHARED_APP_LANG_DEFAULT_VALUE = 'en';

  static const String SHARED_USER_ID = 'userId';
  static const int SHARED_USER_ID_DEFAULT_VALUE = -1;

  static const String SHARED_NOTIFICATION_STATUS = 'notificationStatus';
  static const bool SHARED_NOTIFICATION_STATUS_DEFAULT_VALUE = true;

  static const String SHARED_USER_DATA = 'userData';

// end : ||... SHARED_PREFERENCES ...||

//           ||-------------------------------------------||

// start : ||... API ...||
//  static const String API_BASE_URL = 'http://dev.miniso.com.sa/api/';
 // static const String API_BASE_URL = 'https://moonam-ksa.com/api/';
  static const String API_BASE_URL = 'http://moon.hexacit.com/api/';
// end : ||... API ...||

//           ||-------------------------------------------||

// start : ||... ASSETS ...||
  static const String ASSETS_IMAGES_PATH = 'assets/images/';

// end : ||... ASSETS ...||

//           ||-------------------------------------------||

// start : ||... INTEGER VALUES ...||
  // SECTION TYPE
  static const int SECTION_TYPE_COFFEE = 1;
  static const int SECTION_TYPE_STORE = 2;
  static const int SECTION_TYPE_SALON = 3;

  // USER TYPE
  static const String USER_TYPE_CUSTOMER = '1';
  static const String USER_TYPE_DRIVER = '2';
  static const String USER_TYPE_WAITER = '3';

  // LANG
  static const String LANG_AR = 'ar';
  static const String LANG_EN = 'en';

  // STATIC PAGES
  static const int STATIC_PAGES_ABOUT_US = 1;
  static const int STATIC_PAGES_PRIVACY_POLICY = 2;
  static const int STATIC_PAGES_TERMS_OF_USE = 3;

  // INTERNET STATUS
  static const int INTERNET_STATUS_CONNECTED = 1;
  static const int INTERNET_STATUS_CONNECTING = 2;
  static const int INTERNET_STATUS_NOT_CONNECTED = 3;

  // CHANGE QUANTITY TYPE
  static const int CHANGE_QUANTITY_TYPE_INCREMENT = 1;
  static const int CHANGE_QUANTITY_TYPE_DECREMENT = 2;

  // ORDER STATUS
  static const int ORDER_STATUS_NEW = 0;
  static const int ORDER_STATUS_PREPARING = 1;
  static const int ORDER_STATUS_READY = 2;
  static const int ORDER_STATUS_ON_DELIVERY = 3;
  static const int ORDER_STATUS_ON_DELIVERED = 4;

  //FIREBASE MESSAGING TOPIC
  static const String FIREBASE_MESSAGING_TOPIC = "moon";

// end : ||... INTEGER VALUES ...||

//           ||-------------------------------------------||

// start : ||... FIREBASE ...||

  //start:|. COLLECTIONS .|

  //end:|. COLLECTIONS .|

  // ||------------------------||

  //start:|. FIELDS .|

  //end:|. FIELDS .|

  // start |. STORAGE .|

  // end |. STORAGE .|

// end : ||... FIREBASE ...||

}

import 'package:dio/dio.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/faq_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/static_pages_response.dart';
import 'package:moonapp/src/models/api_models/others_models/requests/contact_request.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/contact_response.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/intro_ads_response.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/setting_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';

class ConfigsController {
  static ConfigsController _instance;

  // ||.. private constructor ..||
  ConfigsController._();

  // ||.. singleton pattern ..||
  static ConfigsController get instance {
    if (_instance != null) return _instance;
    return _instance = ConfigsController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  // ||.. get app settings ..||
  Future<SettingResponse> getSetting() async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getSetting',
      options: Options(
        headers: {
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );

    SettingResponse settingResponse = SettingResponse.fromJson(response.data);
    return settingResponse;
  }

  // ||.. get the intro ads ..||
  Future<IntroAdsResponse> getIntroAds() async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getAds',
      options: Options(
        headers: {
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );

    IntroAdsResponse introAdsResponse =
        IntroAdsResponse.fromJson(response.data);

    return introAdsResponse;
  }

  // ||.. send contact ..||
  Future<ContactResponse> sendContact(
      {String name, String email, String mobile, String message}) async {
    ContactRequest contactRequest = ContactRequest(
      name: name,
      email: email,
      message: message,
      mobile: mobile,
    );

    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}contactUs',
      data: contactRequest.toJson(),
      options: Options(
        headers: {
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );
    ContactResponse contactResponse = ContactResponse.fromJson(response.data);

    return contactResponse;
  }

  // ||.. get static pages ..||
  Future<StaticPagesResponse> getStaticPages(int staticPage) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}pages/$staticPage',
      options: Options(
        headers: {
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );

    StaticPagesResponse staticPagesResponse =
        StaticPagesResponse.fromJson(response.data);

    return staticPagesResponse;
  }

  // ||.. get FAQ ..||
  Future<FaqResponse> getFaq() async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}allQuestions',
      options: Options(
        headers: {
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );

    FaqResponse faqResponse = FaqResponse.fromJson(response.data);

    return faqResponse;
  }
}

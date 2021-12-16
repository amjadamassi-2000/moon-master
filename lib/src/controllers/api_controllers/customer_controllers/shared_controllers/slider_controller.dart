import 'package:dio/dio.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/slider_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';

class SliderController {
  static SliderController _instance;

  // ||.. private constructor ..||
  SliderController._();

  // ||.. singleton pattern ..||
  static SliderController get instance {
    if (_instance != null) return _instance;
    return _instance = SliderController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------



// get slider.
  Future<SliderResponse> getSlider(int section) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getSlider',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );

    SliderResponse sliderResponse = SliderResponse.fromJson(response.data);
//    sliderResponse.slider.removeWhere(
//      (value) => value.type != 0 && value.type != section,
//    );
    return sliderResponse;
  }







}

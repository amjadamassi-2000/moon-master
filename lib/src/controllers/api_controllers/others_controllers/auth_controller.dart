import 'package:dio/dio.dart';
import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/others_models/requests/change_password_request.dart';
import 'package:moonapp/src/models/api_models/others_models/requests/sign_in_request.dart';
import 'package:moonapp/src/models/api_models/others_models/requests/sign_up_request.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/user_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';

class AuthController {
  static AuthController _instance;

  // ||.. private constructor ..||
  AuthController._();

  // ||.. singleton pattern ..||
  static AuthController get instance {
    if (_instance != null) return _instance;
    return _instance = AuthController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  // ||.. register new user method ..||
  Future<UserResponse> signUp( {
    String name,
    String email,
    String password,
    String mobile,
    int cityId,
  }) async {
    SignUpRequest signUpRequest = SignUpRequest(
      deviceType: AppShared.deviceType,
      email: email,
      fcmToken: AppShared.firebaseToken,
      mobile: mobile,
      name: name,
      password: password,
      cityId: cityId,
    );

    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}signUp',
      data: signUpRequest.toJson(),
      options: Options(
        headers: {
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );

    UserResponse userResponse = UserResponse.fromJson(response.data);

    if (userResponse.status) {
      AppShared.currentUser = userResponse.user;
      await AppShared.sharedPreferencesController.setIsLogin(true);
      await AppShared.sharedPreferencesController
          .setUserData(AppShared.currentUser);
    }
    return userResponse;
  }




// ||.. sign in method ..||

  Future<UserResponse> signIn( {
    String email,
    String password,
  }) async {
    SignInRequest signInRequest = SignInRequest(
      deviceType: AppShared.deviceType,
      email: email,
      fcmToken: AppShared.firebaseToken,
      password: password,
    );
    print(signInRequest.toJson());
    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}login',
      data: signInRequest.toJson(),
      options: Options(
        headers: {
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );

    UserResponse userResponse = UserResponse.fromJson(response.data);
    print(userResponse.user.toJson());
    if (userResponse.status) {
      AppShared.currentUser = userResponse.user;
      await AppShared.sharedPreferencesController.setIsLogin(true);
      await AppShared.sharedPreferencesController
          .setUserData(AppShared.currentUser);
    }
    print(AppShared.currentUser.toJson());
    return userResponse;
  }



  //  forgot password.
  Future<BaseResponse> forgotPassword({
    String email,
  }) async {
    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}forgotPassword',
      data: {"email": email},
    );

    BaseResponse baseResponse = BaseResponse.fromJson(response.data);

    return baseResponse;
  }

  //  logout.
  Future<BaseResponse> logout() async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}logout',
      options: Options(
        headers: {
          "Authorization": 'Bearer ${AppShared.currentUser.accessToken}'
        },
      ),
    );
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    if (baseResponse.status) {
      AppShared.sharedPreferencesController.clearUserData();
    }
    return baseResponse;
  }

  //  Change password .
  Future<BaseResponse> changePassword({
    String oldPassword,
    String password,
    String confirmPassword,
  }) async {
    ChangePasswordRequest changePasswordRequest = ChangePasswordRequest(
      oldPassword: oldPassword,
      password: password,
      confirmPassword: confirmPassword,
    );

    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}changePassword',
      data: changePasswordRequest.toJson(),
      options: Options(
        headers: {
          "Authorization": 'Bearer ${AppShared.currentUser.accessToken}'
        },
      ),
    );

    BaseResponse baseResponse = BaseResponse.fromJson(response.data);

    return baseResponse;
  }
}

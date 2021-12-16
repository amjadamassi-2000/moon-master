import 'package:dio/dio.dart';
import 'package:moonapp/src/models/api_models/others_models/requests/edit_profile_request.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/notifications_response.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/user_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';

class UserController {
  static UserController _instance;

  // ||.. private constructor ..||
  UserController._();

  // ||.. singleton pattern ..||
  static UserController get instance {
    if (_instance != null) return _instance;
    return _instance = UserController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  // ||.. edit profile method ..||
  Future<UserResponse> editProfile({
    String name,
    String mobile,
    MultipartFile image,
    int cityId,
  }) async {
    EditProfileRequest editProfileRequest = EditProfileRequest(
        name: name, mobile: mobile, imageProfile: image, cityId: cityId);

    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}editProfile',
      data: FormData.fromMap(editProfileRequest.toJson()),
      options: Options(
        headers: {
          "Authorization": 'Bearer ${AppShared.currentUser.accessToken}'
        },
      ),
    );

    UserResponse editProfileResponse = UserResponse.fromJson(response.data);
    return editProfileResponse;
  }

  // get notifications.
  Future<NotificationsResponse> getNotifications() async {
    Response response = await AppShared.dio.get(
        '${Constants.API_BASE_URL}myNotifications',
        options: Options(headers: {
          "Authorization": 'Bearer ${AppShared.currentUser.accessToken}'
        }));

    NotificationsResponse notificationsResponse =
        NotificationsResponse.fromJson(response.data);
    return notificationsResponse;
  }
}

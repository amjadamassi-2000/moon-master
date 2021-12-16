import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/user_controller.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/user_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class EditProfileScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  PickedFile _profileImage;

  PickedFile get profileImage => _profileImage;

  set profileImage(PickedFile value) {
    _profileImage = value;
    notifyListeners();
  }

// ||....................... notifiable ..................................||

  //--------------------------------------------------------------------------------------------------//

  BuildContext context;
  UserController userController;
  GlobalKey<FormState> editProfileFormState;
  TextEditingController cityTextController;
  GlobalKey<ScaffoldState> scaffoldKey;
  ImagePicker imagePicker;

  // ||... form fields ...|
  String name;
  String mobile;
  int cityId;

  // ||... focus nodes ...||
  FocusNode nameFocusNode;
  FocusNode mobileFocusNode;

  // ||... constructor ...||
  EditProfileScreenNotifiers(this.context) {
    cityId = AppShared.currentUser.cityId;
    userController = UserController.instance;
    scaffoldKey = GlobalKey();
    imagePicker = ImagePicker();
    editProfileFormState = GlobalKey();
    cityTextController = TextEditingController();
    cityTextController.text =
        Helpers.getCityById(AppShared.currentUser.cityId).name;
    mobileFocusNode = FocusNode();
    nameFocusNode = FocusNode();
  }

// ||...................... logic methods ............................||

  // ||.. get user personal image from [ Gallery | Camera ] ..||
  void getProfileImage(ImageSource imageSource) async {
    Navigator.pop(context);
    if (imageSource == ImageSource.gallery)
      profileImage = await imagePicker.getImage(
          source: ImageSource.gallery, imageQuality: 70);
    else
      profileImage = await imagePicker.getImage(
          source: ImageSource.camera, imageQuality: 70);
  }

  //||... show cities dialog ...||
  void showCitiesDialog() {
    showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: AppShared.settingResponse.settings.cities.length,
                  itemBuilder: (_, index) => ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      cityTextController.text =
                          AppShared.settingResponse.settings.cities[index].name;
                      cityId =
                          AppShared.settingResponse.settings.cities[index].id;
                    },
                    title: Text(
                        AppShared.settingResponse.settings.cities[index].name),
                  ),
                ),
              ),
            ));
  }

  //||... save new profile data ...||
  void save(startLoading, stopLoading, btnState) async {
    if (!editProfileFormState.currentState.validate()) return;
    editProfileFormState.currentState.save();
    if (name == AppShared.currentUser.name &&
        mobile == AppShared.currentUser.mobile &&
        cityId == AppShared.currentUser.cityId &&
        profileImage == null) {
      Helpers.showMessage(AppShared.appLang['ProfileIsAlreadyUpdated'],
          MessageType.MESSAGE_FAILED);
      return;
    }
    startLoading();
    try {
      MultipartFile image;
      if (profileImage != null) {
        image = await MultipartFile.fromFile(profileImage.path);
      }
      UserResponse userResponse = await userController.editProfile(
          image: image, mobile: mobile, name: name, cityId: cityId);
      stopLoading();
      if (userResponse.status) {
        AppShared.currentUser = userResponse.user;
        await AppShared.sharedPreferencesController
            .setUserData(AppShared.currentUser);
        Helpers.showMessage(userResponse.message, MessageType.MESSAGE_SUCCESS);
        Navigator.pushNamedAndRemoveUntil(
            context, Constants.SCREENS_COFFEE_MAIN_SCREEN, (_) => false);
      }
    } catch (error) {
      stopLoading();
      print(error);
      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
    }
  }
}

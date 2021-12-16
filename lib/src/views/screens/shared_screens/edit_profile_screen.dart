import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moonapp/src/models/api_models/sub_models/city.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/others_screens_notifiers/edit_profile_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/interfaces.dart';
import 'package:moonapp/src/views/components/others_components/custom_btn_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/dialogs/others_dialogs/select_city_dialog.dart';
import 'package:moonapp/src/views/dialogs/others_dialogs/select_image_dialog.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<EditProfileScreenNotifiers>(
        create: (_) => EditProfileScreenNotifiers(context),
        child: EditProfileScreenBody(),
      ),
    );
  }
}

class EditProfileScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileScreenBodyState();
  }
}

class _EditProfileScreenBodyState extends State<EditProfileScreenBody>
    implements OnImageSelectedListener, OnCitySelectedListener {
  EditProfileScreenNotifiers _editProfileScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editProfileScreenNotifiers =
        Provider.of<EditProfileScreenNotifiers>(context, listen: false);
  }

  @override
  void selectedImage(PickedFile image) {
    _editProfileScreenNotifiers.profileImage = image;
  }

  @override
  void selectedCity(City city) {
    _editProfileScreenNotifiers.cityTextController.text = city.name;
    _editProfileScreenNotifiers.cityId = city.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _editProfileScreenNotifiers.scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppShared.appLang['EditProfile'],
          style: TextStyle(fontSize: AppShared.isTablet ? 40 : 20),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: AppShared.isTablet ? 40 : 20,
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 55,
          ),
          InkWell(
            onTap: () {
              _editProfileScreenNotifiers.scaffoldKey.currentState
                  .showBottomSheet(
                (_) => SelectImageDialog(
                  onGetImageListener: this,
                ),
              );
            },
            child: Selector<EditProfileScreenNotifiers, PickedFile>(
              selector: (_, value) => value.profileImage,
              builder: (_, profileImage, __) => Center(
                child: Container(
                  height: AppShared.isTablet ? 200 : 135,
                  width: AppShared.isTablet ? 200 : 135,
                  child: profileImage == null
                      ? Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: AppShared.isTablet ? 50 : 20,
                        )
                      : Container(),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppShared.isTablet ? 25 : 15,
                      ),
                    ),
                    color: profileImage == null
                        ? const Color(0xff7c94b6)
                        : Colors.transparent,
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: profileImage == null
                          ? new ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.dstATop)
                          : null,
                      image: profileImage == null
                          ? new NetworkImage(
                              AppShared.currentUser.imageProfile,
                            )
                          : FileImage(File(
                              _editProfileScreenNotifiers.profileImage.path)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Form(
              key: _editProfileScreenNotifiers.editProfileFormState,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppShared.appLang['FullName'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 18,
                          ),
                        ),
                        TextFormField(
                          initialValue: AppShared.currentUser.name,
                          style: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 16,
                          ),
                          decoration: InputDecoration(
                              hintText: AppShared.appLang['EnterFullName']),
                          onFieldSubmitted: (value) {
                            _editProfileScreenNotifiers.mobileFocusNode
                                .requestFocus();
                          },
                          validator: (value) {
                            if (value.isEmpty)
                              return AppShared.appLang['ThisFieldIsRequired'];
                            return null;
                          },
                          onSaved: (value) {
                            _editProfileScreenNotifiers.name = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppShared.appLang['Email'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 18,
                          ),
                        ),
                        TextFormField(
                          enabled: false,
                          style: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 16,
                          ),
                          initialValue: AppShared.currentUser.email,
                          validator: (value) {
                            if (value.isEmpty)
                              return AppShared.appLang['ThisFieldIsRequired'];
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppShared.appLang['MobileNumber'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 18,
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 16,
                          ),
                          initialValue: AppShared.currentUser.mobile,
                          validator: (value) {
                            if (value.isEmpty)
                              return AppShared.appLang['ThisFieldIsRequired'];
                            return null;
                          },
                          focusNode:
                              _editProfileScreenNotifiers.mobileFocusNode,
                          onSaved: (value) {
                            _editProfileScreenNotifiers.mobile = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppShared.appLang['City'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 18,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => SelectCityDialog(
                                onCitySelectedListener: this,
                              ),
                            );
                          },
                          child: TextFormField(
                            controller:
                                _editProfileScreenNotifiers.cityTextController,
                            style: TextStyle(
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(50)
                                  : 16,
                            ),
                            enabled: false,
                            decoration: InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                              color: Colors.grey,
                            ))),
//                          validator: (value) {
//                            if (value.isEmpty) return 'please fill this field';
//                            return null;
//                          },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 30,
          ),
          CustomBtnComponent(
              text: AppShared.appLang['Save'],
              onTap: (startLoading, stopLoading, btnState) {
                _editProfileScreenNotifiers.save(
                    startLoading, stopLoading, btnState);
              }),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

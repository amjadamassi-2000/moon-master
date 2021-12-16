import 'package:flutter/material.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/others_screens_notifiers/change_password_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/components/others_components/custom_btn_component.dart';
import 'package:moonapp/src/views/components/others_components/custom_fade_animation_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<ChangePasswordScreenNotifiers>(
        create: (_) => ChangePasswordScreenNotifiers(context),
        child: ChangePasswordScreenBody(),
      ),
    );
  }
}

class ChangePasswordScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenBodyState();
  }
}

class _ChangePasswordScreenBodyState extends State<ChangePasswordScreenBody> {
  ChangePasswordScreenNotifiers _changePasswordScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _changePasswordScreenNotifiers =
        Provider.of<ChangePasswordScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppShared.appLang['ChangePassword'],
          style: TextStyle(fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          CustomFadeAnimationComponent(
            0.3,
            Center(
                child: Image.asset(
              '${Constants.ASSETS_IMAGES_PATH}logo.png',
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            )),
          ),
          SizedBox(
            height: 40,
          ),
          CustomFadeAnimationComponent(
            0.5,
            Form(
                key: _changePasswordScreenNotifiers.changePasswordFormState,
                child: Container(
                  padding: AppStyles.defaultPadding3,
                  child: Column(
                    children: <Widget>[
                      Selector<ChangePasswordScreenNotifiers, bool>(
                        selector: (_, value) => value.isOldPasswordVisible,
                        builder: (_, isOldPasswordVisible, __) => TextFormField(
                          decoration: InputDecoration(
                            hintText: AppShared.appLang['EnterOldPassword'],
                            suffixIcon: InkWell(
                              onTap: () {
                                _changePasswordScreenNotifiers
                                        .isOldPasswordVisible =
                                    !isOldPasswordVisible;
                              },
                              child: Icon(isOldPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          obscureText: !isOldPasswordVisible,
                          validator: (value) {
                            if (value.isEmpty)
                              return AppShared.appLang['ThisFieldIsRequired'];
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            _changePasswordScreenNotifiers.passwordFocusNode
                                .requestFocus();
                          },
                          onSaved: (value) {
                            _changePasswordScreenNotifiers.oldPassword = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Selector<ChangePasswordScreenNotifiers, bool>(
                        selector: (_, value) => value.isPasswordVisible,
                        builder: (_, isPasswordVisible, __) => TextFormField(
                          decoration: InputDecoration(
                            hintText: AppShared.appLang['EnterPassword'],
                            suffixIcon: InkWell(
                              onTap: () {
                                _changePasswordScreenNotifiers
                                    .isPasswordVisible = !isPasswordVisible;
                              },
                              child: Icon(isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          obscureText: !isPasswordVisible,
                          validator: (value) {
                            if (value.isEmpty)
                              return AppShared.appLang['ThisFieldIsRequired'];
                            return null;
                          },
                          focusNode:
                              _changePasswordScreenNotifiers.passwordFocusNode,
                          onFieldSubmitted: (value) {
                            _changePasswordScreenNotifiers
                                .confirmPasswordFocusNode
                                .requestFocus();
                          },
                          onSaved: (value) {
                            _changePasswordScreenNotifiers.password = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Selector<ChangePasswordScreenNotifiers, bool>(
                        selector: (_, value) => value.isConfirmPasswordVisible,
                        builder: (_, isConfirmPasswordVisible, __) =>
                            TextFormField(
                          decoration: InputDecoration(
                            hintText: AppShared.appLang['EnterConfirmPassword'],
                            suffixIcon: InkWell(
                              onTap: () {
                                _changePasswordScreenNotifiers
                                        .isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              },
                              child: Icon(isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          obscureText: !isConfirmPasswordVisible,
                          validator: (value) {
                            if (value.isEmpty)
                              return AppShared.appLang['ThisFieldIsRequired'];
                            return null;
                          },
                          focusNode: _changePasswordScreenNotifiers
                              .confirmPasswordFocusNode,
                          onSaved: (value) {
                            _changePasswordScreenNotifiers.confirmPassword =
                                value;
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          CustomFadeAnimationComponent(
            1,
            CustomBtnComponent(
                text: AppShared.appLang['Save'],
                onTap: (startLoading, stopLoading, btnState) {
                  _changePasswordScreenNotifiers.changePassword(
                      startLoading, stopLoading, btnState);
                }),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

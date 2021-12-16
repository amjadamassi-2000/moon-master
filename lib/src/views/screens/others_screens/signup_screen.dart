import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/models/api_models/sub_models/city.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/others_screens_notifiers/sign_up_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/interfaces.dart';
import 'package:moonapp/src/views/components/others_components/custom_btn_component.dart';
import 'package:moonapp/src/views/components/others_components/custom_fade_animation_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/dialogs/others_dialogs/select_city_dialog.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<SignUpScreenNotifiers>(
        create: (_) => SignUpScreenNotifiers(context),
        child: SignUpScreenBody(),
      ),
    );
  }
}

class SignUpScreenBody extends StatefulWidget {
  @override
  State createState() {
    return _SignUpScreenBodyState();
  }
}

class _SignUpScreenBodyState extends State<SignUpScreenBody>
    implements OnCitySelectedListener {
  SignUpScreenNotifiers _signUpScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpScreenNotifiers =
        Provider.of<SignUpScreenNotifiers>(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _signUpScreenNotifiers.cityTextController.dispose();
  }

  @override
  void selectedCity(City city) {
    _signUpScreenNotifiers.cityTextController.text = city.name;
    _signUpScreenNotifiers.cityId = city.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F0DD),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: const Color(0xffF7F0DD),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CustomFadeAnimationComponent(
            0.3,
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  AppShared.appLang['CreateNewAccount'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          CustomFadeAnimationComponent(
            0.6,
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Form(
                      key: _signUpScreenNotifiers.signUpFormState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppShared.appLang['FullName'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: AppShared.appLang['EnterFullName']),

                            validator: (value) {
                              if (value.isEmpty)
                                return AppShared.appLang['ThisFieldIsRequired'];
                              return null;
                            },

                            onFieldSubmitted: (value) {
                              _signUpScreenNotifiers.emailFocusNode
                                  .requestFocus();
                            },

                            onSaved: (value) {
                              _signUpScreenNotifiers.name = value;
                            },



                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppShared.appLang['Email'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: AppShared.appLang['EnterEmail']),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty)
                                return AppShared.appLang['ThisFieldIsRequired'];
                              if (!EmailValidator.validate(value))
                                return AppShared
                                    .appLang['ThisIsNotEmailFormat'];
                              return null;
                            },
                            focusNode: _signUpScreenNotifiers.emailFocusNode,
                            onFieldSubmitted: (value) {
                              _signUpScreenNotifiers.mobileFocusNode
                                  .requestFocus();
                            },
                            onSaved: (value) {
                              _signUpScreenNotifiers.email = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppShared.appLang['MobileNumber'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText:
                                    AppShared.appLang['EnterMobileNumber']),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty)
                                return AppShared.appLang['ThisFieldIsRequired'];
                              return null;
                            },
                            focusNode: _signUpScreenNotifiers.mobileFocusNode,
                            onFieldSubmitted: (value) {
                              _signUpScreenNotifiers.cityFocusNode
                                  .requestFocus();
                            },
                            onSaved: (value) {
                              _signUpScreenNotifiers.mobile = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppShared.appLang['City'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
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
                                  _signUpScreenNotifiers.cityTextController,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: AppShared.appLang['ChooseACity'],
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              focusNode: _signUpScreenNotifiers.cityFocusNode,


                              onFieldSubmitted: (value) {
                                _signUpScreenNotifiers.passwordFocusNode
                                    .requestFocus();
                              },

                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppShared.appLang['Password'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Selector<SignUpScreenNotifiers, bool>(
                            selector: (_, value) => value.isPasswordVisible,
                            builder: (_, isPasswordVisible, __) =>
                                TextFormField(
                              decoration: InputDecoration(
                                hintText: AppShared.appLang['EnterPassword'],
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _signUpScreenNotifiers.isPasswordVisible =
                                        !isPasswordVisible;
                                  },
                                  child: Icon(isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              obscureText: !isPasswordVisible,
                              validator: (value) {
                                if (value.isEmpty)
                                  return AppShared
                                      .appLang['ThisFieldIsRequired'];
                                return null;
                              },
                              focusNode:
                                  _signUpScreenNotifiers.passwordFocusNode,
                              onFieldSubmitted: (value) {
                                _signUpScreenNotifiers.confirmPasswordFocusNode
                                    .requestFocus();
                              },
                              onSaved: (value) {
                                _signUpScreenNotifiers.password = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppShared.appLang['ConfirmPassword'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Selector<SignUpScreenNotifiers, bool>(
                            selector: (_, value) =>
                                value.isConfirmPasswordVisible,
                            builder: (_, isConfirmPasswordVisible, __) =>
                                TextFormField(
                              decoration: InputDecoration(
                                hintText:
                                    AppShared.appLang['EnterConfirmPassword'],
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _signUpScreenNotifiers
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
                                  return AppShared
                                      .appLang['ThisFieldIsRequired'];
                                return null;
                              },
                              focusNode: _signUpScreenNotifiers
                                  .confirmPasswordFocusNode,
                              onSaved: (value) {
                                _signUpScreenNotifiers.confirmPassword = value;
                              },
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          CustomFadeAnimationComponent(
            1,
            CustomBtnComponent(
                text: AppShared.appLang['SignUp'],
                onTap: (startLoading, stopLoading, btnState) {
                  _signUpScreenNotifiers.signUp(
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

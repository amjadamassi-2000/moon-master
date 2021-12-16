import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/others_screens_notifiers/sign_in_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/components/others_components/custom_btn_component.dart';
import 'package:moonapp/src/views/components/others_components/custom_fade_animation_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<SignInScreenNotifiers>(
        create: (_) => SignInScreenNotifiers(context),
        child: SignInScreenBody(),
      ),
    );
  }
}

class SignInScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInScreenBodyState();
  }
}

class _SignInScreenBodyState extends State<SignInScreenBody> {
  SignInScreenNotifiers _signInScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signInScreenNotifiers =
        Provider.of<SignInScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: const Color(0xffF7F0DD),
        actions: <Widget>[
          FlatButton(
              onPressed: _signInScreenNotifiers.skip,
              child: Text(AppShared.appLang['Skip']))
        ],
      ),
      backgroundColor: const Color(0xffF7F0DD),
      body: ListView(
        children: <Widget>[
          CustomFadeAnimationComponent(
            0.3,
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  AppShared.appLang['LoginInToYourAccount'],
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
            0.5,
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _signInScreenNotifiers.signInFormState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      AppShared.appLang['Email'],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: AppShared.appLang['EnterEmail']),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {
                        _signInScreenNotifiers.passwordFocusNode.requestFocus();
                      },
                      validator: (value) {
                        if (value.isEmpty)
                          return AppShared.appLang['ThisFieldIsRequired'];
                        if (!EmailValidator.validate(value))
                          return AppShared.appLang['ThisIsNotEmailFormat'];
                        return null;
                      },
                      onSaved: (value) {
                        _signInScreenNotifiers.email = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppShared.appLang['Password'],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    Selector<SignInScreenNotifiers, bool>(
                      selector: (_, value) => value.isPasswordVisible,
                      builder: (_, isPasswordVisible, __) => TextFormField(
                        decoration: InputDecoration(
                          hintText: AppShared.appLang['EnterPassword'],
                          suffixIcon: InkWell(
                            onTap: () {
                              _signInScreenNotifiers.isPasswordVisible =
                                  !isPasswordVisible;
                            },
                            child: Icon(isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        focusNode: _signInScreenNotifiers.passwordFocusNode,
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value.isEmpty)
                            return AppShared.appLang['ThisFieldIsRequired'];
                          return null;
                        },
                        onSaved: (value) {
                          _signInScreenNotifiers.password = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          CustomFadeAnimationComponent(
            0.8,

            CustomBtnComponent(
                text: AppShared.appLang['SignIn'],
                onTap: (startLoading, stopLoading, btnState) {
                  _signInScreenNotifiers.signIn(
                      startLoading, stopLoading, btnState);
                }
                ),

          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: FlatButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(Constants.SCREEN_FORGOT_PASSWORD_SCREEN);
                },
                child: Text(
                  AppShared.appLang['ForgotPassword'],
                  style: TextStyle(color: Colors.black),
                )),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: const Color(0xffF7F0DD),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFadeAnimationComponent(
                1,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppShared.appLang["Don'tHaveAnAccount"],
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Constants.SCREEN_SIGN_UP_SCREEN);
                        },
                        child: Text(
                          AppShared.appLang['SignUp'],
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

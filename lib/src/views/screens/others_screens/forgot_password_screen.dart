import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/others_screens_notifiers/forget_password_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/views/components/others_components/custom_btn_component.dart';
import 'package:moonapp/src/views/components/others_components/custom_fade_animation_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<ForgetPasswordScreenNotifiers>(
        create: (_) => ForgetPasswordScreenNotifiers(context),
        child: ForgotPasswordScreenBody(),
      ),
    );
  }
}

class ForgotPasswordScreenBody extends StatefulWidget {
  @override
  State createState() {
    return _ForgotPasswordScreenBodyState();
  }
}

class _ForgotPasswordScreenBodyState extends State<ForgotPasswordScreenBody> {
  ForgetPasswordScreenNotifiers _forgetPasswordScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _forgetPasswordScreenNotifiers =
        Provider.of<ForgetPasswordScreenNotifiers>(context, listen: false);
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
                  AppShared.appLang['ResetPassword'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
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
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _forgetPasswordScreenNotifiers.forgotPasswordFormState,
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
                      validator: (value) {
                        if (value.isEmpty)
                          return AppShared.appLang['ThisFieldIsRequired'];
                        if (!EmailValidator.validate(value))
                          return AppShared.appLang['ThisIsNotEmailFormat'];
                        return null;
                      },
                      onSaved: (value) {
                        _forgetPasswordScreenNotifiers.email = value;
                      },
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
                text: AppShared.appLang['Send'],
                onTap: (startLoading, stopLoading, btnState) {
                  _forgetPasswordScreenNotifiers.forgotPassword(
                      startLoading, stopLoading, btnState);
                }),
          ),
        ],
      ),
    );
  }
}

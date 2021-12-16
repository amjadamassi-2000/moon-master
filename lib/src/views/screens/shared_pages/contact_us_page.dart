import 'package:email_launcher/email_launcher.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_pages_notifiers/contact_us_page_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/custom_btn_component.dart';
import 'package:moonapp/src/views/components/others_components/custom_fade_animation_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  final ZoomDrawerController _zoomDrawerController;

  ContactUsPage(this._zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<ContactUsPageNotifiers>(
        create: (_) => ContactUsPageNotifiers(context),
        child: ContactUsPageBody(_zoomDrawerController),
      ),
    );
  }
}

class ContactUsPageBody extends StatefulWidget {
  final ZoomDrawerController _zoomDrawerController;

  ContactUsPageBody(this._zoomDrawerController);

  @override
  State<StatefulWidget> createState() {
    return _ContactUsPageBodyState();
  }
}

class _ContactUsPageBodyState extends State<ContactUsPageBody> {
  ContactUsPageNotifiers _contactUsPageNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contactUsPageNotifiers =
        Provider.of<ContactUsPageNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppShared.appLang['ContactUs'],
          style: TextStyle(fontSize: 20),
        ),
        leading: InkWell(
          onTap: () {
            Helpers.handleDrawer(widget._zoomDrawerController);
          },
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          CustomFadeAnimationComponent(
            0.2,
            Container(
              padding: const EdgeInsets.all(15),
              color: const Color(0xffF7F0DD),
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  AppShared.appLang['ContactInfo'],
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          CustomFadeAnimationComponent(
            0.3,
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                        child: SvgPicture.asset(
                          '${Constants.ASSETS_IMAGES_PATH}email.svg',
                          height: 12,
                          width: 12,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          Email email = Email(to: [
                            AppShared.settingResponse.settings.infoEmail
                          ], cc: [
                            'foo@gmail.com'
                          ], bcc: [
                            'bar@gmail.com'
                          ], subject: 'subject', body: 'body');
                          await EmailLauncher.launch(email);
                        },
                        child: Text(
                          AppShared.settingResponse.settings.infoEmail,
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                        child: SvgPicture.asset(
                          '${Constants.ASSETS_IMAGES_PATH}phone.svg',
                          height: 15,
                          width: 15,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        AppShared.settingResponse.settings.phone,
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                        child: SvgPicture.asset(
                          '${Constants.ASSETS_IMAGES_PATH}mobile.svg',
                          height: 15,
                          width: 15,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              AppShared.settingResponse.settings.mobile);
                        },
                        child: Text(
                          AppShared.settingResponse.settings.mobile,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              await launch(
                                  AppShared.settingResponse.settings.facebook);
                            },
                            child: SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}facebook.svg'),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () async {
                              await launch(
                                  AppShared.settingResponse.settings.instagram);
                            },
                            child: SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}instagram.svg'),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                              onTap: () async {
                                await launch(
                                    AppShared.settingResponse.settings.twitter);
                              },
                              child: SvgPicture.asset(
                                  '${Constants.ASSETS_IMAGES_PATH}twitter.svg')),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          CustomFadeAnimationComponent(
            0.6,
            Container(
              padding: const EdgeInsets.all(15),
              color: const Color(0xffF7F0DD),
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  AppShared.appLang['ContactForm'],
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          CustomFadeAnimationComponent(
            0.7,
            Form(
                key: _contactUsPageNotifiers.contactUsFormState,
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
                                fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: AppShared.appLang['EnterFullName'],
                            ),
                            onSaved: (value) {
                              _contactUsPageNotifiers.name = value;
                            },
                            onFieldSubmitted: (value) {
                              _contactUsPageNotifiers.emailFocusNode
                                  .requestFocus();
                            },
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
                            AppShared.appLang['Email'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: AppShared.appLang['EnterEmail'],
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              _contactUsPageNotifiers.email = value;
                            },
                            focusNode: _contactUsPageNotifiers.emailFocusNode,
                            onFieldSubmitted: (value) {
                              _contactUsPageNotifiers.mobileFocusNode
                                  .requestFocus();
                            },
                            validator: (value) {
                              if (value.isEmpty)
                                return AppShared.appLang['ThisFieldIsRequired'];
                              if (!EmailValidator.validate(value))
                                return AppShared
                                    .appLang['ThisIsNotEmailFormat'];
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
                                fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: AppShared.appLang['EnterMobileNumber'],
                            ),
                            keyboardType: TextInputType.phone,
                            onSaved: (value) {
                              _contactUsPageNotifiers.mobile = value;
                            },
                            focusNode: _contactUsPageNotifiers.mobileFocusNode,
                            onFieldSubmitted: (value) {
                              _contactUsPageNotifiers.messageFocusNode
                                  .requestFocus();
                            },
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
                            AppShared.appLang['Message'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: AppShared.appLang['EnterMessage'],
                            ),
                            onSaved: (value) {
                              _contactUsPageNotifiers.message = value;
                            },
                            focusNode: _contactUsPageNotifiers.messageFocusNode,
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
                      height: 40,
                    ),
                  ],
                )),
          ),
          CustomFadeAnimationComponent(
            0.9,
            CustomBtnComponent(
                text: AppShared.appLang['Send'],
                onTap: (startLoading, stopLoading, btnState) {
                  _contactUsPageNotifiers.send(
                      startLoading, stopLoading, btnState);
                }),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

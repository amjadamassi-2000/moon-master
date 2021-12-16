import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_pages_notifiers/settings_page_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class SettingsPage extends StatelessWidget {
  final ZoomDrawerController _zoomDrawerController;

  SettingsPage(this._zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<SettingsPageNotifiers>(
        create: (_) => SettingsPageNotifiers(),
        child: SettingsPageBody(_zoomDrawerController),
      ),
    );
  }
}

class SettingsPageBody extends StatefulWidget {
  final ZoomDrawerController _zoomDrawerController;

  SettingsPageBody(this._zoomDrawerController);

  @override
  _SettingsPageBodyState createState() => _SettingsPageBodyState();
}

class _SettingsPageBodyState extends State<SettingsPageBody> {
  AppNotifiers _appNotifiers;
  SettingsPageNotifiers _settingsPageNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
    _settingsPageNotifiers =
        Provider.of<SettingsPageNotifiers>(context, listen: false);
  }

  Widget buildOptions(
      bool showDivider, String icon, String title, Widget widget,
      {Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: SvgPicture.asset(
                    '${Constants.ASSETS_IMAGES_PATH}$icon.svg',
                    width: AppShared.isTablet ? 40 : 15,
                    height: AppShared.isTablet ? 40 : 15,
//                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppShared.isTablet
                        ? AppShared.screenUtil.setSp(45)
                        : 16,
                  ),
                ),
                Spacer(),
                widget
              ],
            ),
          ),
          !showDivider
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Divider(
                    color: const Color(0xffE5E5E5),
                    height: 10,
                    thickness: 1,
                  ),
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppShared.appLang['Settings'],
          style: TextStyle(
            fontSize: AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 16,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Helpers.handleDrawer(widget._zoomDrawerController);
          },
          child: Icon(
            Icons.menu,
            color: Colors.black,
            size: AppShared.isTablet ? 50 : 25,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          buildOptions(
              true,
              'notifications',
              AppShared.appLang['Notifications'],
              Selector<SettingsPageNotifiers, bool>(
                selector: (_, value) => value.isNotificationEnabled,
                builder: (_, isNotificationEnabled, __) => Switch.adaptive(
                    activeColor: const Color(0xff4CD964),
                    value: isNotificationEnabled,
                    onChanged: (val) {
                      _settingsPageNotifiers.isNotificationEnabled =
                          !isNotificationEnabled;
                    }),
              )),
          buildOptions(
              true,
              'lang',
              AppShared.appLang['ChangeLanguage'],
              Row(
                children: <Widget>[
                  Text(
                    AppShared.sharedPreferencesController.getAppLang() ==
                            Constants.LANG_EN
                        ? 'AR'
                        : 'EN',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(35)
                            : 16),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: AppShared.isTablet ? 35 : 20,
                    color: Colors.black,
                  )
                ],
              ), onTap: () {
            AppShared.sharedPreferencesController.setAppLang(
                AppShared.sharedPreferencesController.getAppLang() ==
                        Constants.LANG_EN
                    ? Constants.LANG_AR
                    : Constants.LANG_EN);

            _appNotifiers.refreshApp = !_appNotifiers.refreshApp;
            _appNotifiers.notification = null;
            Navigator.pushNamedAndRemoveUntil(
                context, Constants.SCREENS_SPLASH_SCREEN, (route) => false);
          }),
          buildOptions(
              false,
              'password',
              AppShared.appLang['ChangePassword'],
              Icon(
                Icons.arrow_forward_ios,
                size: AppShared.isTablet ? 35 : 20,
              ), onTap: () {
            Navigator.of(context)
                .pushNamed(Constants.SCREENS_CHANGE_PASSWORD_SCREEN);
          }),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            color: const Color(0xffF7F0DD),
          ),
          buildOptions(
            true,
            'share',
            AppShared.appLang['ShareApp'],
            Icon(
              Icons.arrow_forward_ios,
              size: AppShared.isTablet ? 35 : 20,
            ),
            onTap: () {
              Share.share(Platform.isAndroid
                  ? AppShared.settingResponse.settings.playStoreUrl
                  : AppShared.settingResponse.settings.appStoreUrl);
            },
          ),
          buildOptions(
              true,
              'terms',
              AppShared.appLang['TermsOfUse'],
              Icon(
                Icons.arrow_forward_ios,
                size: AppShared.isTablet ? 35 : 20,
              ), onTap: () {
            Navigator.of(context)
                .pushNamed(Constants.SCREENS_TERMS_OF_USE_SCREEN);
          }),
          buildOptions(
              false,
              'privacy',
              AppShared.appLang['PrivacyPolicy'],
              Icon(
                Icons.arrow_forward_ios,
                size: AppShared.isTablet ? 35 : 20,
              ), onTap: () {
            Navigator.of(context).pushNamed(Constants.SCREENS_PRIVACY_SCREEN);
          })
        ],
      ),
    );
  }
}

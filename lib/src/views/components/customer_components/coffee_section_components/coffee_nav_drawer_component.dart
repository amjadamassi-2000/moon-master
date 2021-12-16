import 'package:flutter/material.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/auth_controller.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_main_screen_notifiers/coffee_main_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:provider/provider.dart';

class CoffeeNavDrawerComponent extends StatelessWidget {
  final CoffeeMainScreenNotifiers _coffeeMainScreenNotifiers;
  final ZoomDrawerController _zoomDrawerController;

  CoffeeNavDrawerComponent(
      this._coffeeMainScreenNotifiers, this._zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CoffeeMainScreenNotifiers>(
      create: (_) => CoffeeMainScreenNotifiers(),
      child: CoffeeNavDrawerComponentBody(
          _coffeeMainScreenNotifiers, _zoomDrawerController),
    );
  }
}

class CoffeeNavDrawerComponentBody extends StatefulWidget {
  final CoffeeMainScreenNotifiers _coffeeMainScreenNotifiers;
  final ZoomDrawerController _zoomDrawerController;

  CoffeeNavDrawerComponentBody(
      this._coffeeMainScreenNotifiers, this._zoomDrawerController);
  @override
  _CoffeeNavDrawerComponentBodyState createState() =>
      _CoffeeNavDrawerComponentBodyState();
}

class _CoffeeNavDrawerComponentBodyState
    extends State<CoffeeNavDrawerComponentBody> {
  AuthController _authController;
  bool isLogin = AppShared.sharedPreferencesController.getIsLogin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authController = AuthController.instance;
  }

  // leading widget
  Widget listTileLeading(int index) {
    return Container(
      width: AppShared.isTablet ? 10 : 5,
      height: AppShared.isTablet ? 50 : 30,
      color: widget._coffeeMainScreenNotifiers.selectedIndex == index
          ? Theme.of(context).primaryColor
          : Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: AppStyles.defaultPadding3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                width: AppShared.isTablet ? 250 : 100,
                height: AppShared.isTablet ? 250 : 100,
                child: CircleAvatar(
                  backgroundImage:
                      AppShared.sharedPreferencesController.getIsLogin()
                          ? NetworkImage(
                              AppShared.currentUser.imageProfile,
                            )
                          : AssetImage(
                              '${Constants.ASSETS_IMAGES_PATH}app_icon.png',
                            ),
                ),
              ),
              SizedBox(
                height: AppShared.isTablet ? 30 : 15,
              ),
              AppShared.sharedPreferencesController.getIsLogin()
                  ? Text(
                      AppShared.currentUser.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(50)
                            : 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Container(),
              SizedBox(
                height: AppShared.isTablet ? 15 : 5,
              ),
              AppShared.sharedPreferencesController.getIsLogin()
                  ? Text(
                      AppShared.currentUser.email,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(35)
                            : 13,
                      ),
                    )
                  : Container(),
              AppShared.sharedPreferencesController.getIsLogin()
                  ? FlatButton.icon(
                      onPressed: () async {
                        _authController.logout();
                        AppNotifiers app =
                            Provider.of<AppNotifiers>(context, listen: false);
                        app.refreshApp = !app.refreshApp;
                        Navigator.pushReplacementNamed(
                            context, Constants.SCREENS_SPLASH_SCREEN);
                      },
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                        size: AppShared.isTablet ? 35 : 25,
                      ),
                      label: Text(
                        AppShared.appLang['SignOut'],
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(35)
                                : 16),
                      ),
                    )
                  : FlatButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Constants.SCREEN_SIGN_IN_SCREEN);
                      },
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.orange,
                        size: AppShared.isTablet ? 35 : 25,
                      ),
                      label: Text(
                        AppShared.appLang['SignIn'],
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(35)
                              : 16,
                        ),
                      ),
                    ),
              SizedBox(
                height: AppShared.isTablet ? 15 : 5,
              ),
              AppShared.sharedPreferencesController.getIsLogin() &&
                      AppShared.currentUser.type == Constants.USER_TYPE_WAITER
                  ? Container()
                  : Row(
                      children: <Widget>[
                        Visibility(
                          visible: AppShared.settingResponse.settings.show_salon == 1,
                          child: InkWell(
                            onTap: () {
                              AppShared.sharedPreferencesController
                                  .setSectionType(Constants.SECTION_TYPE_SALON);
                              Navigator.pushReplacementNamed(
                                  context, Constants.SCREENS_BEAUTY_MAIN_SCREEN);
                            },
                            child: Chip(
                              label: Text(
                                AppShared.appLang['Salon'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Visibility(
                          visible: AppShared.settingResponse.settings.show_store == 1,
                          child: InkWell(
                            onTap: () {
                              AppShared.sharedPreferencesController.setSectionType(Constants.SECTION_TYPE_STORE);
                              Navigator.pushReplacementNamed(
                                  context, Constants.SCREENS_STORE_MAIN_SCREEN);
                            },
                            child : Chip(
                              label: Text(
                                AppShared.appLang['Store'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      widget._coffeeMainScreenNotifiers.selectedIndex = 0;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(
                      AppShared.appLang['Home'],
                      style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(40)
                              : 16),
                    ),
                    leading: listTileLeading(0),
                  ),
                  SizedBox(
                    height: AppShared.isTablet ? 15 : 5,
                  ),
                  ListTile(
                    onTap: () {
                      if (!isLogin) {
                        Navigator.pushNamed(
                            context, Constants.SCREEN_SIGN_IN_SCREEN);
                        return;
                      }
                      widget._coffeeMainScreenNotifiers.selectedIndex = 1;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(
                      AppShared.appLang['Notifications'],
                      style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(40)
                              : 16),
                    ),
                    leading: listTileLeading(1),
                  ),
                  SizedBox(
                    height: AppShared.isTablet ? 15 : 5,
                  ),
                  ListTile(
                    onTap: () {
                      if (!isLogin) {
                        Navigator.pushNamed(
                            context, Constants.SCREEN_SIGN_IN_SCREEN);
                        return;
                      }
                      widget._coffeeMainScreenNotifiers.selectedIndex = 2;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(
                      AppShared.appLang['Orders'],
                      style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(40)
                              : 16),
                    ),
                    leading: listTileLeading(2),
                  ),
                  SizedBox(
                    height: AppShared.isTablet ? 15 : 5,
                  ),
                  ListTile(
                    onTap: () {
                      widget._coffeeMainScreenNotifiers.selectedIndex = 3;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(
                      AppShared.appLang['Favorites'],
                      style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(40)
                              : 16),
                    ),
                    leading: listTileLeading(3),
                  ),
                  SizedBox(
                    height: AppShared.isTablet ? 15 : 5,
                  ),
                  ListTile(
                    onTap: () {
                      widget._coffeeMainScreenNotifiers.selectedIndex = 5;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(
                      AppShared.appLang['AboutUs'],
                      style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(40)
                              : 16),
                    ),
                    leading: listTileLeading(5),
                  ),
                  SizedBox(
                    height: AppShared.isTablet ? 15 : 5,
                  ),
                  ListTile(
                    onTap: () {
                      widget._coffeeMainScreenNotifiers.selectedIndex = 6;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(
                      AppShared.appLang['Q&F'],
                      style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(40)
                              : 16),
                    ),
                    leading: listTileLeading(6),
                  ),
                  SizedBox(
                    height: AppShared.isTablet ? 15 : 5,
                  ),
                  ListTile(
                    onTap: () {
                      widget._coffeeMainScreenNotifiers.selectedIndex = 7;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(
                      AppShared.appLang['Settings'],
                      style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(40)
                              : 16),
                    ),
                    leading: listTileLeading(7),
                  ),
                  SizedBox(
                    height: AppShared.isTablet ? 15 : 5,
                  ),
                  AppShared.sharedPreferencesController.getIsLogin() &&
                          AppShared.currentUser.type ==
                              Constants.USER_TYPE_WAITER
                      ? Container()
                      : ListTile(
                          onTap: () {
                            widget._coffeeMainScreenNotifiers.selectedIndex = 8;
                            widget._zoomDrawerController.close();
                          },
                          title: Text(
                            AppShared.appLang['ContactUs'],
                            style: TextStyle(
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(40)
                                    : 16),
                          ),
                          leading: listTileLeading(8),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

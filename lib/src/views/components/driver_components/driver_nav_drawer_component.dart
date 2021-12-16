import 'package:flutter/material.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/auth_controller.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_main_screen_notifiers/coffee_main_screen_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/driver_screen_notifiers/driver_orders_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:provider/provider.dart';

class DriverNavDrawerComponent extends StatelessWidget {
  final DriverOrdersScreenNotifiers _driverOrdersScreenNotifiers;
  final ZoomDrawerController _zoomDrawerController;

  DriverNavDrawerComponent(
      this._driverOrdersScreenNotifiers, this._zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CoffeeMainScreenNotifiers>(
      create: (_) => CoffeeMainScreenNotifiers(),
      child: DriverNavDrawerComponentBody(
          _driverOrdersScreenNotifiers, _zoomDrawerController),
    );
  }
}

class DriverNavDrawerComponentBody extends StatefulWidget {
  final DriverOrdersScreenNotifiers _driverOrdersScreenNotifiers;
  final ZoomDrawerController _zoomDrawerController;

  DriverNavDrawerComponentBody(
      this._driverOrdersScreenNotifiers, this._zoomDrawerController);
  @override
  _DriverNavDrawerComponentBodyState createState() =>
      _DriverNavDrawerComponentBodyState();
}

class _DriverNavDrawerComponentBodyState
    extends State<DriverNavDrawerComponentBody> {
  AuthController _authController;
  bool isLogin = AppShared.sharedPreferencesController.getIsLogin();

  @override
  void initState() {
    super.initState();
    _authController = AuthController.instance;
  }

  // leading widget
  Widget listTileLeading(int index) {
    return Container(
      width: 5,
      height: 30,
      color: widget._driverOrdersScreenNotifiers.selectedIndex == index
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
          child: InkWell(
            onTap: () {
              if (AppShared.sharedPreferencesController.getIsLogin())
                Navigator.pushNamed(context, Constants.SCREENS_PROFILE_SCREEN);
              else
                Navigator.pushNamed(context, Constants.SCREEN_SIGN_IN_SCREEN);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    radius: 50,
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
                  height: 15,
                ),
                AppShared.sharedPreferencesController.getIsLogin()
                    ? Text(
                        AppShared.currentUser.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                AppShared.sharedPreferencesController.getIsLogin()
                    ? Text(
                        AppShared.currentUser.email,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
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
                        ),
                        label: Text(
                          AppShared.appLang['SignOut'],
                          style: TextStyle(color: Colors.red),
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
                        ),
                        label: Text(
                          AppShared.appLang['SignIn'],
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        if (!isLogin) {
                          Navigator.pushNamed(
                              context, Constants.SCREEN_SIGN_IN_SCREEN);
                          return;
                        }
                        widget._driverOrdersScreenNotifiers.selectedIndex = 0;
                        widget._zoomDrawerController.close();
                      },
                      title: Text(AppShared.appLang['Orders']),
                      leading: listTileLeading(0),
                    ),
                    ListTile(
                      onTap: () {
                        widget._driverOrdersScreenNotifiers.selectedIndex = 1;
                        widget._zoomDrawerController.close();
                      },
                      title: Text(AppShared.appLang['AboutUs']),
                      leading: listTileLeading(1),
                    ),
                    ListTile(
                      onTap: () {
                        widget._driverOrdersScreenNotifiers.selectedIndex = 2;
                        widget._zoomDrawerController.close();
                      },
                      title: Text(AppShared.appLang['Q&F']),
                      leading: listTileLeading(2),
                    ),
                    ListTile(
                      onTap: () {
                        widget._driverOrdersScreenNotifiers.selectedIndex = 3;
                        widget._zoomDrawerController.close();
                      },
                      title: Text(AppShared.appLang['Settings']),
                      leading: listTileLeading(3),
                    ),
                    ListTile(
                      onTap: () {
                        widget._driverOrdersScreenNotifiers.selectedIndex = 4;
                        widget._zoomDrawerController.close();
                      },
                      title: Text(AppShared.appLang['ContactUs']),
                      leading: listTileLeading(4),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/controllers/api_controllers/others_controllers/auth_controller.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/store_section_screens_notifiers/store_main_screen_notifiers/store_main_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:provider/provider.dart';

class StoreNavDrawerComponent extends StatelessWidget {
  final StoreMainScreenNotifiers _storeMainScreenNotifiers;
  final ZoomDrawerController _zoomDrawerController;

  StoreNavDrawerComponent(
      this._storeMainScreenNotifiers, this._zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoreMainScreenNotifiers>(
      create: (_) => StoreMainScreenNotifiers(),
      child: StoreNavDrawerComponentBody(
          _storeMainScreenNotifiers, _zoomDrawerController),
    );
  }
}

class StoreNavDrawerComponentBody extends StatefulWidget {
  final StoreMainScreenNotifiers _storeMainScreenNotifiers;
  final ZoomDrawerController _zoomDrawerController;

  StoreNavDrawerComponentBody(
      this._storeMainScreenNotifiers, this._zoomDrawerController);
  @override
  _StoreNavDrawerComponentBodyState createState() =>
      _StoreNavDrawerComponentBodyState();
}

class _StoreNavDrawerComponentBodyState
    extends State<StoreNavDrawerComponentBody> {
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
      width: 5,
      height: 30,
      color: widget._storeMainScreenNotifiers.selectedIndex == index
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
              Row(
                children: <Widget>[
                  Visibility(
                    visible: AppShared.settingResponse.settings.show_coffe == 1,
                    child: InkWell(
                      onTap: () {
                        AppShared.sharedPreferencesController
                            .setSectionType(Constants.SECTION_TYPE_COFFEE);
                        Navigator.pushReplacementNamed(
                            context, Constants.SCREENS_COFFEE_MAIN_SCREEN);
                      },
                      child: Chip(
                        label: Text(
                          AppShared.appLang['Coffee'],
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
                ],
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      widget._storeMainScreenNotifiers.selectedIndex = 0;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(AppShared.appLang['Home']),
                    leading: listTileLeading(0),
                  ),
                  ListTile(
                    onTap: () {
                      if (!isLogin) {
                        Navigator.pushNamed(
                            context, Constants.SCREEN_SIGN_IN_SCREEN);
                        return;
                      }
                      widget._storeMainScreenNotifiers.selectedIndex = 1;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(AppShared.appLang['Notifications']),
                    leading: listTileLeading(1),
                  ),
                  ListTile(
                    onTap: () {
                      if (!isLogin) {
                        Navigator.pushNamed(
                            context, Constants.SCREEN_SIGN_IN_SCREEN);
                        return;
                      }
                      widget._storeMainScreenNotifiers.selectedIndex = 2;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(AppShared.appLang['Orders']),
                    leading: listTileLeading(2),
                  ),
                  ListTile(
                    onTap: () {
                      widget._storeMainScreenNotifiers.selectedIndex = 3;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(AppShared.appLang['Favorites']),
                    leading: listTileLeading(3),
                  ),
                  ListTile(
                    onTap: () {
                      widget._storeMainScreenNotifiers.selectedIndex = 5;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(AppShared.appLang['AboutUs']),
                    leading: listTileLeading(5),
                  ),
                  ListTile(
                    onTap: () {
                      widget._storeMainScreenNotifiers.selectedIndex = 6;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(AppShared.appLang['Q&F']),
                    leading: listTileLeading(6),
                  ),
                  ListTile(
                    onTap: () {
                      widget._storeMainScreenNotifiers.selectedIndex = 7;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(AppShared.appLang['Settings']),
                    leading: listTileLeading(7),
                  ),
                  ListTile(
                    onTap: () {
                      widget._storeMainScreenNotifiers.selectedIndex = 8;
                      widget._zoomDrawerController.close();
                    },
                    title: Text(AppShared.appLang['ContactUs']),
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

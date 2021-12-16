import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/store_section_screens_notifiers/store_main_screen_notifiers/pages_notifiers/store_home_screen_notifiers/store_home_screen_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/store_section_screens_notifiers/store_main_screen_notifiers/store_main_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/screens/customer_screens/store_section_screens/store_main_screen/pages/store_home_screen/screens/store_home_tab_screen.dart';
import 'package:moonapp/src/views/screens/others_screens/signin_screen.dart';
import 'package:moonapp/src/views/screens/shared_pages/my_cart_screen.dart';
import 'package:moonapp/src/views/screens/shared_pages/offers_page.dart';
import 'package:moonapp/src/views/screens/shared_screens/profile_screen.dart';
import 'package:provider/provider.dart';

class StoreHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoreHomeScreenNotifiers>(
      create: (_) => StoreHomeScreenNotifiers(context),
      child: StoreHomeScreenBody(),
    );
  }
}

class StoreHomeScreenBody extends StatefulWidget {
  @override
  _StoreHomeScreenBodyState createState() => _StoreHomeScreenBodyState();
}

class _StoreHomeScreenBodyState extends State<StoreHomeScreenBody> {
  StoreHomeScreenNotifiers _storeHomeScreenNotifiers;
  StoreMainScreenNotifiers _storeMainScreenNotifiers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeMainScreenNotifiers =
        Provider.of<StoreMainScreenNotifiers>(context, listen: false);
    _storeHomeScreenNotifiers =
        Provider.of<StoreHomeScreenNotifiers>(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _storeHomeScreenNotifiers.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Selector<StoreHomeScreenNotifiers, int>(
          selector: (_, value) => value.selectedScreen,
          builder: (_, selectedScreen, __) => AppBar(
            backgroundColor: selectedScreen == 3
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            elevation: 0,
            title: Text(
              _storeHomeScreenNotifiers.titles[selectedScreen],
              style: TextStyle(
                color: selectedScreen == 3 ? Colors.white : Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            actions: <Widget>[
              selectedScreen == 0
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(Constants
                              .SCREENS_COFFEE_SEARCH_ABOUT_PRODUCT_SCREEN);
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container(),
            ],
            leading: InkWell(
              onTap: () {
                Helpers.handleDrawer(
                  _storeMainScreenNotifiers.zoomDrawerController,
                );
              },
              child: Icon(
                Icons.menu,
                color: selectedScreen == 3 ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Selector<StoreHomeScreenNotifiers, int>(
        selector: (_, value) => value.selectedScreen,
        builder: (_, selectedScreen, __) => BottomNavigationBar(
          onTap: (pageIndex) {
            _storeHomeScreenNotifiers.pageController.jumpToPage(pageIndex);
            _storeHomeScreenNotifiers.selectedScreen = pageIndex;
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: selectedScreen == 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
              ),
              title: Text(
                AppShared.appLang['Home'],
                style: TextStyle(
                  color: selectedScreen == 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                  fontSize: 12,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: selectedScreen == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
              ),
              title: Text(
                AppShared.appLang['Cart'],
                style: TextStyle(
                  color: selectedScreen == 1
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                  fontSize: 12,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_offer,
                color: selectedScreen == 2
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
              ),
              title: Text(
                AppShared.appLang['Offers'],
                style: TextStyle(
                  color: selectedScreen == 2
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                  fontSize: 12,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: selectedScreen == 3
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
              ),
              title: Text(
                AppShared.appLang['Profile'],
                style: TextStyle(
                  color: selectedScreen == 3
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
          controller: _storeHomeScreenNotifiers.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            StoreHomeTabScreen(),
            !AppShared.sharedPreferencesController.getIsLogin()
                ? SignInScreen()
                : MyCartScreen(),
            !AppShared.sharedPreferencesController.getIsLogin()
                ? SignInScreen()
                : OffersPage(),
            !AppShared.sharedPreferencesController.getIsLogin()
                ? SignInScreen()
                : ProfileScreen(),
          ]),
    );
  }
}

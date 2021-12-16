import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_main_screen_notifiers/coffee_main_screen_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_main_screen_notifiers/pages_notifiers/coffee_home_screen_notifiers/coffee_home_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_main_screen/pages/coffee_home_screen/screens/coffee_home_tab_screen.dart';
import 'package:moonapp/src/views/screens/others_screens/signin_screen.dart';
import 'package:moonapp/src/views/screens/shared_pages/my_cart_screen.dart';
import 'package:moonapp/src/views/screens/shared_pages/offers_page.dart';
import 'package:moonapp/src/views/screens/shared_screens/profile_screen.dart';
import 'package:provider/provider.dart';

class CoffeeHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CoffeeHomeScreenNotifiers>(
      create: (_) => CoffeeHomeScreenNotifiers(context),
      child: HomeScreenBody(),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  CoffeeHomeScreenNotifiers _homeScreenNotifiers;
  CoffeeMainScreenNotifiers _coffeeMainScreenNotifiers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coffeeMainScreenNotifiers =
        Provider.of<CoffeeMainScreenNotifiers>(context, listen: false);
    _homeScreenNotifiers =
        Provider.of<CoffeeHomeScreenNotifiers>(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _homeScreenNotifiers.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppShared.isTablet ? 70 : 50),
        child: Selector<CoffeeHomeScreenNotifiers, int>(
          selector: (_, value) => value.selectedScreen,
          builder: (_, selectedScreen, __) => AppBar(
            backgroundColor: selectedScreen == 3
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            elevation: 0,
            title: Text(
              _homeScreenNotifiers.titles[selectedScreen],
              style: TextStyle(
                color: selectedScreen == 3 ? Colors.white : Colors.black,
                fontWeight: FontWeight.normal,
                fontSize:
                    AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 16,
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
                          size: AppShared.isTablet ? 50 : 25,
                        ),
                      ),
                    )
                  : Container(),
            ],
            leading: InkWell(
              onTap: () {
                Helpers.handleDrawer(
                  _coffeeMainScreenNotifiers.zoomDrawerController,
                );
              },
              child: Icon(
                Icons.menu,
                color: selectedScreen == 3 ? Colors.white : Colors.black,
                size: AppShared.isTablet ? 50 : 25,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Selector<CoffeeHomeScreenNotifiers, int>(
        selector: (_, value) => value.selectedScreen,
        builder: (_, selectedScreen, __) => BottomNavigationBar(
          onTap: (pageIndex) {
            _homeScreenNotifiers.pageController.jumpToPage(pageIndex);
            _homeScreenNotifiers.selectedScreen = pageIndex;
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: AppShared.isTablet ? 50 : 25,
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
                  fontSize:
                      AppShared.isTablet ? AppShared.screenUtil.setSp(35) : 12,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: AppShared.isTablet ? 50 : 25,
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
                  fontSize:
                      AppShared.isTablet ? AppShared.screenUtil.setSp(35) : 12,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_offer,
                size: AppShared.isTablet ? 50 : 25,
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
                  fontSize:
                      AppShared.isTablet ? AppShared.screenUtil.setSp(35) : 12,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: AppShared.isTablet ? 50 : 25,
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
                  fontSize:
                      AppShared.isTablet ? AppShared.screenUtil.setSp(35) : 12,
                ),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
          controller: _homeScreenNotifiers.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            CoffeeHomeTabScreen(),
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

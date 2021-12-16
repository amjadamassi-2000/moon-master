import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/beauty_section_screens_notifiers/beauty_main_screen_notifiers/beauty_main_screen_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/beauty_section_screens_notifiers/beauty_main_screen_notifiers/pages_notifiers/beauty_home_screen_notifiers/beauty_home_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/screens/customer_screens/beauty_section_screens/beauty_main_screen/pages/beauty_home_screen/screens/beauty_home_tab_page.dart';
import 'package:moonapp/src/views/screens/others_screens/signin_screen.dart';
import 'package:moonapp/src/views/screens/shared_pages/my_cart_screen.dart';
import 'package:moonapp/src/views/screens/shared_pages/offers_page.dart';
import 'package:moonapp/src/views/screens/shared_screens/profile_screen.dart';
import 'package:provider/provider.dart';

class BeautyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BeautyHomeScreenNotifiers>(
      create: (_) => BeautyHomeScreenNotifiers(context),
      child: BeautyHomeScreenBody(),
    );
  }
}

class BeautyHomeScreenBody extends StatefulWidget {
  @override
  _BeautyHomeScreenBodyState createState() => _BeautyHomeScreenBodyState();
}

class _BeautyHomeScreenBodyState extends State<BeautyHomeScreenBody> {
  BeautyHomeScreenNotifiers _homeScreenNotifiers;
  BeautyMainScreenNotifiers _beautyMainScreenNotifiers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _beautyMainScreenNotifiers =
        Provider.of<BeautyMainScreenNotifiers>(context, listen: false);
    _homeScreenNotifiers =
        Provider.of<BeautyHomeScreenNotifiers>(context, listen: false);
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
        preferredSize: Size.fromHeight(50),
        child: Selector<BeautyHomeScreenNotifiers, int>(
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
                  _beautyMainScreenNotifiers.zoomDrawerController,
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
      bottomNavigationBar: Selector<BeautyHomeScreenNotifiers, int>(
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
          controller: _homeScreenNotifiers.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            BeautyHomeTabScreen(),
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

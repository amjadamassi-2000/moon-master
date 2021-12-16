import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_main_screen_notifiers/coffee_main_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/customer_components/coffee_section_components/coffee_nav_drawer_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';

class CoffeeMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<CoffeeMainScreenNotifiers>(
        create: (_) => CoffeeMainScreenNotifiers(),
        child: CoffeeMainScreenBody(),
      ),
    );
  }
}

class CoffeeMainScreenBody extends StatefulWidget {
  @override
  _CoffeeMainScreenBodyState createState() => _CoffeeMainScreenBodyState();
}

class _CoffeeMainScreenBodyState extends State<CoffeeMainScreenBody> {
  CoffeeMainScreenNotifiers _coffeeMainScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coffeeMainScreenNotifiers =
        Provider.of<CoffeeMainScreenNotifiers>(context, listen: false);
  }


  @override
  Widget build(BuildContext context) {
    return Selector<CoffeeMainScreenNotifiers, int>(
      selector: (_, value) => value.selectedIndex,
      builder: (_, selectedIndex, __) => Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text(AppShared.appLang['TapBackAgainToLeave']),
          ),
          child: ZoomDrawer(
            isRtl:AppShared.sharedPreferencesController.getAppLang() ==
                Constants.LANG_AR
                ? true
                : false,
            // directionBool:
            //     AppShared.sharedPreferencesController.getAppLang() == 'ar'
            //         ? true
            //         : false,
            // direction:
            //     AppShared.sharedPreferencesController.getAppLang() == 'ar'
            //         ? -1
            //         : 1,
            controller: _coffeeMainScreenNotifiers.zoomDrawerController,
            menuScreen: CoffeeNavDrawerComponent(
              _coffeeMainScreenNotifiers,
              _coffeeMainScreenNotifiers.zoomDrawerController,
            ),
            mainScreen: Helpers.coffeeChangePage(
              selectedIndex,
              _coffeeMainScreenNotifiers.zoomDrawerController,
            ),
            borderRadius: 5.0,
            showShadow: true,
            angle: 0.0,
            backgroundColor: Colors.grey[200],
            slideWidth:
                AppShared.sharedPreferencesController.getAppLang() == 'ar'
                    ? MediaQuery.of(context).size.width * .60
                    : MediaQuery.of(context).size.width * .60,
            openCurve: Curves.fastOutSlowIn,
            closeCurve: Curves.bounceIn,
          ),
        ),
      ),
    );
  }
}

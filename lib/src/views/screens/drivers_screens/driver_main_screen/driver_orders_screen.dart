import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'package:moonapp/src/notifiers/screens_notifiers/driver_screen_notifiers/driver_orders_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/driver_components/driver_nav_drawer_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';

import 'package:provider/provider.dart';

class DriverOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DriverOrdersScreenNotifiers(),
      child: ParentComponent(
        child: DriverOrdersScreenBody(),
      ),
    );
  }
}

class DriverOrdersScreenBody extends StatefulWidget {
  @override
  _DriverOrdersScreenBodyState createState() => _DriverOrdersScreenBodyState();
}

class _DriverOrdersScreenBodyState extends State<DriverOrdersScreenBody> {
  ZoomDrawerController _zoomDrawerController;
  DriverOrdersScreenNotifiers _driverOrdersScreenNotifiers;

  @override
  void initState() {
    super.initState();
    _zoomDrawerController = ZoomDrawerController();

    _driverOrdersScreenNotifiers =
        Provider.of<DriverOrdersScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DriverOrdersScreenNotifiers, int>(
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

            // direction: AppShared.sharedPreferencesController.getAppLang() ==
            //         Constants.LANG_AR
            //     ? -1
            //     : 1,

            controller: _zoomDrawerController,

            menuScreen: DriverNavDrawerComponent(
              _driverOrdersScreenNotifiers,
              _zoomDrawerController,
            ),
            mainScreen:
            Helpers.driverChangePage(selectedIndex, _zoomDrawerController),
            borderRadius: 5.0,
            showShadow: true,
            angle: 0.0,
            backgroundColor: Colors.grey[200],
            slideWidth: AppShared.sharedPreferencesController.getAppLang() ==
                    Constants.LANG_AR
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

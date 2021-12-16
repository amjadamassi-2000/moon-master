import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/store_section_screens_notifiers/store_main_screen_notifiers/store_main_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/customer_components/store_section_components/store_nav_drawer_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';

class StoreMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<StoreMainScreenNotifiers>(
        create: (_) => StoreMainScreenNotifiers(),
        child: StoreMainScreenBody(),
      ),
    );
  }
}

class StoreMainScreenBody extends StatefulWidget {
  @override
  _StoreMainScreenBodyState createState() => _StoreMainScreenBodyState();
}

class _StoreMainScreenBodyState extends State<StoreMainScreenBody> {
  StoreMainScreenNotifiers _storeMainScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeMainScreenNotifiers =
        Provider.of<StoreMainScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<StoreMainScreenNotifiers, int>(
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
            controller: _storeMainScreenNotifiers.zoomDrawerController,
            menuScreen: StoreNavDrawerComponent(
              _storeMainScreenNotifiers,
              _storeMainScreenNotifiers.zoomDrawerController,
            ),
            mainScreen: Helpers.storeChangePage(
              selectedIndex,
              _storeMainScreenNotifiers.zoomDrawerController,
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

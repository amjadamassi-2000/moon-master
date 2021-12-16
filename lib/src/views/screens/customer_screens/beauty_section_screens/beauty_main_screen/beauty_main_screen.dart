import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/beauty_section_screens_notifiers/beauty_main_screen_notifiers/beauty_main_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/customer_components/beauty_section_components/beauty_nav_drawer_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';

class BeautyMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<BeautyMainScreenNotifiers>(
        create: (_) => BeautyMainScreenNotifiers(),
        child: BeautyMainScreenBody(),
      ),
    );
  }
}

class BeautyMainScreenBody extends StatefulWidget {
  @override
  _BeautyMainScreenBodyState createState() => _BeautyMainScreenBodyState();
}

class _BeautyMainScreenBodyState extends State<BeautyMainScreenBody> {
  BeautyMainScreenNotifiers _beautyMainScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _beautyMainScreenNotifiers =
        Provider.of<BeautyMainScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<BeautyMainScreenNotifiers, int>(
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
            // directionBool: AppShared.sharedPreferencesController.getAppLang() ==
            //         Constants.LANG_AR
            //     ? true
            //     : false,
            // direction: AppShared.sharedPreferencesController.getAppLang() ==
            //         Constants.LANG_AR
            //     ? -1
            //     : 1,
            controller: _beautyMainScreenNotifiers.zoomDrawerController,
            menuScreen: BeautyNavDrawerComponent(
              _beautyMainScreenNotifiers,
              _beautyMainScreenNotifiers.zoomDrawerController,
            ),
            mainScreen: Helpers.beautyChangePage(
                selectedIndex, _beautyMainScreenNotifiers.zoomDrawerController),
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

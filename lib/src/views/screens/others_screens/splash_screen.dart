import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/others_screens_notifiers/splash_screen_notifiers.dart';
import 'package:moonapp/src/services/start_up_service.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashScreenNotifiers>(
      create: (_) => SplashScreenNotifiers(context),
      child: SplashScreenBody(),
    );
  }
}

class SplashScreenBody extends StatefulWidget {
  @override
  _SplashScreenBodyState createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  SplashScreenNotifiers _splashScreenNotifiers;
  AppNotifiers _appNotifiers;
  @override


  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _splashScreenNotifiers =
        Provider.of<SplashScreenNotifiers>(context, listen: false);
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
    _splashScreenNotifiers.init();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    AppShared.screenUtil = ScreenUtil();
    StartUpService.instance.initAfterBuild(_appNotifiers, context);
    return Scaffold(
      body: Image.asset(
        '${Constants.ASSETS_IMAGES_PATH}splash.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

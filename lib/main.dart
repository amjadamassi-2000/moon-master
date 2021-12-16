import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/services/start_up_service.dart';
import 'package:moonapp/src/themes/app_themes.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StartUpService.instance.init();
  runApp(MyApp());
//  runApp(DevicePreview(builder: (_) => MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppNotifiers>(
      create: (_) => AppNotifiers(),
      child: MyAppBody(),
    );
  }
}

class MyAppBody extends StatefulWidget {
  @override
  _MyAppBodyState createState() => _MyAppBodyState();
}

class _MyAppBodyState extends State<MyAppBody> {
  AppNotifiers appNotifiers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
    appNotifiers.navigatorKey = GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AppNotifiers, bool>(
      selector: (_, value) => value.refreshApp,
      builder: (_, refreshApp, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
//      builder: DevicePreview.appBuilder,
        builder: BotToastInit(), //1. call BzotToastInit
        locale: AppShared.sharedPreferencesController.getAppLang() ==
            Constants.LANG_EN
            ? Locale('ar', 'SA')
            : Locale('en', 'US'),

        navigatorObservers: [BotToastNavigatorObserver()],
        navigatorKey: appNotifiers.navigatorKey,
        title: Constants.APP_NAME,
        darkTheme : lightTheme(),
        theme : lightTheme(),
        routes : appRoutes,
        initialRoute : Constants.SCREENS_SPLASH_SCREEN,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: IntroductionScreenBody(),
    );
  }
}

class IntroductionScreenBody extends StatefulWidget {
  @override
  _IntroductionScreenBodyState createState() => _IntroductionScreenBodyState();
}

class _IntroductionScreenBodyState extends State<IntroductionScreenBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _skip() async {
    if (AppShared.sharedPreferencesController.getIsLogin()) {
      AppShared.currentUser =
          AppShared.sharedPreferencesController.getUserData();
      AppShared.sharedPreferencesController.setIsLogin(true);
      if (AppShared.currentUser.type == Constants.USER_TYPE_CUSTOMER) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Constants.SCREEN_CHOOSE_SECTION_SCREEN, (route) => false);
      } else if (AppShared.currentUser.type == Constants.USER_TYPE_DRIVER) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Constants.SCREENS_DRIVER_ORDERS_SCREEN, (route) => false);
      } else if (AppShared.currentUser.type == Constants.USER_TYPE_WAITER)
        Navigator.pushNamedAndRemoveUntil(
            context, Constants.SCREENS_COFFEE_MAIN_SCREEN, (route) => false);
    } else
      Navigator.of(context).pushNamed(Constants.SCREEN_SIGN_IN_SCREEN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA88029),
      body: PageView.builder(
        itemCount: AppShared.introAdsResponse.ads.length,
        itemBuilder: (_, index) => InkWell(
          onTap: () {
            launch(AppShared.introAdsResponse.ads[index].link);
          },
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned.fill(
                  child: Image.network(
                AppShared.introAdsResponse.ads[index].image,
                fit: BoxFit.cover,
              )),
              Positioned(
                  top: 40,
                  left: 20,
                  child: Text(
                    AppShared.introAdsResponse.ads[index].title,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 45),
                  )),
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                          onPressed: _skip,
                          child: Text(
                            AppShared.appLang['Skip'],
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(50)
                                  : 16,
                            ),
                          )),
                      InkWell(
                        onTap: _skip,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: AppShared.isTablet ? 40 : 22,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              border:
                                  Border.all(width: 1, color: Colors.white)),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

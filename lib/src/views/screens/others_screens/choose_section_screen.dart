import 'package:flutter/material.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';

class ChooseSectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChooseSectionScreenBody(),
    );
  }
}

class ChooseSectionScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Text(
            AppShared.appLang['ChooseASection'],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
          ),
          SizedBox(
            height: 50,
          ),
          Visibility(
            visible: AppShared.settingResponse.settings.show_salon == 1,
            child: InkWell(
              onTap: () async {
                AppShared.sharedPreferencesController
                    .setSectionType(Constants.SECTION_TYPE_SALON);
                Navigator.pushNamedAndRemoveUntil(context,
                    Constants.SCREENS_BEAUTY_MAIN_SCREEN, (route) => false);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: 275,
                height: 180,
                child: Image.asset('${Constants.ASSETS_IMAGES_PATH}wooman.png'),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: const Color(0xffE5E5E5))),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Visibility(
            visible: AppShared.settingResponse.settings.show_coffe == 1,
            child: InkWell(
              onTap: () async {
                AppShared.sharedPreferencesController
                    .setSectionType(Constants.SECTION_TYPE_COFFEE);
                Navigator.pushNamedAndRemoveUntil(context,
                    Constants.SCREENS_COFFEE_MAIN_SCREEN, (route) => false);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: 275,
                height: 180,
                child: Image.asset('${Constants.ASSETS_IMAGES_PATH}coffie.png'),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: const Color(0xffE5E5E5))),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Visibility(
            visible: AppShared.settingResponse.settings.show_store == 1,
            child: InkWell(
              onTap: () async {
                AppShared.sharedPreferencesController
                    .setSectionType(Constants.SECTION_TYPE_STORE);
                Navigator.pushNamedAndRemoveUntil(context,
                    Constants.SCREENS_STORE_MAIN_SCREEN, (route) => false);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: AppStyles.defaultPadding2,
                width: 275,
//              height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: AppStyles.defaultPadding2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 5,
                        ),
                      ),
                      child: Icon(
                        Icons.shopping_cart,
                        size: 80,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      AppShared.appLang['Store'],
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: const Color(0xffE5E5E5))),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

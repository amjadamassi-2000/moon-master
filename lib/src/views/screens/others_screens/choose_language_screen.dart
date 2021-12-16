import 'package:flutter/material.dart';
import 'package:moonapp/src/notifiers/app_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/others_screens_notifiers/choose_language_screen_notifiers.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:provider/provider.dart';

class ChooseLanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChooseLanguageScreenNotifiers>(
      create: (_) => ChooseLanguageScreenNotifiers(context),
      child: ChooseLanguageScreenBody(),
    );
  }
}

class ChooseLanguageScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChooseLanguageScreenBodyState();
  }
}

class _ChooseLanguageScreenBodyState extends State<ChooseLanguageScreenBody> {
  ChooseLanguageScreenNotifiers _chooseLanguageScreenNotifiers;
  AppNotifiers _appNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appNotifiers = Provider.of<AppNotifiers>(context, listen: false);
    _chooseLanguageScreenNotifiers =
        Provider.of<ChooseLanguageScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Image.asset(
              '${Constants.ASSETS_IMAGES_PATH}moon.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 13),
            width: double.infinity,
            child: Text(
              'Choose your preferred language',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(
            height: 40,
          ),

          Selector<ChooseLanguageScreenNotifiers, String>(
            selector: (_, value) => value.selectedLanguage,
            builder: (_, selectedLanguage, __) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  _chooseLanguageScreenNotifiers.selectedLanguage = 'en';
                },
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      '${Constants.ASSETS_IMAGES_PATH}lang.png',
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('English'),
                    Spacer(),
                    selectedLanguage == 'en'
                        ? Image.asset(
                            '${Constants.ASSETS_IMAGES_PATH}check.png',
                            width: 18,
                            height: 14,
                            fit: BoxFit.cover,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Selector<ChooseLanguageScreenNotifiers, String>(
            selector: (_, value) => value.selectedLanguage,
            builder: (_, selectedLanguage, __) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  _chooseLanguageScreenNotifiers.selectedLanguage = 'ar';
                },
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      '${Constants.ASSETS_IMAGES_PATH}lang.png',
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('العربية'),
                    Spacer(),
                    selectedLanguage == 'ar'
                        ? Image.asset(
                            '${Constants.ASSETS_IMAGES_PATH}check.png',
                            width: 18,
                            height: 14,
                            fit: BoxFit.cover,
                          )
                        : Container()
                    //    Icon(Icons.check)
                  ],
                ),
              ),
            ),
          ),
//          CheckboxListTile(
//            checkColor: Colors.white,
//            value: false,
//            onChanged: (val) {},
//            title: Row(
//              children: <Widget>[
//                Image.asset(
//                  'assets/used/lang.png',
//                  height: 30,
//                  width: 30,
//                  fit: BoxFit.cover,
//                ),
//                SizedBox(
//                  width: 20,
//                ),
//                Text('العربية'),
//
//              ],
//            ),
//          ),

          SizedBox(
            height: 150,
          ),
          Selector<ChooseLanguageScreenNotifiers, bool>(
            selector: (_, value) => value.isLoading,
            builder: (_, isLoading, __) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: isLoading
                      ? null
                      : () async {
                          await _chooseLanguageScreenNotifiers.onLangChose();
                          _appNotifiers.refreshApp = !_appNotifiers.refreshApp;
                        },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                            width: 1, color: Theme.of(context).primaryColor)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                isLoading ? CircularProgressIndicator() : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

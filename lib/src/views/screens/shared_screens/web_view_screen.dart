import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_screens_notifiers/web_view_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/components/others_components/custom_btn_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';

class WebViewScreen extends StatelessWidget {
  String paymentLink;
  @override
  Widget build(BuildContext context) {
    paymentLink = ModalRoute.of(context).settings.arguments;
    return ParentComponent(
      child: ChangeNotifierProvider<WebViewScreenNotifiers>(
        create: (_) => WebViewScreenNotifiers(context),
        child: WebViewScreenBody(paymentLink),
      ),
    );
  }
}

class WebViewScreenBody extends StatefulWidget {
  final paymentLink;

  WebViewScreenBody(this.paymentLink);

  @override
  _WebViewScreenBodyState createState() => _WebViewScreenBodyState();
}

class _WebViewScreenBodyState extends State<WebViewScreenBody> {
  WebViewScreenNotifiers _webViewScreenNotifiers;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webViewScreenNotifiers =
        Provider.of<WebViewScreenNotifiers>(context, listen: false);
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
      String paymentStatus = url.substring(url.lastIndexOf('/') + 1);
      print(paymentStatus);
      _webViewScreenNotifiers.paymentStatus = paymentStatus;
      if (paymentStatus == 'successPayment') {
        print('Payment done successfully');
        _webViewScreenNotifiers.isBtnVisible = true;
      } else if (paymentStatus == 'failPayment') {
        print('Payment failed !!');
        _webViewScreenNotifiers.isBtnVisible = true;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterWebviewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.paymentLink ?? 'https://www.google.com',
      appBar: AppBar(
        title: Text(AppShared.appLang['Payment']),
      ),
      initialChild: Center(
        child: LoadingComponent(),
      ),
      bottomNavigationBar: Selector<WebViewScreenNotifiers, bool>(
        selector: (_, value) => value.isBtnVisible,
        builder: (_, isBtnVisible, __) => isBtnVisible
            ? Container(
                height: 70,
                child: CustomBtnComponent(
                  text:
                      _webViewScreenNotifiers.paymentStatus == 'successPayment'
                          ? AppShared.appLang['Continue']
                          : AppShared.appLang['TryAgain'],
                  onTap: (startLoading, stopLoading, btnState) {
                    if (_webViewScreenNotifiers.paymentStatus ==
                        'successPayment') {
                      Navigator.pop(context);
                    }
                    if (_webViewScreenNotifiers.paymentStatus ==
                        'successPayment') {
                      if (AppShared.sharedPreferencesController
                              .getSectionType() ==
                          Constants.SECTION_TYPE_COFFEE)
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Constants.SCREENS_COFFEE_MAIN_SCREEN,
                            (route) => false);
                      else if (AppShared.sharedPreferencesController
                              .getSectionType() ==
                          Constants.SECTION_TYPE_SALON)
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Constants.SCREENS_BEAUTY_MAIN_SCREEN,
                            (route) => false);
                      else if (AppShared.sharedPreferencesController
                              .getSectionType() ==
                          Constants.SECTION_TYPE_STORE)
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Constants.SCREENS_STORE_MAIN_SCREEN,
                            (route) => false);
                    } else if (_webViewScreenNotifiers.paymentStatus ==
                        'failPayment') {
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            : Container(
                height: 0,
              ),
      ),
    );
  }
}

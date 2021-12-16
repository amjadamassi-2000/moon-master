import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_pages_notifiers/about_us_page_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';

class AboutUsPage extends StatelessWidget {
  final ZoomDrawerController _zoomDrawerController;

  AboutUsPage(this._zoomDrawerController);
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider(
        create: (_) => AboutUsPageNotifiers(context),
        child: AboutUsPageBody(_zoomDrawerController),
      ),
    );
  }
}

class AboutUsPageBody extends StatefulWidget {
  final ZoomDrawerController _zoomDrawerController;

  AboutUsPageBody(this._zoomDrawerController);
  @override
  _AboutUsPageBodyState createState() => _AboutUsPageBodyState();
}

class _AboutUsPageBodyState extends State<AboutUsPageBody> {
  AboutUsPageNotifiers _aboutUsPageNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _aboutUsPageNotifiers =
        Provider.of<AboutUsPageNotifiers>(context, listen: false);
    _aboutUsPageNotifiers.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Text(
          AppShared.appLang['AboutUs'],
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Helpers.handleDrawer(widget._zoomDrawerController);
          },
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      body: Selector<AboutUsPageNotifiers, bool>(
        selector: (_, value) => value.isLoading,
        builder: (_, isLoading, __) => isLoading
            ? Container(
                color: Colors.white10,
                child: Center(
                  child: LoadingComponent(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  color: Colors.white10,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Image.network(
                          _aboutUsPageNotifiers.staticPagesResponse.page.image,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        color: const Color(0xffF7F0DD),
                        child: Text('Who is the Mon application ?'),
                        padding: AppStyles.defaultPadding2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        child: Html(
                          data: _aboutUsPageNotifiers
                              .staticPagesResponse.page.description,
                        ),
                        padding: AppStyles.defaultPadding2,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_screens_notifiers/faq_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/info_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatelessWidget {
  final ZoomDrawerController _zoomDrawerController;

  FaqScreen(this._zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FaqScreenNotifiers(context),
      child: FaqScreenBody(_zoomDrawerController),
    );
  }
}

class FaqScreenBody extends StatefulWidget {
  final ZoomDrawerController _zoomDrawerController;

  FaqScreenBody(this._zoomDrawerController);

  @override
  _FaqScreenBodyState createState() => _FaqScreenBodyState();
}

class _FaqScreenBodyState extends State<FaqScreenBody> {
  FaqScreenNotifiers faqScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    faqScreenNotifiers =
        Provider.of<FaqScreenNotifiers>(context, listen: false);
    faqScreenNotifiers.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Text(
          AppShared.appLang['Q&F'],
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 16,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Helpers.handleDrawer(widget._zoomDrawerController);
          },
          child: Icon(
            Icons.menu,
            color: Colors.black,
            size: AppShared.isTablet ? 50 : 25,
          ),
        ),
      ),
      body: Container(
        padding: AppStyles.defaultPadding3,
        child: Selector<FaqScreenNotifiers, bool>(
          selector: (_, value) => value.isLoading,
          builder: (_, isLoading, __) => isLoading
              ? Center(child: LoadingComponent())
              : faqScreenNotifiers.isError
                  ? Center(
                      child: InfoComponent(
                        title: AppShared.appLang['SomethingWentWrong'],
                        infoComponentType: InfoComponentType
                            .INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS,
                        buttonTitle: AppShared.appLang['TryAgain'],
                        buttonOnTap: () {
                          faqScreenNotifiers.init(isInit: false);
                        },
                      ),
                    )
                  : faqScreenNotifiers.faqResponse.questions.isEmpty
                      ? Center(
                          child: Text('No Questions found !'),
                        )
                      : ListView.builder(
                          itemCount:
                              faqScreenNotifiers.faqResponse.questions.length,
                          itemBuilder: (_, index) => Column(
                            children: <Widget>[
                              Container(
                                color: const Color(0xffF7F0DD),
                                child: ExpansionTile(
                                  title: Text(
                                    faqScreenNotifiers
                                        .faqResponse.questions[index].question,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AppShared.isTablet
                                          ? AppShared.screenUtil.setSp(35)
                                          : 16,
                                    ),
                                  ),
                                  children: <Widget>[
                                    Container(
                                      padding: AppStyles.defaultPadding2,
                                      child: Text(
                                        faqScreenNotifiers.faqResponse
                                            .questions[index].answer,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: AppShared.isTablet
                                              ? AppShared.screenUtil.setSp(30)
                                              : 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
        ),
      ),
    );
  }
}

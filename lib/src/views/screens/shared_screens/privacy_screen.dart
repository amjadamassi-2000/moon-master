import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_screens_notifiers/privacy_policy_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<PrivacyPolicyScreenNotifiers>(
        create: (_) => PrivacyPolicyScreenNotifiers(context),
        child: PrivacyScreenBody(),
      ),
    );
  }
}

class PrivacyScreenBody extends StatefulWidget {
  @override
  _PrivacyScreenBodyState createState() => _PrivacyScreenBodyState();
}

class _PrivacyScreenBodyState extends State<PrivacyScreenBody> {
  PrivacyPolicyScreenNotifiers _privacyPolicyScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _privacyPolicyScreenNotifiers =
        Provider.of<PrivacyPolicyScreenNotifiers>(context, listen: false);
    _privacyPolicyScreenNotifiers.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Text(
          AppShared.appLang['PrivacyPolicy'],
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Selector<PrivacyPolicyScreenNotifiers, bool>(
        selector: (_, value) => value.isLoading,
        builder: (_, isLoading, __) => isLoading
            ? Container(
                child: Center(
                  child: LoadingComponent(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: AppStyles.defaultPadding3,
                      color: const Color(0xffF7F0DD),
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.network(
                          _privacyPolicyScreenNotifiers
                              .staticPagesResponse.page.image,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: Html(
                        data: _privacyPolicyScreenNotifiers
                            .staticPagesResponse.page.description,
                      ),
                      padding: AppStyles.defaultPadding2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '• Step 1 : ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Contrary to popular belief, Lorem Ipsum is nghhhot simpte. It has roots in a piece of classical Latin literature from 45 BC.',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      padding: AppStyles.defaultPadding2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '• Step 2 : ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Contrary to popular belief, Lorem Ipsum is nghhhot simpte. It has roots in a piece of classical Latin literature from 45 BC.',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      padding: AppStyles.defaultPadding2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '• Step 3 : ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Contrary to popular belief, Lorem Ipsum is nghhhot simpte. It has roots in a piece of classical Latin literature from 45 BC.',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      padding: AppStyles.defaultPadding2,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

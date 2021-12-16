import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_main_screen_notifiers/pages_notifiers/coffee_notifications_page_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/info_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  final ZoomDrawerController _zoomDrawerController;

  NotificationsPage(this._zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CoffeeNotificationsPageNotifiers>(
      create: (_) => CoffeeNotificationsPageNotifiers(context),
      child: NotificationsPageBody(_zoomDrawerController),
    );
  }
}

class NotificationsPageBody extends StatefulWidget {
  final ZoomDrawerController _zoomDrawerController;

  NotificationsPageBody(this._zoomDrawerController);

  @override
  _NotificationsPageBodyState createState() => _NotificationsPageBodyState();
}

class _NotificationsPageBodyState extends State<NotificationsPageBody> {
  CoffeeNotificationsPageNotifiers _coffeeNotificationsPageNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coffeeNotificationsPageNotifiers =
        Provider.of<CoffeeNotificationsPageNotifiers>(context, listen: false);
    _coffeeNotificationsPageNotifiers.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Text(
          AppShared.appLang['Notifications'],
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize:
                  AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 16),
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
      body: Selector<CoffeeNotificationsPageNotifiers, bool>(
        selector: (_, value) => value.isLoading,
        builder: (_, isLoading, __) => isLoading
            ? Container(
                color: Colors.white10,
                child: Center(
                  child: LoadingComponent(),
                ),
              )
            : _coffeeNotificationsPageNotifiers.isError
                ? Center(
                    child: InfoComponent(
                      title: AppShared.appLang['SomethingWentWrong'],
                      infoComponentType: InfoComponentType
                          .INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS,
                      buttonTitle: AppShared.appLang['TryAgain'],
                      buttonOnTap: () {
                        _coffeeNotificationsPageNotifiers.init(isInit: false);
                      },
                    ),
                  )
                : _coffeeNotificationsPageNotifiers
                        .notificationsResponse.data.isEmpty
                    ? Container(
                        color: Colors.white10,
                        child: Center(
                          child: InfoComponent(
                            infoComponentType: InfoComponentType
                                .INFO_COMPONENT_TYPE_NO_NOTIFICATIONS,
                            title: AppShared.appLang['NoNotifications'],
                            description: '',
                          ),
                        ),
                      )
                    : Container(
                        padding: AppStyles.defaultPadding3,
                        color: Colors.white10,
                        child: ListView.builder(
                          itemCount: _coffeeNotificationsPageNotifiers
                              .notificationsResponse.data.length,
                          itemBuilder: (_, index) => ListTile(
                            leading: Stack(
                              children: <Widget>[
//                                Image.asset(
//                                  '${Constants.ASSETS_IMAGES_PATH}notification.png',
//                                  width: AppShared.isTablet ? 70 : 60,
//                                  height: AppShared.isTablet ? 90 : 60,
//                                  fit: BoxFit.cover,
//                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: SvgPicture.asset(
                                    '${Constants.ASSETS_IMAGES_PATH}notifications.svg',
                                  ),
                                ),
                                Positioned.fill(
                                    child: Container(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                  ),
                                ))
                              ],
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _coffeeNotificationsPageNotifiers
                                      .notificationsResponse
                                      .data[index]
                                      .message,
                                  style: TextStyle(
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(35)
                                        : 15,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  Helpers.formatDate(
                                      _coffeeNotificationsPageNotifiers
                                          .notificationsResponse
                                          .data[index]
                                          .createdAt),
                                  style: TextStyle(
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(30)
                                        : 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
      ),
    );
  }
}

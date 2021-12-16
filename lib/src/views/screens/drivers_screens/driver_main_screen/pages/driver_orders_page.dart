import 'package:flutter/material.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/driver_screen_notifiers/screens_notifiers/driver_orders_page_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/info_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';

class DriverOrdersPage extends StatelessWidget {
  final ZoomDrawerController _zoomDrawerController;

  DriverOrdersPage(this._zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<DriverOrdersPageNotifiers>(
        create: (_) => DriverOrdersPageNotifiers(context),
        child: DriverOrdersPageBody(_zoomDrawerController),
      ),
    );
  }
}

class DriverOrdersPageBody extends StatefulWidget {
  final ZoomDrawerController _zoomDrawerController;

  DriverOrdersPageBody(this._zoomDrawerController);

  @override
  _DriverOrdersPageBodyState createState() => _DriverOrdersPageBodyState();
}

class _DriverOrdersPageBodyState extends State<DriverOrdersPageBody> {
  DriverOrdersPageNotifiers _driverOrdersPageNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _driverOrdersPageNotifiers =
        Provider.of<DriverOrdersPageNotifiers>(context, listen: false);
    _driverOrdersPageNotifiers.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Text(
          AppShared.appLang['Orders'],
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
      body: Selector<DriverOrdersPageNotifiers, bool>(
        selector: (_, value) => value.isLoading,
        builder: (_, isLoading, __) => isLoading
            ? Center(
                child: LoadingComponent(),
              )
            : _driverOrdersPageNotifiers.isError
                ? Center(
                    child: InfoComponent(
                      title: AppShared.appLang['SomethingWentWrong'],
                      infoComponentType: InfoComponentType
                          .INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS,
                      buttonTitle: AppShared.appLang['TryAgain'],
                      buttonOnTap: () {
                        _driverOrdersPageNotifiers.getOrders(isInit: false);
                      },
                    ),
                  )
                : _driverOrdersPageNotifiers.ordersResponse.orders.data.isEmpty
                    ? Center(
                        child: Text(AppShared.appLang['NoOrders']),
                      )
                    : Container(
                        padding: AppStyles.defaultPadding3,
                        child: RefreshIndicator(
                          onRefresh:()async{
                            _driverOrdersPageNotifiers.page = 1 ;
                            return await _driverOrdersPageNotifiers.getOrders(isInit:false);
                          } ,
                          child: ListView(
                            children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                controller:
                                _driverOrdersPageNotifiers.ordersScrollController,
                                itemCount: _driverOrdersPageNotifiers
                                    .ordersResponse.orders.data.length +
                                    1,
                                itemBuilder: (_, index) => index ==
                                    _driverOrdersPageNotifiers
                                        .ordersResponse.orders.data.length
                                    ? Selector<DriverOrdersPageNotifiers, bool>(
                                  selector: (_, value) => value.isPagingLoading,
                                  builder: (_, isPagingLoading, __) =>
                                  isPagingLoading
                                      ? Center(
                                    child: Container(
                                        height: 100,
                                        child: LoadingComponent()),
                                  )
                                      : Container(),
                                )
                                    : Column(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            Constants
                                                .SCREENS_COFFEE_PRODUCTS_ORDER_DETAILS_SCREEN,
                                            arguments:
                                            _driverOrdersPageNotifiers
                                                .ordersResponse
                                                .orders
                                                .data[index]);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 100,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey[300]),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        child: ListTile(
                                          leading: Container(
                                            height: 150,
                                            child: Image.asset(
                                              '${Constants.ASSETS_IMAGES_PATH}order.png',
                                            ),
                                          ),
                                          title: Row(
                                            children: <Widget>[
                                              Flexible(
                                                flex: 1,
                                                fit: FlexFit.tight,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      Helpers.formatDate(
                                                          _driverOrdersPageNotifiers
                                                              .ordersResponse
                                                              .orders
                                                              .data[index]
                                                              .createdAt),
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: AppShared
                                                            .screenUtil
                                                            .setSp(35),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${AppShared.appLang['OrderId']} : ${_driverOrdersPageNotifiers.ordersResponse.orders.data[index].id}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: AppShared
                                                            .screenUtil
                                                            .setSp(35),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${AppShared.appLang['Total']} : ${_driverOrdersPageNotifiers.ordersResponse.orders.data[index].total} SAR',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: AppShared
                                                            .screenUtil
                                                            .setSp(30),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                flex: 1,
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Flexible(
                                                          fit: FlexFit.tight,
                                                          flex: 3,
                                                          child:
                                                          DropdownButtonFormField(
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                              Colors.black,
                                                              fontFamily: Helpers
                                                                  .changeAppFont(),
                                                            ),
                                                            value: _driverOrdersPageNotifiers
                                                                .ordersResponse
                                                                .orders
                                                                .data[index]
                                                                .status,
                                                            items: _driverOrdersPageNotifiers
                                                                .orderStatuses
                                                                .map((e) =>
                                                                DropdownMenuItem(
                                                                  child:
                                                                  Text(
                                                                      e),
                                                                  value: _driverOrdersPageNotifiers
                                                                      .orderStatuses
                                                                      .indexWhere((element) =>
                                                                  element ==
                                                                      e),
                                                                ))
                                                                .toList(),
                                                            onChanged: (value) {
                                                              _driverOrdersPageNotifiers
                                                                  .ordersResponse
                                                                  .orders
                                                                  .data[index]
                                                                  .status = value;
                                                              _driverOrdersPageNotifiers
                                                                  .changeStatus(
                                                                  _driverOrdersPageNotifiers
                                                                      .ordersResponse
                                                                      .orders
                                                                      .data[
                                                                  index]
                                                                      .id,
                                                                  value);
                                                            },
                                                            icon: Container(),
                                                            decoration:
                                                            InputDecoration(
                                                              border:
                                                              InputBorder
                                                                  .none,
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: AppShared
                                                                  .screenUtil
                                                                  .setSp(50),
                                                              color:
                                                              Colors.white,
                                                            ),
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Theme.of(
                                                                  context)
                                                                  .primaryColor,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .all(
                                                                Radius.circular(
                                                                    5),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_pages_notifiers/orders_page_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/info_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class OrdersPage extends StatelessWidget {
  final ZoomDrawerController _zoomDrawerController;

  OrdersPage(this._zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrdersPageNotifiers(context),
      child: OrdersPageBody(_zoomDrawerController),
    );
  }
}

class OrdersPageBody extends StatefulWidget {
  final ZoomDrawerController _zoomDrawerController;

  OrdersPageBody(this._zoomDrawerController);

  @override
  _OrdersPageBodyState createState() => _OrdersPageBodyState();
}

class _OrdersPageBodyState extends State<OrdersPageBody> {
  OrdersPageNotifiers _coffeeOrdersPageNotifiers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coffeeOrdersPageNotifiers =
        Provider.of<OrdersPageNotifiers>(context, listen: false);
    _coffeeOrdersPageNotifiers.getOrders();
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
      body: Selector<OrdersPageNotifiers, Tuple2<bool, bool>>(
        selector: (_, value) => Tuple2(value.isLoading, value.isNewDataLoaded),
        builder: (_, tuple, __) => tuple.item1
            ? Center(
                child: LoadingComponent(),
              )
            : _coffeeOrdersPageNotifiers.isError
                ? Center(
                    child: InfoComponent(
                      title: AppShared.appLang['SomethingWentWrong'],
                      infoComponentType: InfoComponentType
                          .INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS,
                      buttonTitle: AppShared.appLang['TryAgain'],
                      buttonOnTap: () {
                        _coffeeOrdersPageNotifiers.getOrders(isInit: false);
                      },
                    ),
                  )
                : _coffeeOrdersPageNotifiers.ordersResponse.orders.data.isEmpty
                    ? Center(
                        child: Text(AppShared.appLang['NoOrders']),
                      )
                    : Container(
                        padding: AppStyles.defaultPadding3,
                        child: RefreshIndicator(
                          onRefresh:()async{
                            _coffeeOrdersPageNotifiers.page = 1 ;
                            return await _coffeeOrdersPageNotifiers.getOrders(isInit: false);
                          } ,
                          child: ListView.builder(
                            controller:
                                _coffeeOrdersPageNotifiers.ordersScrollController,
                            itemCount: _coffeeOrdersPageNotifiers
                                    .ordersResponse.orders.data.length +
                                1,
                            itemBuilder: (_, index) => index ==
                                    _coffeeOrdersPageNotifiers
                                        .ordersResponse.orders.data.length
                                ? Selector<OrdersPageNotifiers, bool>(
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
                                          if (AppShared
                                                  .sharedPreferencesController
                                                  .getSectionType() ==
                                              Constants.SECTION_TYPE_COFFEE)
                                            Navigator.pushNamed(
                                                context,
                                                Constants
                                                    .SCREENS_COFFEE_PRODUCTS_ORDER_DETAILS_SCREEN,
                                                arguments:
                                                    _coffeeOrdersPageNotifiers
                                                        .ordersResponse
                                                        .orders
                                                        .data[index]);
                                          else if (AppShared
                                                  .sharedPreferencesController
                                                  .getSectionType() ==
                                              Constants.SECTION_TYPE_STORE)
                                            Navigator.pushNamed(
                                                context,
                                                Constants
                                                    .SCREENS_STORE_PRODUCTS_ORDER_DETAILS_SCREEN,
                                                arguments:
                                                    _coffeeOrdersPageNotifiers
                                                        .ordersResponse
                                                        .orders
                                                        .data[index]);
                                          else
                                            Navigator.pushNamed(
                                                context,
                                                Constants
                                                    .SCREENS_BEAUTY_PRODUCTS_ORDER_DETAILS_SCREEN,
                                                arguments:
                                                    _coffeeOrdersPageNotifiers
                                                        .ordersResponse
                                                        .orders
                                                        .data[index]);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: AppShared.isTablet ? 180 : 100,
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
                                              height: 100,
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
                                                            _coffeeOrdersPageNotifiers
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
                                                        '${AppShared.appLang['OrderId']} : ${_coffeeOrdersPageNotifiers.ordersResponse.orders.data[index].id}',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: AppShared
                                                              .screenUtil
                                                              .setSp(35),
                                                        ),
                                                      ),
                                                      Text(
                                                        '${AppShared.appLang['Total']} : ${_coffeeOrdersPageNotifiers.ordersResponse.orders.data[index].total} SAR',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: AppShared
                                                              .screenUtil
                                                              .setSp(30),
                                                        ),
                                                      )
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
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 12),
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: Text(
                                                              Helpers.getOrderStatusName(
                                                                  _coffeeOrdersPageNotifiers
                                                                      .ordersResponse
                                                                      .orders
                                                                      .data[index]
                                                                      .status),
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontSize: AppShared
                                                                    .screenUtil
                                                                    .setSp(35),
                                                              ),
                                                            ),







                                                          ),
                                                        ),
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
                                                                    AppShared
                                                                            .isTablet
                                                                        ? 15
                                                                        : 5,
                                                                  ),
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
                        ),
                      ),
      ),
    );
  }
}

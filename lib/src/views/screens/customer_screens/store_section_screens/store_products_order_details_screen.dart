import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:moonapp/src/models/api_models/sub_models/order.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';

class StoreProductsOrderDetailsScreen extends StatelessWidget {
  Order order;
  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context).settings.arguments;
    return ParentComponent(
      child: StoreProductsOrderDetailsScreenBody(order),
    );
  }
}

class StoreProductsOrderDetailsScreenBody extends StatefulWidget {
  final Order order;

  StoreProductsOrderDetailsScreenBody(this.order);

  @override
  _StoreProductsOrderDetailsScreenBodyState createState() =>
      _StoreProductsOrderDetailsScreenBodyState();
}

class _StoreProductsOrderDetailsScreenBodyState
    extends State<StoreProductsOrderDetailsScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Text(
          '${AppShared.appLang['OrderDetails']}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Container(
        padding: AppStyles.defaultPadding3,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: AppStyles.defaultPadding2,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Positioned.fill(
                      child: Container(
                    padding: AppStyles.defaultPadding2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            Helpers.getOrderStatusName(widget.order.status),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            Helpers.formatDate(widget.order.createdAt),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            '${AppShared.appLang['OrderId']} : ${widget.order.id}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            '${AppShared.appLang['PaymentMethod']} : ${widget.order.paymentMethod == 1 ? 'Cash' : 'Online'}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            '${widget.order.total} ${AppShared.appLang['SAR']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              widget.order.deliveryMethod == 2
                  ? Container()
                  : Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          color: const Color(0xffF7F0DD),
                          child: Row(
                            children: <Widget>[
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  '${AppShared.appLang['DeliveryTime']} :',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}time_filled.svg',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            widget.order.deliveryTime,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          color: const Color(0xffF7F0DD),
                          child: Row(
                            children: <Widget>[
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  '${AppShared.appLang['DeliveryAddress']} :',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      Constants.SCREENS_GOOGLE_MAP_SCREEN,
                                      arguments: [
                                        LocationData.fromMap({
                                          'latitude': widget.order.latitude,
                                          'longitude': widget.order.longitude,
                                        }),
                                        false
                                      ]);
                                },
                                child: SvgPicture.asset(
                                  '${Constants.ASSETS_IMAGES_PATH}map.svg',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                  '${Constants.ASSETS_IMAGES_PATH}location.svg'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            widget.order.address,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
//              Container(
//                padding: const EdgeInsets.symmetric(
//                  vertical: 5,
//                ),
//                color: const Color(0xffF7F0DD),
//                child: Row(
//                  children: <Widget>[
//                    Container(
//                      alignment: AlignmentDirectional.centerStart,
//                      child: Text(
//                        'Table number :',
//                        style: TextStyle(
//                          color: Theme.of(context).primaryColor,
//                          fontSize: 18,
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 15,
//              ),
//              Container(
//                alignment: AlignmentDirectional.centerStart,
//                child: Text(
//                  widget.order.tableNumber,
//                  style: TextStyle(
//                    color: Colors.black,
//                    fontSize: 15,
//                  ),
//                ),
//              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                color: const Color(0xffF7F0DD),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        '${AppShared.appLang['Details']} :',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  widget.order.details,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
                color: const Color(0xffF7F0DD),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        '${AppShared.appLang['ContactInfo']} :',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      '${Constants.ASSETS_IMAGES_PATH}contact_form.svg',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    '${Constants.ASSETS_IMAGES_PATH}person.svg',
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      '${AppShared.appLang['CustomerName']} :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.order.customerName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    '${Constants.ASSETS_IMAGES_PATH}location.svg',
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      '${AppShared.appLang['City']} :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    Helpers.getCityById(widget.order.cityId).name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    '${Constants.ASSETS_IMAGES_PATH}phone.png',
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "${AppShared.appLang['MobileNumber']} :",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${widget.order.mobile}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                color: const Color(0xffF7F0DD),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        '${AppShared.appLang['Products']} :',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      '${Constants.ASSETS_IMAGES_PATH}products.svg',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListView.builder(
                itemCount: widget.order.products.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => Column(
                  children: <Widget>[
                    Container(
                      padding: AppStyles.defaultPadding1,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            widget.order.products[index].product.image,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.order.products[index].product.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '${AppShared.appLang['Quantity']} : ${widget.order.products[index].quantity}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  '${AppShared.appLang['Total']} : ${widget.order.products[index].product.price} ${AppShared.appLang['SAR']}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

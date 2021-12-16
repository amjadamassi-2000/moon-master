import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:moonapp/src/models/api_models/shared_models/orders_response.dart';
import 'package:moonapp/src/models/api_models/sub_models/order.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_checkout_screen_notifiers.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_main_screen_notifiers/pages_notifiers/coffee_home_screen_notifiers/screens_notifiers/coffee_my_cart_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_checkout_screen.dart';

class CoffeeProductsOrderDetailsScreen extends StatelessWidget {
  Order order;

  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context).settings.arguments;
    return ParentComponent(
      child: CoffeeProductsOrderDetailsScreenBody(order),
    );
  }
}

class CoffeeProductsOrderDetailsScreenBody extends StatefulWidget {
  final Order order;

  //final  Orders orders;

  CoffeeProductsOrderDetailsScreenBody(this.order);

  @override
  _CoffeeProductsOrderDetailsScreenBodyState createState() =>
      _CoffeeProductsOrderDetailsScreenBodyState();
}

class _CoffeeProductsOrderDetailsScreenBodyState
    extends State<CoffeeProductsOrderDetailsScreenBody> {
  CoffeeCheckoutScreenNotifiers _coffeeCheckoutScreenNotifiers;
  CoffeeMyCartScreenNotifiers _coffeeMyCartScreenNotifiers;

  OrdersResponse _ordersResponse;

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
            fontSize: AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 16,
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
                    height: AppShared.isTablet
                        ? MediaQuery.of(context).size.height * 0.3
                        : 220,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Positioned.fill(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            Helpers.getOrderStatusName(widget.order.status),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(40)
                                  : 16,
                            ),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            Helpers.formatDate(widget.order.createdAt),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(45)
                                  : 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),

                        //OrderId
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            '${AppShared.appLang['OrderId']} : ${widget.order.id}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(60)
                                  : 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        //PaymentMethod
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            '${AppShared.appLang['PaymentMethod']} : ${widget.order.paymentMethod == 1 ? AppShared.appLang['Cash'] : AppShared.appLang['Online']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(40)
                                  : 16,
                            ),
                          ),
                        ),
                        //Sub Total
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                'Sub Total : ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(40)
                                      : 16,
                                ),
                              ),

                              Text(
                                '${widget.order.totalProducts} ${AppShared.appLang['SAR']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(40)
                                      : 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Total Additions
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                'Total Additions : ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(40)
                                      : 16,
                                ),
                              ),

                              Text(
                                '${widget.order.totalAdditions} ${AppShared.appLang['SAR']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(40)
                                      : 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Delivery Cost
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                'Delivery Cost :',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(40)
                                      : 16,
                                ),
                              ),

                              Text(
                                ' ${widget.order.deliveryCost} ${AppShared.appLang['SAR']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(40)
                                      : 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                'Tax :  ${widget.order.taxRate}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(40)
                                      : 16,
                                ),
                              ),

                              Text(
                                ' ${widget.order.taxAmount} ${AppShared.appLang['SAR']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(40)
                                      : 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Final Total : ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(60)
                                      : 22,
                                ),
                              ),
                              //  SizedBox(width: 80,),
                              Text(
                                '${widget.order.total} ${AppShared.appLang['SAR']}',
                                style: TextStyle(
                                  textBaseline: TextBaseline.ideographic,
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(60)
                                      : 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              widget.order.deliveryMethod == 2
                  ? Container()
                  : Column(
                      children: <Widget>[
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
                                  '${AppShared.appLang['DeliveryTime']} :',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(50)
                                        : 18,
                                  ),
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}time_filled.svg',
                                width: AppShared.isTablet ? 40 : 20,
                                height: AppShared.isTablet ? 40 : 20,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            widget.order.deliveryTime ?? 'No Time',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(35)
                                  : 15,
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
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(50)
                                        : 18,
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
                                    width: AppShared.isTablet ? 35 : 30,
                                    height: AppShared.isTablet ? 30 : 20,
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}location.svg',
                                width: AppShared.isTablet ? 25 : 15,
                                height: AppShared.isTablet ? 35 : 22,
                                fit: BoxFit.cover,
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
                            widget.order.address,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(35)
                                  : 13,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
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
                        '${AppShared.appLang['TableNumber']} :',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(50)
                              : 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              widget.order.tableNumber == null
                  ? Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        " ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(40)
                              : 15,
                        ),
                      ),
                    )
                  : Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        widget.order.tableNumber,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(40)
                              : 15,
                        ),
                      ),
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
                        '${AppShared.appLang['Details']} :',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(50)
                              : 18,
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
                    fontSize: AppShared.isTablet
                        ? AppShared.screenUtil.setSp(40)
                        : 15,
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
                        '${AppShared.appLang['ContactInfo']}  :',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(50)
                              : 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      '${Constants.ASSETS_IMAGES_PATH}contact_form.svg',
                      width: AppShared.isTablet ? 35 : 20,
                      height: AppShared.isTablet ? 35 : 20,
                      fit: BoxFit.cover,
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
                    width: AppShared.isTablet ? 35 : 20,
                    height: AppShared.isTablet ? 35 : 20,
                    fit: BoxFit.cover,
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
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(40)
                            : 16,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.order.customerName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppShared.isTablet
                          ? AppShared.screenUtil.setSp(50)
                          : 18,
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
                    width: AppShared.isTablet ? 25 : 20,
                    height: AppShared.isTablet ? 35 : 20,
                    fit: BoxFit.cover,
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
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(40)
                            : 16,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    Helpers.getCityById(widget.order.cityId).name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppShared.isTablet
                          ? AppShared.screenUtil.setSp(50)
                          : 18,
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
                    '${Constants.ASSETS_IMAGES_PATH}phone.svg',
                    width: AppShared.isTablet ? 35 : 20,
                    height: AppShared.isTablet ? 35 : 20,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      '${AppShared.appLang['MobileNumber']} :',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(40)
                            : 16,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${widget.order.mobile}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppShared.isTablet
                          ? AppShared.screenUtil.setSp(50)
                          : 18,
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
                  horizontal: 5,
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
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(50)
                              : 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      '${Constants.ASSETS_IMAGES_PATH}products.svg',
                      width: AppShared.isTablet ? 35 : 20,
                      height: AppShared.isTablet ? 35 : 20,
                      fit: BoxFit.cover,
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
                            height: AppShared.isTablet ? 150 : 70,
                            width: AppShared.isTablet ? 150 : 70,
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
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(50)
                                        : 18,
                                  ),
                                ),
                                Text(
                                  '${AppShared.appLang['Quantity']} : ${widget.order.products[index].quantity}',
                                  style: TextStyle(
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(50)
                                        : 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  '${AppShared.appLang['Total']} : ${widget.order.products[index].product.price} ${AppShared.appLang['SAR']}',
                                  style: TextStyle(
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(50)
                                        : 18,
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

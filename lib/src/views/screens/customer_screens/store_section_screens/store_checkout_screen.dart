import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/cart_resposne.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/store_section_screens_notifiers/store_checkout_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/custom_btn_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';

class StoreCheckoutScreen extends StatelessWidget {
  List<Cart> products;
  @override
  Widget build(BuildContext context) {
    products = ModalRoute.of(context).settings.arguments;
    return ParentComponent(
      child: ChangeNotifierProvider<StoreCheckoutScreenNotifiers>(
        create: (_) => StoreCheckoutScreenNotifiers(context, products),
        child: StoreCheckoutScreenBody(),
      ),
    );
  }
}

class StoreCheckoutScreenBody extends StatefulWidget {
  @override
  _StoreCheckoutScreenBodyState createState() =>
      _StoreCheckoutScreenBodyState();
}

class _StoreCheckoutScreenBodyState extends State<StoreCheckoutScreenBody> {
  StoreCheckoutScreenNotifiers _storeCheckoutScreenNotifiers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeCheckoutScreenNotifiers =
        Provider.of<StoreCheckoutScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          '${AppShared.appLang['CheckOut']}',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: AppStyles.defaultPadding3,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
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
                itemCount: _storeCheckoutScreenNotifiers.products.length,
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
                            _storeCheckoutScreenNotifiers
                                .products[index].product.image,
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
                                  _storeCheckoutScreenNotifiers
                                      .products[index].product.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${AppShared.appLang['Quantity']} :   ${_storeCheckoutScreenNotifiers.products[index].quantity}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '${AppShared.appLang['Total']} : ${_storeCheckoutScreenNotifiers.calculateProductPrice(_storeCheckoutScreenNotifiers.products[index])} ${AppShared.appLang['SAR']}',
                                  style: TextStyle(
                                    fontSize: 18,
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
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 12,
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
              Form(
                key: _storeCheckoutScreenNotifiers.checkoutFormState,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(AppShared.appLang['CustomerName']),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: AppShared.appLang['CustomerName'],
                        ),
                        initialValue: AppShared.currentUser.name,
                        validator: (value) {
                          if (value.isEmpty)
                            return AppShared.appLang['ThisFieldIsRequired'];
                          return null;
                        },
                        onSaved: (value) {
                          _storeCheckoutScreenNotifiers.name = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(AppShared.appLang['MobileNumber']),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: AppShared.appLang['MobileNumber'],
                        ),
                        initialValue: AppShared.currentUser.mobile,
                        validator: (value) {
                          if (value.isEmpty)
                            return AppShared.appLang['ThisFieldIsRequired'];
                          return null;
                        },
                        onSaved: (value) {
                          _storeCheckoutScreenNotifiers.mobile = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(AppShared.appLang['City']),
                      ),
                      DropdownButtonFormField(
                        value: AppShared.currentUser.cityId,
                        items: AppShared.settingResponse.settings.cities
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e.name),
                                value: e.id,
                              ),
                            )
                            .toList(),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                        onChanged: (value) {
                          _storeCheckoutScreenNotifiers.cityId = value;
                          _storeCheckoutScreenNotifiers.deliveryCost =
                              Helpers.getCityById(value).deliveryCost;
                          _storeCheckoutScreenNotifiers.calculate(
                              isFirstTime: false);
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(AppShared.appLang['DeliveryMethod']),
                          ),
                          DropdownButtonFormField(
                            value: 1,
                            items: _storeCheckoutScreenNotifiers
                                .orderReceiveOptions
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: _storeCheckoutScreenNotifiers
                                            .orderReceiveOptions
                                            .indexWhere(
                                                (element) => element == e) +
                                        1,
                                  ),
                                )
                                .toList(),
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                            onChanged: (value) {
                              _storeCheckoutScreenNotifiers.orderReceiveMethod =
                                  value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Selector<StoreCheckoutScreenNotifiers, int>(
                        selector: (_, value) => value.orderReceiveMethod,
                        builder: (_, orderReceiveMethod, __) =>
                            orderReceiveMethod == 1
                                ? Column(
                                    children: <Widget>[
                                      Container(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Text(
                                          AppShared.appLang['DeliveryAddress'],
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          hintText: AppShared
                                              .appLang['DeliveryAddress'],
                                          suffixIcon: InkWell(
                                            onTap: () async {
                                              Location location =
                                                  Location.instance;
                                              PermissionStatus
                                                  permissionStatus =
                                                  await location
                                                      .requestPermission();
                                              if (permissionStatus ==
                                                  PermissionStatus.granted) {
                                                bool isGpsEnabled =
                                                    await location
                                                        .requestService();
                                                if (isGpsEnabled) {
                                                  LocationData data =
                                                      await location
                                                          .getLocation();
                                                  Navigator.pushNamed(
                                                    context,
                                                    Constants
                                                        .SCREENS_GOOGLE_MAP_SCREEN,
                                                    arguments: [data, true],
                                                  ).then((position) {
                                                    LatLng selectedPosition =
                                                        position as LatLng;
                                                    _storeCheckoutScreenNotifiers
                                                            .selectedPosition =
                                                        selectedPosition;
                                                  });
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  AppStyles.defaultPadding2,
                                              child: SvgPicture.asset(
                                                '${Constants.ASSETS_IMAGES_PATH}map.svg',
                                              ),
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty)
                                            return AppShared
                                                .appLang['ThisFieldIsRequired'];
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _storeCheckoutScreenNotifiers
                                              .address = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Text(
                                            AppShared.appLang['DeliveryTime']),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          TimeOfDay time = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now());
                                          if (time == null) return;
                                          _storeCheckoutScreenNotifiers
                                              .deliveryTimeTextEditingController
                                              .text = Helpers.formatTime(time);
                                        },
                                        child: TextField(
                                          controller: _storeCheckoutScreenNotifiers
                                              .deliveryTimeTextEditingController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText: AppShared
                                                .appLang['DeliveryTime'],
                                            suffixIcon: Container(
                                              padding:
                                                  AppStyles.defaultPadding2,
                                              child: SvgPicture.asset(
                                                '${Constants.ASSETS_IMAGES_PATH}time.svg',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                            alignment: AlignmentDirectional.centerStart,
//                            child: Text(AppShared.appLang['TableNumber']),
//                          ),
//                          TextFormField(
//                            keyboardType: TextInputType.number,
//                            decoration: InputDecoration(
//                              hintText: AppShared.appLang['TableNumber'],
//                            ),
//                            validator: (value) {
//                              if (value.isEmpty)
//                                return AppShared.appLang['ThisFieldIsRequired'];
//                              return null;
//                            },
//                            onSaved: (value) {
//                              _storeCheckoutScreenNotifiers.tableNumber =
//                                  value;
//                            },
//                          ),
//                          SizedBox(
//                            height: 20,
//                          ),
//                        ],
//                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          AppShared.appLang['Details'],
                        ),
                      ),
                      TextFormField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: AppShared.appLang['Details'],
                        ),
                        validator: (value) {
                          if (value.isEmpty)
                            return AppShared.appLang['ThisFieldIsRequired'];
                          return null;
                        },
                        onSaved: (value) {
                          _storeCheckoutScreenNotifiers.details = value;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text('${AppShared.appLang['PaymentMethod']} : '),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Selector<StoreCheckoutScreenNotifiers, int>(
                      selector: (_, value) => value.paymentMethod,
                      builder: (_, paymentMethod, __) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _storeCheckoutScreenNotifiers.paymentMethod = 1;
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              color: Colors.grey[200],
                              child: paymentMethod == 1
                                  ? Image.asset(
                                      '${Constants.ASSETS_IMAGES_PATH}check.png',
                                    )
                                  : Container(),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(AppShared.appLang['PayOnDelivery'])
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Selector<StoreCheckoutScreenNotifiers, int>(
                      selector: (_, value) => value.paymentMethod,
                      builder: (_, paymentMethod, __) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _storeCheckoutScreenNotifiers.paymentMethod = 2;
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              color: Colors.grey[200],
                              child: paymentMethod == 2
                                  ? Image.asset(
                                      '${Constants.ASSETS_IMAGES_PATH}check.png',
                                    )
                                  : Container(),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(AppShared.appLang['PayOnline'])
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text('${AppShared.appLang['DiscountCode']} : '),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[100],
                      ),
                      child: TextField(
                        controller: _storeCheckoutScreenNotifiers
                            .promoTextEditingController,
                        decoration: InputDecoration(
                          hintText: '# 000000',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 45,
                      child: Selector<StoreCheckoutScreenNotifiers, bool>(
                        selector: (_, value) => value.isPromoLoading,
                        builder: (_, isPromoLoading, __) => RaisedButton(
                          onPressed: _storeCheckoutScreenNotifiers.checkPromo,
                          color: isPromoLoading
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: isPromoLoading
                                ? MainAxisAlignment.spaceAround
                                : MainAxisAlignment.center,
                            children: <Widget>[
                              Text(AppShared.appLang['Check']),
                              isPromoLoading
                                  ? Container(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Selector<StoreCheckoutScreenNotifiers, bool>(
                selector: (_, value) => value.isPromoCodeWrong,
                builder: (_, isPromoCodeWrong, __) => isPromoCodeWrong == null
                    ? Container()
                    : Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Row(
                          children: <Widget>[
                            isPromoCodeWrong
                                ? SvgPicture.asset(
                                    '${Constants.ASSETS_IMAGES_PATH}error.svg')
                                : Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 18,
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _storeCheckoutScreenNotifiers.promoCodeStatus,
                              style: TextStyle(
                                color: isPromoCodeWrong
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: 50,
              ),
              Selector<StoreCheckoutScreenNotifiers, bool>(
                selector: (_, value) => value.refreshBill,
                builder: (_, refreshBill, __) => Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${AppShared.appLang['SubTotal']} :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          '${_storeCheckoutScreenNotifiers.subTotal} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${AppShared.appLang['DeliveryCost']} :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Selector<StoreCheckoutScreenNotifiers, num>(
                          selector: (_, value) => value.deliveryCost,
                          builder: (_, deliveryCost, __) => Text(
                            '$deliveryCost ${AppShared.appLang['SAR']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${AppShared.appLang['Discount']} :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          '${_storeCheckoutScreenNotifiers.discount} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey[300],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${AppShared.appLang['Total']}  :',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          '${_storeCheckoutScreenNotifiers.total} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomBtnComponent(
                  text: AppShared.appLang['OrderNow'],
                  onTap: (startLoading, stopLoading, btnState) {
                    _storeCheckoutScreenNotifiers.checkout(
                        startLoading, stopLoading, btnState);
                  }),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

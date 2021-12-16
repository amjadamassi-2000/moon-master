import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/cart_resposne.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/beauty_section_screens_notifiers/beauty_checkout_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/custom_btn_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';

class BeautyCheckoutScreen extends StatelessWidget {
  List<Cart> products;
  @override
  Widget build(BuildContext context) {
    products = ModalRoute.of(context).settings.arguments;
    return ParentComponent(
      child: ChangeNotifierProvider<BeautyCheckoutScreenNotifiers>(
        create: (_) => BeautyCheckoutScreenNotifiers(context, products),
        child: BeautyCheckoutScreenBody(),
      ),
    );
  }
}

class BeautyCheckoutScreenBody extends StatefulWidget {
  @override
  _BeautyCheckoutScreenBodyState createState() =>
      _BeautyCheckoutScreenBodyState();
}

class _BeautyCheckoutScreenBodyState extends State<BeautyCheckoutScreenBody> {
  BeautyCheckoutScreenNotifiers _beautyCheckoutScreenNotifiers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _beautyCheckoutScreenNotifiers =
        Provider.of<BeautyCheckoutScreenNotifiers>(context, listen: false);
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
                itemCount: _beautyCheckoutScreenNotifiers.products.length,
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
                            _beautyCheckoutScreenNotifiers
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
                                  _beautyCheckoutScreenNotifiers
                                      .products[index].product.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
//                                Text(
//                                  '${AppShared.appLang['Quantity']} :   ${_beautyCheckoutScreenNotifiers.products[index].quantity}',
//                                  style: TextStyle(
//                                    fontSize: 13,
//                                    color: Colors.grey,
//                                  ),
//                                ),
                                Text(
                                  '${AppShared.appLang['Total']} : ${_beautyCheckoutScreenNotifiers.calculateProductPrice(_beautyCheckoutScreenNotifiers.products[index])} ${AppShared.appLang['SAR']}',
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
                key: _beautyCheckoutScreenNotifiers.checkoutFormState,
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
                          _beautyCheckoutScreenNotifiers.name = value;
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
                          _beautyCheckoutScreenNotifiers.mobile = value;
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
                          _beautyCheckoutScreenNotifiers.cityId = value;
                          _beautyCheckoutScreenNotifiers.deliveryCost =
                              Helpers.getCityById(value).deliveryCost;
                          _beautyCheckoutScreenNotifiers.calculate(
                              isFirstTime: false);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(AppShared.appLang['Date']),
                      ),







                      InkWell(
                        onTap: () async {
                          DateTime date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                              DateTime.now().add(Duration(days: 365)));
                          if (date == null) return;
                          _beautyCheckoutScreenNotifiers.dateTextEditingController.text = Helpers.formatDate2(date);
                        },
                        child: TextField(
                          controller: _beautyCheckoutScreenNotifiers
                              .dateTextEditingController,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: AppShared.appLang['Date'],
                            suffixIcon: Container(
                              padding: AppStyles.defaultPadding2,
                              child: SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}time.svg',
                              ),
                            ),
                          ),
                        ),
                      ),










                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(AppShared.appLang['Time']),
                      ),
                      InkWell(
                        onTap: () async {
                          TimeOfDay time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (time == null) return;
                          _beautyCheckoutScreenNotifiers
                              .timeTextEditingController
                              .text = Helpers.formatTime(time);
                        },
                        child: TextField(
                          controller: _beautyCheckoutScreenNotifiers
                              .timeTextEditingController,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: AppShared.appLang['Time'],
                            suffixIcon: Container(
                              padding: AppStyles.defaultPadding2,
                              child: SvgPicture.asset(
                                '${Constants.ASSETS_IMAGES_PATH}time.svg',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                            alignment: AlignmentDirectional.centerStart,
//                            child: Text(AppShared.appLang['DeliveryMethod']),
//                          ),
//                          DropdownButtonFormField(
//                            value: 1,
//                            items: _beautyCheckoutScreenNotifiers
//                                .orderReceiveOptions
//                                .map(
//                                  (e) => DropdownMenuItem(
//                                    child: Text(e),
//                                    value: _beautyCheckoutScreenNotifiers
//                                            .orderReceiveOptions
//                                            .indexWhere(
//                                                (element) => element == e) +
//                                        1,
//                                  ),
//                                )
//                                .toList(),
//                            icon: Icon(
//                              Icons.arrow_forward_ios,
//                              size: 18,
//                            ),
//                            onChanged: (value) {
//                              _beautyCheckoutScreenNotifiers
//                                  .orderReceiveMethod = value;
//                            },
//                          ),
//                          SizedBox(
//                            height: 20,
//                          ),
//                        ],
//                      ),
//                      Selector<BeautyCheckoutScreenNotifiers, int>(
//                        selector: (_, value) => value.orderReceiveMethod,
//                        builder: (_, orderReceiveMethod, __) =>
//                            orderReceiveMethod == 1
//                                ? Column(
//                                    children: <Widget>[
//                                      Container(
//                                        alignment:
//                                            AlignmentDirectional.centerStart,
//                                        child: Text(
//                                          AppShared.appLang['DeliveryAddress'],
//                                        ),
//                                      ),
//                                      TextFormField(
//                                        decoration: InputDecoration(
//                                          hintText: 'DeliveryAddress',
//                                          suffixIcon: InkWell(
//                                            onTap: () async {
//                                              Location location =
//                                                  Location.instance;
//                                              PermissionStatus
//                                                  permissionStatus =
//                                                  await location
//                                                      .requestPermission();
//                                              if (permissionStatus ==
//                                                  PermissionStatus.granted) {
//                                                bool isGpsEnabled =
//                                                    await location
//                                                        .requestService();
//                                                if (isGpsEnabled) {
//                                                  LocationData data =
//                                                      await location
//                                                          .getLocation();
//                                                  Navigator.pushNamed(
//                                                    context,
//                                                    Constants
//                                                        .SCREENS_GOOGLE_MAP_SCREEN,
//                                                    arguments: [data, true],
//                                                  ).then((position) {
//                                                    LatLng selectedPosition =
//                                                        position as LatLng;
//                                                    _beautyCheckoutScreenNotifiers
//                                                            .selectedPosition =
//                                                        selectedPosition;
//                                                  });
//                                                }
//                                              }
//                                            },
//                                            child: Container(
//                                              padding:
//                                                  AppStyles.defaultPadding2,
//                                              child: SvgPicture.asset(
//                                                '${Constants.ASSETS_IMAGES_PATH}map.svg',
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                        validator: (value) {
//                                          if (value.isEmpty)
//                                            return AppShared
//                                                .appLang['ThisFieldIsRequired'];
//                                          return null;
//                                        },
//                                        onSaved: (value) {
//                                          _beautyCheckoutScreenNotifiers
//                                              .address = value;
//                                        },
//                                      ),
//                                      SizedBox(
//                                        height: 10,
//                                      ),
//                                      Container(
//                                        alignment:
//                                            AlignmentDirectional.centerStart,
//                                        child: Text(
//                                            AppShared.appLang['DeliveryTime']),
//                                      ),
//                                      InkWell(
//                                        onTap: () async {
//                                          TimeOfDay time = await showTimePicker(
//                                              context: context,
//                                              initialTime: TimeOfDay.now());
//                                          if (time == null) return;
//                                          _beautyCheckoutScreenNotifiers
//                                              .deliveryTimeTextEditingController
//                                              .text = Helpers.formatTime(time);
//                                        },
//                                        child: TextField(
//                                          controller: _beautyCheckoutScreenNotifiers
//                                              .deliveryTimeTextEditingController,
//                                          enabled: false,
//                                          decoration: InputDecoration(
//                                            hintText: AppShared
//                                                .appLang['DeliveryTime'],
//                                            suffixIcon: Container(
//                                              padding:
//                                                  AppStyles.defaultPadding2,
//                                              child: SvgPicture.asset(
//                                                '${Constants.ASSETS_IMAGES_PATH}time.svg',
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  )
//                                : Container(),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
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
//                              _beautyCheckoutScreenNotifiers.tableNumber =
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
                          _beautyCheckoutScreenNotifiers.details = value;
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
                    child: Selector<BeautyCheckoutScreenNotifiers, int>(
                      selector: (_, value) => value.paymentMethod,
                      builder: (_, paymentMethod, __) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _beautyCheckoutScreenNotifiers.paymentMethod = 1;
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
                    child: Selector<BeautyCheckoutScreenNotifiers, int>(
                      selector: (_, value) => value.paymentMethod,
                      builder: (_, paymentMethod, __) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _beautyCheckoutScreenNotifiers.paymentMethod = 2;
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
                        controller: _beautyCheckoutScreenNotifiers
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
                      child: Selector<BeautyCheckoutScreenNotifiers, bool>(
                        selector: (_, value) => value.isPromoLoading,
                        builder: (_, isPromoLoading, __) => RaisedButton(
                          onPressed: _beautyCheckoutScreenNotifiers.checkPromo,
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
              Selector<BeautyCheckoutScreenNotifiers, bool>(
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
                              _beautyCheckoutScreenNotifiers.promoCodeStatus,
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
              Selector<BeautyCheckoutScreenNotifiers, bool>(
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
                          '${_beautyCheckoutScreenNotifiers.subTotal} ${AppShared.appLang['SAR']}',
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
                        Selector<BeautyCheckoutScreenNotifiers, num>(
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
                          '${_beautyCheckoutScreenNotifiers.discount} ${AppShared.appLang['SAR']}',
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
                          '${_beautyCheckoutScreenNotifiers.total} ${AppShared.appLang['SAR']}',
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
                    _beautyCheckoutScreenNotifiers.checkout(
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

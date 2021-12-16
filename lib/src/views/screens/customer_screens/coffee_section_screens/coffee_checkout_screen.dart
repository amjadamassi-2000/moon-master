import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/cart_resposne.dart';
import 'package:moonapp/src/models/api_models/others_models/responses/setting_response.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_checkout_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/custom_btn_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';

class CoffeeCheckoutScreen extends StatelessWidget {
  List<Cart> products;
  @override
  Widget build(BuildContext context) {
    products = ModalRoute.of(context).settings.arguments;
    return ParentComponent(
      child: ChangeNotifierProvider<CoffeeCheckoutScreenNotifiers>(
        create: (_) => CoffeeCheckoutScreenNotifiers(context, products),
        child: CoffeeCheckoutScreenBody(),
      ),
    );
  }
}

class CoffeeCheckoutScreenBody extends StatefulWidget {


  @override
  _CoffeeCheckoutScreenBodyState createState() =>
      _CoffeeCheckoutScreenBodyState();
}

class _CoffeeCheckoutScreenBodyState extends State<CoffeeCheckoutScreenBody> {
  CoffeeCheckoutScreenNotifiers _coffeeCheckoutScreenNotifiers;
  Settings settings;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coffeeCheckoutScreenNotifiers =
        Provider.of<CoffeeCheckoutScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var sum = _coffeeCheckoutScreenNotifiers.subTotal + _coffeeCheckoutScreenNotifiers.deliveryCost;
    var vat = (sum* AppShared.settingResponse.settings.taxAmount/100);



    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
          size: AppShared.isTablet ? 50 : 25,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          '${AppShared.appLang['CheckOut']}',
          style: TextStyle(
            color: Colors.black,
            fontSize: AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 16,
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
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(50)
                              : 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      '${Constants.ASSETS_IMAGES_PATH}products.svg',
                      width: AppShared.isTablet ? 35 : 22,
                      height: AppShared.isTablet ? 35 : 22,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ListView.builder(
                itemCount: _coffeeCheckoutScreenNotifiers.products.length,
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
                            _coffeeCheckoutScreenNotifiers
                                .products[index].product.image,
                            height: AppShared.isTablet ? 130 : 70,
                            width: AppShared.isTablet ? 130 : 70,
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
                                  _coffeeCheckoutScreenNotifiers
                                      .products[index].product.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(40)
                                        : 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${AppShared.appLang['Quantity']} :   ${_coffeeCheckoutScreenNotifiers.products[index].quantity}',
                                  style: TextStyle(
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(35)
                                        : 13,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '${AppShared.appLang['Total']} : ${_coffeeCheckoutScreenNotifiers.calculateProductPrice(_coffeeCheckoutScreenNotifiers.products[index])} ${AppShared.appLang['SAR']}',
                                  style: TextStyle(
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(40)
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
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(50)
                              : 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      '${Constants.ASSETS_IMAGES_PATH}contact_form.svg',
                      width: AppShared.isTablet ? 35 : 22,
                      height: AppShared.isTablet ? 35 : 22,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _coffeeCheckoutScreenNotifiers.checkoutFormState,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          AppShared.appLang['CustomerName'],
                          style: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(40)
                                : 18,
                          ),
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(50)
                              : 18,
                        ),
                        decoration: InputDecoration(
                            hintText: AppShared.appLang['CustomerName'],
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(50)
                                  : 16,
                            )),
                        initialValue: AppShared.currentUser.name,
                        validator: (value) {
                          if (value.isEmpty)
                            return AppShared.appLang['ThisFieldIsRequired'];
                          return null;
                        },
                        onSaved: (value) {
                          _coffeeCheckoutScreenNotifiers.name = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          AppShared.appLang['MobileNumber'],
                          style: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 18,
                          ),
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(50)
                              : 16,
                        ),
                        decoration: InputDecoration(
                          hintText: AppShared.appLang['MobileNumber'],
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 16,
                          ),
                        ),
                        initialValue: AppShared.currentUser.mobile,
                        validator: (value) {
                          if (value.isEmpty)
                            return AppShared.appLang['ThisFieldIsRequired'];
                          return null;
                        },
                        onSaved: (value) {
                          _coffeeCheckoutScreenNotifiers.mobile = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          AppShared.appLang['City'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 18,
                          ),
                        ),
                      ),
                      Container(
                        child: DropdownButtonFormField(
                          itemHeight: AppShared.isTablet ? 130 : 50,
                          isDense: false,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(50)
                                  : 16,
                              fontFamily: Helpers.changeAppFont(AppShared
                                  .sharedPreferencesController
                                  .getAppLang())),
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
                            _coffeeCheckoutScreenNotifiers.cityId = value;
                            _coffeeCheckoutScreenNotifiers.deliveryCost = Helpers.getCityById(value).deliveryCost;
                            _coffeeCheckoutScreenNotifiers.calculate(
                                isFirstTime: false);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              AppShared.appLang['DeliveryMethod'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(50)
                                    : 16,
                              ),
                            ),
                          ),
                          DropdownButtonFormField(

                            itemHeight: AppShared.isTablet ? 130 : 50,
                            isDense: false,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(50)
                                    : 16,
                                fontFamily: Helpers.changeAppFont(AppShared
                                    .sharedPreferencesController
                                    .getAppLang())),
                            value: 1,
                            items: _coffeeCheckoutScreenNotifiers
                                .orderReceiveOptions
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(
                                        e
                                    ),
                                    value: _coffeeCheckoutScreenNotifiers
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
                              print(value) ;
                              if(value == 2){
                                print('Takeout');
                                _coffeeCheckoutScreenNotifiers.deliveryCost = 0 ;
                              }else{
                                print('_coffeeCheckoutScreenNotifiers ${_coffeeCheckoutScreenNotifiers.cityId}') ;
                                _coffeeCheckoutScreenNotifiers.deliveryCost= Helpers.getCityById(_coffeeCheckoutScreenNotifiers.cityId).deliveryCost;

                              }
                              _coffeeCheckoutScreenNotifiers.orderReceiveMethod = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Selector<CoffeeCheckoutScreenNotifiers, int>(
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
                                          style: TextStyle(
                                            fontSize: AppShared.isTablet
                                                ? AppShared.screenUtil.setSp(50)
                                                : 18,
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _controller,
                                        style: TextStyle(
                                          fontSize: AppShared.isTablet
                                              ? AppShared.screenUtil.setSp(50)
                                              : 16,
                                        ),
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
                                                  ).then((position) async {
                                                    LatLng selectedPosition = position as LatLng;
                                                    _coffeeCheckoutScreenNotifiers.selectedPosition = selectedPosition;
                                                  _controller.text = await _coffeeCheckoutScreenNotifiers.GetAddressFromLatLong(selectedPosition);

                                                  });
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding: AppShared.isTablet
                                                  ? null
                                                  : AppStyles.defaultPadding2,
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
                                          _coffeeCheckoutScreenNotifiers
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
                                          AppShared.appLang['DeliveryTime'],
                                          style: TextStyle(
                                            fontSize: AppShared.isTablet
                                                ? AppShared.screenUtil.setSp(50)
                                                : 18,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          TimeOfDay time = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now());
                                          if (time == null) return;
                                          _coffeeCheckoutScreenNotifiers
                                              .deliveryTimeTextEditingController
                                              .text = Helpers.formatTime(time);
                                        },
                                        child: TextField(
                                          style: TextStyle(
                                            fontSize: AppShared.isTablet
                                                ? AppShared.screenUtil.setSp(50)
                                                : 16,
                                          ),
                                          controller: _coffeeCheckoutScreenNotifiers
                                              .deliveryTimeTextEditingController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText: AppShared
                                                .appLang['DeliveryTime'],
                                            suffixIcon: Container(
                                              padding: AppShared.isTablet
                                                  ? null
                                                  : AppStyles.defaultPadding2,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              AppShared.appLang['TableNumber'],
                              style: TextStyle(
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(50)
                                    : 16,
                              ),
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(50)
                                  : 16,
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: AppShared.appLang['TableNumber'],
                              hintStyle: TextStyle(
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(50)
                                    : 16,
                              ),
                            ),

                            validator: (value) {
                              if (value.isEmpty && AppShared.currentUser.type != Constants.USER_TYPE_CUSTOMER){
                                print("ThisFieldIsRequired") ;
                                return AppShared.appLang['ThisFieldIsRequired'];
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _coffeeCheckoutScreenNotifiers.tableNumber = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          AppShared.appLang['Details'],
                          style: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 16,
                          ),
                        ),
                      ),
                      TextFormField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: AppShared.appLang['Details'],
                          hintStyle: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 16,
                          ),
                         ),
                        validator: (value) {
                          if (value.isEmpty&& AppShared.currentUser.type == Constants.USER_TYPE_CUSTOMER)
                            return AppShared.appLang['ThisFieldIsRequired'];
                          return null;
                        },
                        onSaved: (value) {
                          _coffeeCheckoutScreenNotifiers.details = value;
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
                child: Text(
                  '${AppShared.appLang['PaymentMethod']} : ',
                  style: TextStyle(
                    fontSize: AppShared.isTablet
                        ? AppShared.screenUtil.setSp(50)
                        : 16,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Selector<CoffeeCheckoutScreenNotifiers, int>(
                      selector: (_, value) => value.paymentMethod,
                      builder: (_, paymentMethod, __) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _coffeeCheckoutScreenNotifiers.paymentMethod = 1;
                            },
                            child: Container(
                              width: AppShared.isTablet ? 40 : 20,
                              height: AppShared.isTablet ? 40 : 20,
                              color: Colors.grey[200],
                              child: paymentMethod == 1
                                  ? Image.asset(
                                      '${Constants.ASSETS_IMAGES_PATH}check.png',
                                      width: AppShared.isTablet ? 30 : 15,
                                      height: AppShared.isTablet ? 30 : 15,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            AppShared.appLang['PayOnDelivery'],
                            style: TextStyle(
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(40)
                                  : 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Selector<CoffeeCheckoutScreenNotifiers, int>(
                      selector: (_, value) => value.paymentMethod,
                      builder: (_, paymentMethod, __) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _coffeeCheckoutScreenNotifiers.paymentMethod = 2;
                            },
                            child: Container(
                              width: AppShared.isTablet ? 40 : 20,
                              height: AppShared.isTablet ? 40 : 20,
                              color: Colors.grey[200],
                              child: paymentMethod == 2
                                  ? Image.asset(
                                      '${Constants.ASSETS_IMAGES_PATH}check.png',
                                      width: AppShared.isTablet ? 30 : 15,
                                      height: AppShared.isTablet ? 30 : 15,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            AppShared.appLang['PayOnline'],
                            style: TextStyle(
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(40)
                                  : 14,
                            ),
                          )
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
                child: Text(
                  '${AppShared.appLang['DiscountCode']} : ',

                  style: TextStyle(
                    fontSize: AppShared.isTablet
                        ? AppShared.screenUtil.setSp(50)
                        : 16,
                  ),
                ),
              ),



              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: AppShared.isTablet ? 100 : 50,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[100],
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(40)
                              : 16,
                        ),
                        controller: _coffeeCheckoutScreenNotifiers
                            .promoTextEditingController,
                        decoration: InputDecoration(
                          hintText: '# 000000',
                          hintStyle: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(40)
                                : 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: AppShared.isTablet ? 95 : 45,
                      child: Selector<CoffeeCheckoutScreenNotifiers, bool>(
                        selector: (_, value) => value.isPromoLoading,
                        builder: (_, isPromoLoading, __) => RaisedButton(
                          onPressed: _coffeeCheckoutScreenNotifiers.checkPromo,
                          color: isPromoLoading
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: isPromoLoading
                                ? MainAxisAlignment.spaceAround
                                : MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppShared.appLang['Check'],
                                style: TextStyle(
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(40)
                                      : 16,
                                ),
                              ),
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
              Selector<CoffeeCheckoutScreenNotifiers, bool>(
                selector: (_, value) => value.isPromoCodeWrong,
                builder: (_, isPromoCodeWrong, __) => isPromoCodeWrong == null
                    ? Container()
                    : Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Row(
                          children: <Widget>[
                            isPromoCodeWrong
                                ? SvgPicture.asset(
                                    '${Constants.ASSETS_IMAGES_PATH}error.svg',
                                    width: AppShared.isTablet ? 35 : 22,
                                    height: AppShared.isTablet ? 35 : 22,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: AppShared.isTablet ? 35 : 18,
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _coffeeCheckoutScreenNotifiers.promoCodeStatus,
                              style: TextStyle(
                                color: isPromoCodeWrong
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(50)
                                    : 16,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: 50,
              ),
              Selector<CoffeeCheckoutScreenNotifiers, bool>(
                selector: (_, value) => value.refreshBill,
                builder: (_, refreshBill, __) => Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${AppShared.appLang['SubTotal']} :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(40)
                                : 16,
                          ),
                        ),
                        Text(
                          '${_coffeeCheckoutScreenNotifiers.subTotal} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(40)
                                  : 14,
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
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(40)
                                : 14,
                          ),
                        ),

                        Selector<CoffeeCheckoutScreenNotifiers, num>(
                          selector: (_, value) =>
                           value.deliveryCost,
                          builder: (_, deliveryCost, __) => Text(
                            '$deliveryCost ${AppShared.appLang['SAR']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(40)
                                    : 14,
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
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(40)
                                : 14,
                          ),
                        ),
                        Text(
                          '${_coffeeCheckoutScreenNotifiers.discount} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(40)
                                  : 14,
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
                          'vat : ${AppShared.settingResponse.settings.taxAmount}%',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(40)
                                : 14,
                          ),
                        ),

                        Text(
                          '${vat} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(40)
                                  : 14,
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
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(45)
                                : 16,
                          ),
                        ),
                        Text(
                          '${_coffeeCheckoutScreenNotifiers.total + vat} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: AppShared.isTablet
                                  ? AppShared.screenUtil.setSp(45)
                                  : 16,
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
                    _coffeeCheckoutScreenNotifiers.checkout(
                        startLoading, stopLoading, btnState);
                  }


                  ),
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

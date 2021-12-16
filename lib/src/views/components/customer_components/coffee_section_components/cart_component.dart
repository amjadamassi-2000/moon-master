import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/cart_resposne.dart';
import 'package:moonapp/src/models/api_models/sub_models/addition.dart';
import 'package:moonapp/src/models/api_models/sub_models/size.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_main_screen_notifiers/pages_notifiers/coffee_home_screen_notifiers/screens_notifiers/coffee_my_cart_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:provider/provider.dart';

class CartComponent extends StatelessWidget {
  final Cart cart;

  CartComponent(this.cart);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cart,
      child: CartComponentBody(),
    );
  }
}

class CartComponentBody extends StatefulWidget {
  @override
  _CartComponentBodyState createState() => _CartComponentBodyState();
}

class _CartComponentBodyState extends State<CartComponentBody> {
  CoffeeMyCartScreenNotifiers _cartScreenNotifiers;
  Cart _cart;
  num totalAdditions = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartScreenNotifiers =
        Provider.of<CoffeeMyCartScreenNotifiers>(context, listen: false);
  }

  // get size by id.
  Size getCartProductSize() {
    return _cart.product.sizes[_cart.product.sizes
        .indexWhere((element) => element.id == _cart.sizeId)];
  }

  @override
  Widget build(BuildContext context) {
    _cart = Provider.of<Cart>(context, listen: false);
    List<Addition> adds = _cart.additions;
    _cart.product.additions.forEach((element) {
      if (adds.indexWhere((element2) => element.id == element2.id) == -1) {
        adds.add(element);
      }
    });
    _cart.additions = adds;
    _cart.additions.forEach((element) {
      element.cartId = _cart.id;
    });
    adds.forEach((element) {
      totalAdditions += element.quantity * element.addition.price;
    });
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Container(
                width: AppShared.isTablet ? 200 : 100,
                height: AppShared.isTablet ? 200 : 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(
                        _cart.product.image,
                      ),
                      fit: BoxFit.fill,
                    ),
                    border:
                        Border.all(width: 1, color: const Color(0xffE4E4E4))),
              ),
              SizedBox(
                width: AppShared.isTablet ? 30 : 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _cart.product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(35)
                            : 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Selector<Cart, int>(
                      selector: (_, value) => value.quantity,
                      builder: (_, quantity, __) => Text(
                        AppShared.sharedPreferencesController
                                    .getSectionType() !=
                                3
                            ? '${AppShared.appLang['Quantity']} : $quantity | ${_cart.product.sizes.isEmpty ? _cart.product.price : num.parse(getCartProductSize().price)} ${AppShared.appLang['SAR']}'
                            : '${_cart.product.price} ${AppShared.appLang['SAR']}',
                        style: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(35)
                                : 11,
                            color: const Color(0xffA2A2A2)),
                      ),
                    ),
                    _cart.product.sizes.isEmpty
                        ? Container()
                        : Text(
                            AppShared.sharedPreferencesController
                                        .getSectionType() !=
                                    3
                                ? '${AppShared.appLang['Size']} : ${getCartProductSize().size.name}'
                                : '${_cart.product.price} ${AppShared.appLang['SAR']}',
                            style: TextStyle(
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(35)
                                    : 11,
                                color: const Color(0xffA2A2A2)),
                          ),
                    totalAdditions == 0
                        ? Container()
                        : Column(
                            children: <Widget>[
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${AppShared.appLang['TotalAdditions']} : $totalAdditions ${AppShared.appLang['SAR']}',
                                style: TextStyle(
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(35)
                                        : 11,
                                    color: const Color(0xffA2A2A2)),
                              ),
                            ],
                          ),
                    _cart.product.sizes.isNotEmpty
                        ? Container()
                        : _cart.product.discount == 0
                            ? Container()
                            : Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '${AppShared.appLang['Discount']} :  ${_cart.product.discount} ${"%"} ',
                                    style: TextStyle(
                                      fontSize: AppShared.isTablet
                                          ? AppShared.screenUtil.setSp(35)
                                          : 11,
                                      color: const Color(0xffA2A2A2),
                                    ),
                                  ),
                                ],
                              ),
                    SizedBox(
                      height: 5,
                    ),
                    Selector<Cart, int>(
                      selector: (_, value) => value.quantity,
                      builder: (_, quantity, __) => _cart.product.sizes.isEmpty
                          ? _cart.product.discount == 0
                              ? Text(
                                  '${AppShared.appLang['Total']} :  ${_cart.product.price * _cart.quantity + totalAdditions} ${AppShared.appLang['SAR']}',
                                  style: TextStyle(
                                      fontSize: AppShared.isTablet
                                          ? AppShared.screenUtil.setSp(35)
                                          : 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  '${AppShared.appLang['Total']} :  ${_cart.product.price * _cart.quantity + totalAdditions} ${AppShared.appLang['SAR']}',
                                  style: TextStyle(
                                      fontSize: AppShared.isTablet
                                          ? AppShared.screenUtil.setSp(35)
                                          : 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                )
                          : Text(
                              '${AppShared.appLang['Total']} :  ${num.parse(getCartProductSize().price) * _cart.quantity + totalAdditions} ${AppShared.appLang['SAR']}',
                              style: TextStyle(
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(35)
                                      : 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppShared.sharedPreferencesController.getSectionType() ==
                            Constants.SECTION_TYPE_SALON
                        ? Container()
                        : Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  if (_cart.quantity > 1) {
                                    _cart.changeQuantity(Constants
                                        .CHANGE_QUANTITY_TYPE_DECREMENT);
                                    _cartScreenNotifiers.onQuantityChanged(
                                        _cart,
                                        Constants
                                            .CHANGE_QUANTITY_TYPE_DECREMENT);
                                  } else {
                                    _cart.removeProductFromCartRequest();
                                    _cartScreenNotifiers
                                        .onProductRemoved(_cart);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              AppShared.isTablet ? 30 : 15))),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      size: AppShared.isTablet ? 30 : 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),

                              Selector<Cart, int>(
                                selector: (_, value) => value.quantity,
                                builder: (_, quantity, __) => Text(
                                  '$quantity',
                                  style: TextStyle(
                                      fontSize: AppShared.isTablet
                                          ? AppShared.screenUtil.setSp(40)
                                          : 16),
                                ),
                              ),



                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  _cart.changeQuantity(
                                      Constants.CHANGE_QUANTITY_TYPE_INCREMENT);
                                  _cartScreenNotifiers.onQuantityChanged(_cart,
                                      Constants.CHANGE_QUANTITY_TYPE_INCREMENT);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              AppShared.isTablet ? 30 : 15))),
                                  child: Center(
                                      child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: AppShared.isTablet ? 30 : 15,
                                  )),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                              context, Constants.SCREENS_ADDITION_SCREEN,
                              arguments: _cart)
                          .then((value) {
                        _cartScreenNotifiers.getCart(isInit: false);
                      });
                    },








                    child: _cart.product.additions == null ||
                            _cart.product.additions.isEmpty
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              '${AppShared.appLang['Additions']}',
                              style: TextStyle(
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(30)
                                      : 10),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    AppShared.isTablet ? 30 : 15)),
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      '${Constants.ASSETS_IMAGES_PATH}delete.svg',
                      width: AppShared.isTablet ? 30 : 15,
                      height: AppShared.isTablet ? 60 : 20,
                      fit: BoxFit.cover,
                    ),
                    onPressed: () {
                      _cart.removeProductFromCartRequest();
                      _cartScreenNotifiers.onProductRemoved(_cart);
                    },
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Divider(
            thickness: 1,
            color: const Color(0xffE5E5E5),
          ),
        )
      ],
    );
  }
}

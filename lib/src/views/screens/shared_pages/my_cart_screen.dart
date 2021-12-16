import 'package:flutter/material.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_main_screen_notifiers/pages_notifiers/coffee_home_screen_notifiers/screens_notifiers/coffee_my_cart_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/views/components/customer_components/coffee_section_components/cart_component.dart';
import 'package:moonapp/src/views/components/others_components/custom_fade_animation_component.dart';
import 'package:moonapp/src/views/components/others_components/info_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class MyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<CoffeeMyCartScreenNotifiers>(
        create: (_) => CoffeeMyCartScreenNotifiers(context),
        child: MyCartScreenBody(),
      ),
    );
  }
}

class MyCartScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyCartScreenBodyState();
  }
}

class _MyCartScreenBodyState extends State<MyCartScreenBody> {
  CoffeeMyCartScreenNotifiers _cartScreenNotifiers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartScreenNotifiers =
        Provider.of<CoffeeMyCartScreenNotifiers>(context, listen: false);
    _cartScreenNotifiers.getCart();
  }

  Widget _cartEmpty() {
    return Center(
      child: InfoComponent(
        infoComponentType: InfoComponentType.INFO_COMPONENT_TYPE_NO_CART,
        title: AppShared.appLang['CartIsEmpty'],
        description: '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<CoffeeMyCartScreenNotifiers, Tuple2<bool, bool>>(
        selector: (_, value) => Tuple2(value.isLoading, value.refreshList),
        builder: (_, tuple, __) => tuple.item1
            ? Center(
                child: LoadingComponent(),
              )
            : _cartScreenNotifiers.isError
                ? Center(
                    child: InfoComponent(
                      title: AppShared.appLang['SomethingWentWrong'],
                      infoComponentType: InfoComponentType
                          .INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS,
                      buttonTitle: AppShared.appLang['TryAgain'],
                      buttonOnTap: () {
                        _cartScreenNotifiers.getCart(isInit: false);
                      },
                    ),
                  )
                : _cartScreenNotifiers.cartResponse.cart.isEmpty
                    ? _cartEmpty()
                    : Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  _cartScreenNotifiers.cartResponse.cart.length,
                              itemBuilder: (_, index) =>
                                  CustomFadeAnimationComponent(
                                index.remainder(20) / 5,
                                CartComponent(
                                  _cartScreenNotifiers.cartResponse.cart[index],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 13,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${AppShared.appLang['SubTotal']} :',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: AppShared.isTablet
                                              ? AppShared.screenUtil.setSp(40)
                                              : 14),
                                    ),
                                    Selector<CoffeeMyCartScreenNotifiers, num>(
                                      selector: (_, value) => value.total,
                                      builder: (_, total, __) => Text(
                                        '$total ${AppShared.appLang['SAR']}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: AppShared.isTablet
                                                ? AppShared.screenUtil.setSp(40)
                                                : 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  width: double.infinity,
                                  child: RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    padding: const EdgeInsets.all(12),


                                    onPressed: () {
                                      if (AppShared.sharedPreferencesController
                                              .getSectionType() ==
                                          Constants.SECTION_TYPE_COFFEE)
                                        Navigator.pushNamed(
                                          context,
                                          Constants
                                              .SCREENS_COFFEE_CHECKOUT_SCREEN,
                                          arguments: _cartScreenNotifiers
                                              .cartResponse.cart,
                                        ).then((value) {
                                          _cartScreenNotifiers.getCart(
                                              isInit: false);
                                        });
                                      else if (AppShared
                                              .sharedPreferencesController
                                              .getSectionType() ==
                                          Constants.SECTION_TYPE_STORE)
                                        Navigator.pushNamed(
                                          context,
                                          Constants
                                              .SCREENS_STORE_CHECKOUT_SCREEN,
                                          arguments: _cartScreenNotifiers
                                              .cartResponse.cart,
                                        ).then((value) {
                                          _cartScreenNotifiers.getCart(
                                              isInit: false);
                                        });
                                      else if (AppShared
                                              .sharedPreferencesController
                                              .getSectionType() ==
                                          Constants.SECTION_TYPE_SALON)
                                        Navigator.pushNamed(
                                          context,
                                          Constants
                                              .SCREENS_BEAUTY_CHECKOUT_SCREEN,
                                          arguments: _cartScreenNotifiers
                                              .cartResponse.cart,
                                        ).then((value) {
                                          _cartScreenNotifiers.getCart(
                                              isInit: false);
                                        });
                                    },




                                    child: Text(
                                      AppShared.appLang['CheckOut'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: AppShared.isTablet
                                              ? AppShared.screenUtil.setSp(50)
                                              : 17),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
      ),
    );
  }
}

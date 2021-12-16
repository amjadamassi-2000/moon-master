import 'package:flutter/material.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/notifiers/components_notifiers/product_component_notifier.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class StoreProductComponent extends StatelessWidget {
  final Product product;
  final Function onUnFavorite;

  StoreProductComponent({
    this.product,
    this.onUnFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider>[
        ChangeNotifierProvider<Product>.value(
          value: product,
        ),
        ChangeNotifierProvider<ProductComponentNotifiers>(
          create: (_) => ProductComponentNotifiers(context),
        )
      ],
      child: ProductComponentBody(
        onUnFavorite: onUnFavorite,
      ),
    );
  }
}

class ProductComponentBody extends StatefulWidget {
  final Function onUnFavorite;

  ProductComponentBody({this.onUnFavorite});

  @override
  _ProductComponentBodyState createState() => _ProductComponentBodyState();
}

class _ProductComponentBodyState extends State<ProductComponentBody> {
  Product _product;
  ProductComponentNotifiers _productComponentNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productComponentNotifiers =
        Provider.of<ProductComponentNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    _product = Provider.of<Product>(context, listen: false);
    if (_product.section == 0) {
      return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            Constants.SCREENS_COFFEE_PRODUCT_DETAILS_SCREEN,
            arguments: _product,
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.network(
                          _product.image,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.18,
                          fit: BoxFit.contain,
                          loadingBuilder: (BuildContext ctx, Widget child,
                                  ImageChunkEvent loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : Center(
                                      child: Shimmer.fromColors(
                                          child: Icon(
                                            Icons.image,
                                            size: 100,
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.grey[200]),
                                    ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            if (!AppShared.sharedPreferencesController
                                .getIsLogin()) {
                              Navigator.pushNamed(
                                  context, Constants.SCREEN_SIGN_IN_SCREEN);
                              return;
                            }
                            _product.changeIsFavorite();
                            if (widget.onUnFavorite == null) return;
                            widget.onUnFavorite();
//                          if (widget.onFavoriteChanged != null)
//                            widget.onFavoriteChanged();
                          },
                          child: Selector<Product, String>(
                            selector: (_, value) => value.isFavorite,
                            builder: (_, isFavorite, __) => Container(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.favorite,
                                color: isFavorite == "0"
                                    ? Colors.grey
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        AppShared.sharedPreferencesController.getAppLang() ==
                                Constants.LANG_EN
                            ? 15
                            : 0,
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: FittedBox(
                      child: Text(
                        _product.name,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height:
                        AppShared.sharedPreferencesController.getAppLang() ==
                                Constants.LANG_EN
                            ? 15
                            : 0,
                  ),
                  _product.sizes.isNotEmpty
                      ? Container(
                          height: 20,
                        )
                      : _product.discount == 0
                          ? Text(
                              '${_product.price} ${AppShared.appLang['SAR']}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${_product.price} ${AppShared.appLang['SAR']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '${_product.discount} ${AppShared.appLang['SAR']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
//                _product.isCart == '0'
//                    ?
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Selector<ProductComponentNotifiers, bool>(
                      selector: (_, value) => value.isLoading,
                      builder: (_, isLoading, __) => RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_product.sizes.isNotEmpty) {
                                  Navigator.pushNamed(
                                      context,
                                      Constants
                                          .SCREENS_COFFEE_PRODUCT_DETAILS_SCREEN,
                                      arguments: _product);
                                  Helpers.showMessage(
                                      AppShared.appLang[
                                          'YouMustSpecifyTheProductSize'],
                                      MessageType.MESSAGE_FAILED);
                                  return;
                                }
                                _productComponentNotifiers.addProductToCart(
                                    productId: _product.id);
                              },
                        child: Row(
                          mainAxisAlignment: isLoading
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppShared.appLang['AddToCart'],
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            isLoading
                                ? Container(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(),
                          ],
                        ),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                      ),
                    ),
                  )
//                    :
//                Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          InkWell(
//                            onTap: () {},
//                            child: Image.asset(
//                                '${Constants.ASSETS_IMAGES_PATH}increment_product.png'),
//                          ),
//                          Text(
//                            '5',
//                            style: TextStyle(
//                              fontSize: 18,
//                              color: Colors.black,
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                          InkWell(
//                            onTap: () {},
//                            child: Image.asset(
//                                '${Constants.ASSETS_IMAGES_PATH}decrement_product.png'),
//                          ),
//                        ],
//                      ),
                ],
              ),
            ),
            _product.discount == 0
                ? Container()
                : Container(
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            '${Constants.ASSETS_IMAGES_PATH}offer.png',
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: AppShared.sharedPreferencesController
                                          .getAppLang() ==
                                      Constants.LANG_EN
                                  ? 8
                                  : 5,
                              horizontal: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${AppShared.appLang['Offer']} ${_product.discount}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ))
                      ],
                    ),
                  )
          ],
        ),
      );
    } else if (_product.section == 1) {
      return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            Constants.SCREENS_BEAUTY_PRODUCT_DETAILS_SCREEN,
            arguments: _product,
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.network(
                          _product.image,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.18,
                          fit: BoxFit.contain,
                          loadingBuilder: (BuildContext ctx, Widget child,
                                  ImageChunkEvent loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : Center(
                                      child: Shimmer.fromColors(
                                          child: Icon(
                                            Icons.image,
                                            size: 100,
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.grey[200]),
                                    ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            if (!AppShared.sharedPreferencesController
                                .getIsLogin()) {
                              Navigator.pushNamed(
                                  context, Constants.SCREEN_SIGN_IN_SCREEN);
                              return;
                            }
                            _product.changeIsFavorite();
                            if (widget.onUnFavorite == null) return;
                            widget.onUnFavorite();
//                          if (widget.onFavoriteChanged != null)
//                            widget.onFavoriteChanged();
                          },
                          child: Selector<Product, String>(
                            selector: (_, value) => value.isFavorite,
                            builder: (_, isFavorite, __) => Container(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.favorite,
                                color: isFavorite == "0"
                                    ? Colors.grey
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        AppShared.sharedPreferencesController.getAppLang() ==
                                Constants.LANG_EN
                            ? 15
                            : 0,
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: FittedBox(
                      child: Text(
                        _product.name,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height:
                        AppShared.sharedPreferencesController.getAppLang() ==
                                Constants.LANG_EN
                            ? 15
                            : 0,
                  ),
                  _product.discount == 0
                      ? Text(
                          '${_product.price} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${_product.price} ${AppShared.appLang['SAR']}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              '${_product.discount} ${AppShared.appLang['SAR']}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
//                _product.isCart == '0'
//                    ?
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Selector<Product, String>(
                        selector: (_, value) => value.isCart,
                        builder: (_, isCart, __) => isCart == '0' ||
                                isCart == null
                            ? RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  _product.changeQuantity(
                                      Constants.CHANGE_QUANTITY_TYPE_INCREMENT);
//                                          _productComponentNotifiers
//                                              .addProductToCart(
//                                                  productId: _product.id);
                                },
                                child: Text(
                                  AppShared.appLang['AddToCart'],
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      _product.changeQuantity(Constants
                                          .CHANGE_QUANTITY_TYPE_INCREMENT);
                                    },
                                    child: Image.asset(
                                        '${Constants.ASSETS_IMAGES_PATH}increment_product.png'),
                                  ),
                                  Text(
                                    isCart,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _product.changeQuantity(Constants
                                          .CHANGE_QUANTITY_TYPE_DECREMENT);
                                    },
                                    child: Image.asset(
                                        '${Constants.ASSETS_IMAGES_PATH}decrement_product.png'),
                                  ),
                                ],
                              )),
                  )
//                    :
//                Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          InkWell(
//                            onTap: () {},
//                            child: Image.asset(
//                                '${Constants.ASSETS_IMAGES_PATH}increment_product.png'),
//                          ),
//                          Text(
//                            '5',
//                            style: TextStyle(
//                              fontSize: 18,
//                              color: Colors.black,
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                          InkWell(
//                            onTap: () {},
//                            child: Image.asset(
//                                '${Constants.ASSETS_IMAGES_PATH}decrement_product.png'),
//                          ),
//                        ],
//                      ),
                ],
              ),
            ),
            _product.discount == 0
                ? Container()
                : Container(
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            '${Constants.ASSETS_IMAGES_PATH}offer.png',
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: AppShared.sharedPreferencesController
                                          .getAppLang() ==
                                      Constants.LANG_EN
                                  ? 8
                                  : 5,
                              horizontal: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${AppShared.appLang['Offer']} ${_product.discount}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ))
                      ],
                    ),
                  )
          ],
        ),
      );
    } else if (_product.section == 2) {
      return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            Constants.SCREENS_BEAUTY_SERVICE_DETAILS_SCREEN,
            arguments: _product,
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.network(
                          _product.image,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.18,
                          fit: BoxFit.contain,
                          loadingBuilder: (BuildContext ctx, Widget child,
                                  ImageChunkEvent loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : Center(
                                      child: Shimmer.fromColors(
                                          child: Icon(
                                            Icons.image,
                                            size: 100,
                                          ),
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.grey[200]),
                                    ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            if (!AppShared.sharedPreferencesController
                                .getIsLogin()) {
                              Navigator.pushNamed(
                                  context, Constants.SCREEN_SIGN_IN_SCREEN);
                              return;
                            }
                            _product.changeIsFavorite();
                            if (widget.onUnFavorite == null) return;
                            widget.onUnFavorite();
//                          if (widget.onFavoriteChanged != null)
//                            widget.onFavoriteChanged();
                          },
                          child: Selector<Product, String>(
                            selector: (_, value) => value.isFavorite,
                            builder: (_, isFavorite, __) => Container(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.favorite,
                                color: isFavorite == "0"
                                    ? Colors.grey
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        AppShared.sharedPreferencesController.getAppLang() ==
                                Constants.LANG_EN
                            ? 15
                            : 0,
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: FittedBox(
                      child: Text(
                        _product.name,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height:
                        AppShared.sharedPreferencesController.getAppLang() ==
                                Constants.LANG_EN
                            ? 15
                            : 0,
                  ),
                  _product.discount == 0
                      ? Text(
                          '${_product.price} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${_product.price} ${AppShared.appLang['SAR']}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              '${_product.discount} ${AppShared.appLang['SAR']}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
//                _product.isCart == '0'
//                    ?
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, Constants.SCREENS_SERVICE_CHECKOUT_SCREEN,
                          arguments: _product);
                    },
                    child: Text(
                      AppShared.appLang['BookNow'],
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  )
//                    :
//                Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                        children: <Widget>[
//                          InkWell(
//                            onTap: () {},
//                            child: Image.asset(
//                                '${Constants.ASSETS_IMAGES_PATH}increment_product.png'),
//                          ),
//                          Text(
//                            '5',
//                            style: TextStyle(
//                              fontSize: 18,
//                              color: Colors.black,
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                          InkWell(
//                            onTap: () {},
//                            child: Image.asset(
//                                '${Constants.ASSETS_IMAGES_PATH}decrement_product.png'),
//                          ),
//                        ],
//                      ),
                ],
              ),
            ),
            _product.discount == 0
                ? Container()
                : Container(
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            '${Constants.ASSETS_IMAGES_PATH}offer.png',
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: AppShared.sharedPreferencesController
                                          .getAppLang() ==
                                      Constants.LANG_EN
                                  ? 8
                                  : 5,
                              horizontal: 2),
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${AppShared.appLang['Offer']} ${_product.discount}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ))
                      ],
                    ),
                  )
          ],
        ),
      );
    }
  }
}

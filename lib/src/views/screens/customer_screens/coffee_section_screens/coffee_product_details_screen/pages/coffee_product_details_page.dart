import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_product_details_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/customer_components/shared_components/related_product_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';

class CoffeeProductDetailsPage extends StatefulWidget {
  CoffeeProductDetailsPage();

  @override
  _CoffeeProductDetailsPageState createState() =>
      _CoffeeProductDetailsPageState();
}

class _CoffeeProductDetailsPageState extends State<CoffeeProductDetailsPage> {
  Product _product;
  CoffeeProductDetailsScreenNotifiers _coffeeProductDetailsScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coffeeProductDetailsScreenNotifiers =
        Provider.of<CoffeeProductDetailsScreenNotifiers>(context,
            listen: false);
    _product = Provider.of<Product>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              Helpers.formatDate(_product.createdAt),
              style: TextStyle(
                color: Colors.black,
                fontSize:
                    AppShared.isTablet ? AppShared.screenUtil.setSp(40) : 16,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _product.sizes.isNotEmpty
              ? Container()
              : _product.discount > 0
                  ? Container()
                  : Container(
                      alignment: AlignmentDirectional.centerStart,


                      child: Text(
                        '${_product.offer_price} ${AppShared.appLang['SAR']}',

                        style: TextStyle(
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(60)
                              : 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                    ),
          _product.sizes.isNotEmpty
              ? Container()
              : _product.discount > 0
                  ? Row(
                      children: <Widget>[
                        Text(
                          '${_product.price} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(60)
                                : 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${_product.discount} ${"%"}',
                          style: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(60)
                                : 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                           // decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    )
                  : Container(),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              _product.description,
              style: TextStyle(
                fontSize:
                    AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 20,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Text(
                AppShared.appLang['Quantity'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize:
                      AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 20,
                ),
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (_coffeeProductDetailsScreenNotifiers.quantity == 0)
                        return;
                      _coffeeProductDetailsScreenNotifiers.quantity--;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 7),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppShared.isTablet ? 30 : 15))),
                      child: Icon(
                        Icons.remove,
                        size: AppShared.isTablet ? 30 : 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppShared.isTablet ? 15 : 10,
                  ),
                  Selector<CoffeeProductDetailsScreenNotifiers, int>(
                    selector: (_, value) => value.quantity,
                    builder: (_, quantity, __) => Text(
                      '$quantity',
                      style: TextStyle(
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(40)
                            : 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppShared.isTablet ? 15 : 10,
                  ),
                  InkWell(
                    onTap: () {
                      _coffeeProductDetailsScreenNotifiers.quantity++;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 7),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppShared.isTablet ? 30 : 15))),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: AppShared.isTablet ? 30 : 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          _product.sizes.isEmpty
              ? Container()
              : Column(
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        AppShared.appLang['Size'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(50)
                              : 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Selector<CoffeeProductDetailsScreenNotifiers, int>(
                      selector: (_, value) => value.selectedSizeIndex,
                      builder: (_, selectedSizeIndex, __) => Container(
                        height: AppShared.isTablet ? 200 : 120,
                        child: ListView.builder(
                            itemCount: _product.sizes.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => Row(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        _coffeeProductDetailsScreenNotifiers
                                            .selectedSizeIndex = index;
                                      },
                                      child: Container(
                                        width: index == selectedSizeIndex
                                            ? AppShared.isTablet
                                                ? 280
                                                : 160
                                            : AppShared.isTablet
                                                ? 260
                                                : 150,
                                        height: index == selectedSizeIndex
                                            ? AppShared.isTablet
                                                ? 200
                                                : 110
                                            : AppShared.isTablet
                                                ? 180
                                                : 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                AppShared.isTablet ? 30 : 15),
                                          ),
                                          border: Border.all(
                                            color: index == selectedSizeIndex
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey[300],
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              '${_product.sizes[index].price} ${AppShared.appLang['SAR']}',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: AppShared.isTablet
                                                    ? AppShared.screenUtil
                                                        .setSp(55)
                                                    : 20,
                                              ),
                                            ),
                                            Text(
                                              _product.sizes[index].size.name,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: AppShared.isTablet
                                                    ? AppShared.screenUtil
                                                        .setSp(50)
                                                    : 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                )),
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 10,
          ),
//          Container(
//            alignment: AlignmentDirectional.centerStart,
//            child: Text(
//              'Contrary to popular belief, Lorem Ipsum is nghhhot simpte. It has roots in a piece of classical Latin literature from 45 BC, making',
//              style: TextStyle(
//                fontSize: 13,
//                color: Colors.grey[600],
//              ),
//            ),
//          ),
          SizedBox(
            height: 20,
          ),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppShared.isTablet ? 60 : 30),
                    ),
                  ),
                  child: Selector<CoffeeProductDetailsScreenNotifiers, bool>(
                    selector: (_, value) => value.isLoading,
                    builder: (_, isLoading, __) => InkWell(
                      onTap: isLoading
                          ? null
                          : () {
                              if (!AppShared.sharedPreferencesController
                                  .getIsLogin()) {
                                Navigator.pushNamed(
                                  context,
                                  Constants.SCREEN_SIGN_IN_SCREEN,
                                );
                                return;
                              }
                              _coffeeProductDetailsScreenNotifiers
                                  .addProductToCart(
                                productId: _product.id,
                                sizeId: _product.sizes.isEmpty
                                    ? null
                                    : _product
                                        .sizes[
                                            _coffeeProductDetailsScreenNotifiers
                                                .selectedSizeIndex]
                                        .id,
                              );
                            },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        alignment: Alignment.center,
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                AppShared.appLang['AddToCart'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppShared.isTablet
                                      ? AppShared.screenUtil.setSp(40)
                                      : 16,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppShared.isTablet ? 50 : 30),
                    ),
                  ),
                  child: Container(
                    width: AppShared.isTablet ? 140 : 70,
                    height: AppShared.isTablet ? 90 : 50,
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Selector<Product, String>(
                        selector: (_, value) => value.isLike,
                        builder: (_, isLike, __) => Container(
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            '${Constants.ASSETS_IMAGES_PATH}like.svg',
                            width: AppShared.isTablet ? 35 : 20,
                            height: AppShared.isTablet ? 35 : 20,
                            fit: BoxFit.cover,
                            color: isLike == '1' ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ),
                      onTap: () {
                        if (!AppShared.sharedPreferencesController
                            .getIsLogin()) {
                          Navigator.pushNamed(
                            context,
                            Constants.SCREEN_SIGN_IN_SCREEN,
                          );
                          return;
                        }
                        _product.changeIsLike();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: AppShared.isTablet ? 140 : 70,
                  height: AppShared.isTablet ? 90 : 50,
                  alignment: Alignment.center,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppShared.isTablet ? 50 : 30))),
                    child: Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Selector<Product, String>(
                          selector: (_, value) => value.isFavorite,
                          builder: (_, isFavorite, __) => Icon(
                            Icons.favorite,
                            color: isFavorite == "0" ? Colors.grey : Colors.red,
                            size: AppShared.isTablet ? 50 : 22,
                          ),
                        ),
                        onTap: () {
                          if (!AppShared.sharedPreferencesController
                              .getIsLogin()) {
                            Navigator.pushNamed(
                              context,
                              Constants.SCREEN_SIGN_IN_SCREEN,
                            );
                            return;
                          }
                          _product.changeIsFavorite();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              AppShared.appLang['RelatedProducts'],
              style: TextStyle(
                color: Colors.black,
                fontSize:
                    AppShared.isTablet ? AppShared.screenUtil.setSp(55) : 20,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Selector<CoffeeProductDetailsScreenNotifiers, bool>(
            selector: (_, value) => value.isSimilarProductsLoading,
            builder: (_, isSimilarProductsLoading, __) =>
                isSimilarProductsLoading
                    ? Center(
                        child: LoadingComponent(),
                      )
                    : _coffeeProductDetailsScreenNotifiers
                            .similarProductsResponse?.products?.isEmpty
                        ? Center(
                            child: Text(
                              AppShared.appLang['NoProducts'],
                              style: TextStyle(
                                fontSize: AppShared.isTablet ? 35 : 16,
                              ),
                            ),
                          )
                        : StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            crossAxisCount: AppShared.isTablet ? 3 : 2,
                            mainAxisSpacing: AppShared.isTablet ? 50 : 10,
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.fit(1),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _coffeeProductDetailsScreenNotifiers
                                .similarProductsResponse.products.length,
                            itemBuilder: (_, index) => RelatedProductComponent(
                              product: _coffeeProductDetailsScreenNotifiers
                                  .similarProductsResponse.products[index],
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}

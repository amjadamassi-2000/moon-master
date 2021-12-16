import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/store_section_screens_notifiers/store_product_details_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/customer_components/shared_components/related_product_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';

class StoreProductDetailsPage extends StatefulWidget {
  StoreProductDetailsPage();

  @override
  _StoreProductDetailsPageState createState() =>
      _StoreProductDetailsPageState();
}

class _StoreProductDetailsPageState extends State<StoreProductDetailsPage> {
  Product _product;
  StoreProductDetailsScreenNotifiers _storeProductDetailsScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeProductDetailsScreenNotifiers =
        Provider.of<StoreProductDetailsScreenNotifiers>(context, listen: false);
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
                        '${_product.price} ${AppShared.appLang['SAR']}',
                        style: TextStyle(
                          fontSize: 30,
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
                          '${_product.discount} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${_product.price} ${AppShared.appLang['SAR']}',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
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
                fontSize: 20,
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
                  fontSize: 20,
                ),
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (_product.isCart == '0') return;
                      _product.changeQuantity(
                          Constants.CHANGE_QUANTITY_TYPE_DECREMENT);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 7),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Icon(
                        Icons.remove,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),




                  Selector<Product, String>(
                    selector: (_, value) => value.isCart,
                    builder: (_, isCart, __) => Text(
                      '$isCart',
                    ),
                  ),








                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      _product.changeQuantity(
                          Constants.CHANGE_QUANTITY_TYPE_INCREMENT);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 7),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
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
          _product.sizes.isNotEmpty
              ? Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppShared.appLang['Size'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                )
              : Container(),
          _product.sizes.isEmpty
              ? Container()
              : Selector<StoreProductDetailsScreenNotifiers, int>(
                  selector: (_, value) => value.selectedSizeIndex,
                  builder: (_, selectedSizeIndex, __) => Container(
                    height: 120,
                    child: ListView.builder(
                        itemCount: _product.sizes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    _storeProductDetailsScreenNotifiers
                                        .selectedSizeIndex = index;
                                  },
                                  child: Container(
                                    width:
                                        index == selectedSizeIndex ? 160 : 150,
                                    height:
                                        index == selectedSizeIndex ? 110 : 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
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
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          _product.sizes[index].size.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
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
                InkWell(
                  onTap: () {
//                    Navigator.of(context).pushNamed(Constants.SCREENS_MY_CART_SCREEN);
                  },
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Selector<StoreProductDetailsScreenNotifiers, bool>(
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
                                _storeProductDetailsScreenNotifiers
                                    .addProductToCart(
                                  productId: _product.id,
                                  sizeId: _product.sizes.isEmpty
                                      ? null
                                      : _product
                                          .sizes[
                                              _storeProductDetailsScreenNotifiers
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
                                  ),
                                ),
                        ),


                      ),







                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    width: 70,
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Selector<Product, String>(
                        selector: (_, value) => value.isLike,
                        builder: (_, isLike, __) => Container(
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            '${Constants.ASSETS_IMAGES_PATH}like.svg',
                            width: 50,
                            height: 50,
                            color: isLike == '1' ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ),
                      onPressed: () {
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
                      color: Colors.white,
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Container(
                    width: 70,
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Selector<Product, String>(
                        selector: (_, value) => value.isFavorite,
                        builder: (_, isFavorite, __) => Container(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.favorite,
                            color: isFavorite == "0" ? Colors.grey : Colors.red,
                          ),
                        ),
                      ),
                      onPressed: () {
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
                      color: Colors.white,
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
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Selector<StoreProductDetailsScreenNotifiers, bool>(
            selector: (_, value) => value.isSimilarProductsLoading,
            builder: (_, isSimilarProductsLoading, __) =>
                isSimilarProductsLoading
                    ? Center(
                        child: LoadingComponent(),
                      )
                    : _storeProductDetailsScreenNotifiers
                            .similarProductsResponse.products.isEmpty
                        ? Center(
                            child: Text(AppShared.appLang['NoProducts']),
                          )
                        : StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.fit(1),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _storeProductDetailsScreenNotifiers
                                .similarProductsResponse.products.length,
                            itemBuilder: (_, index) => RelatedProductComponent(
                              product: _storeProductDetailsScreenNotifiers
                                  .similarProductsResponse.products[index],
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}

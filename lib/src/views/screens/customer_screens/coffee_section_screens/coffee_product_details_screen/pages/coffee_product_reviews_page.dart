import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_product_details_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/components/customer_components/shared_components/related_product_component.dart';
import 'package:moonapp/src/views/components/customer_components/shared_components/review_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';

class CoffeeProductReviewsPage extends StatefulWidget {
  CoffeeProductReviewsPage();

  @override
  _CoffeeProductReviewsPageState createState() =>
      _CoffeeProductReviewsPageState();
}

class _CoffeeProductReviewsPageState extends State<CoffeeProductReviewsPage> {
  Product _product;
  CoffeeProductDetailsScreenNotifiers _coffeeProductDetailsScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _product = Provider.of<Product>(context, listen: false);
    _coffeeProductDetailsScreenNotifiers =
        Provider.of<CoffeeProductDetailsScreenNotifiers>(context,
            listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      '${Constants.ASSETS_IMAGES_PATH}star.png',
                      width: AppShared.isTablet ? 150 : 70,
                      height: AppShared.isTablet ? 150 : 70,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${_product.rate}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(50)
                                : 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppShared.appLang['AverageRating'],
                      style: TextStyle(
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(55)
                            : 20,
                        color: Colors.black,
                      ),
                    ),
//                    SizedBox(
//                      height: 15,
//                    ),
//                    Text(
//                      'The product rated 220 people',
//                      style: TextStyle(
//                        fontSize: 12,
//                        color: Colors.grey,
//                      ),
//                    )
                  ],
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
              AppShared.appLang['WhatPeopleAreSaying'],
              style: TextStyle(
                fontSize:
                    AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Selector<CoffeeProductDetailsScreenNotifiers, bool>(
            selector: (_, value) => value.isReviewsLoading,
            builder: (_, isReviewsLoading, __) => isReviewsLoading
                ? Center(
                    child: LoadingComponent(),
                  )
                : _coffeeProductDetailsScreenNotifiers.productDetailsResponse.reviews.data.isEmpty
                    ? Center(
                        child: Text(
                          '${AppShared.appLang['NoReviews']} !!',
                          style: TextStyle(
                            fontSize: AppShared.isTablet
                                ? AppShared.screenUtil.setSp(40)
                                : 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _coffeeProductDetailsScreenNotifiers
                            .productDetailsResponse.reviews.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) => ReviewComponent(
                          by: _coffeeProductDetailsScreenNotifiers
                              .productDetailsResponse
                              .reviews
                              .data[index]
                              .user
                              .name,
                          content: _coffeeProductDetailsScreenNotifiers
                              .productDetailsResponse
                              .reviews
                              .data[index]
                              .comment,
                          date: _coffeeProductDetailsScreenNotifiers
                              .productDetailsResponse
                              .reviews
                              .data[index]
                              .createdAt,
                          rating: _coffeeProductDetailsScreenNotifiers
                              .productDetailsResponse.reviews.data[index].rate
                              .toDouble(),
                        ),
                      ),
          ),
          _coffeeProductDetailsScreenNotifiers
                  .productDetailsResponse.reviews.data.isEmpty
              ? Container()
              : InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.SCREENS_REVIEWS_SCREEN,
                        arguments: _product.id);
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      AppShared.appLang['More'],
                      style: TextStyle(
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(30)
                            : 13,
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: 20,
          ),
          Selector<CoffeeProductDetailsScreenNotifiers, bool>(
            selector: (_, value) => value.isReviewsLoading,
            builder: (_, isReviewsLoading, __) => isReviewsLoading
                ? Container()
                : _coffeeProductDetailsScreenNotifiers
                            .productDetailsResponse.isReview ==
                        'yes'
                    ? Container()
                    : Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              '${AppShared.appLang['RateProduct']} :',
                              style: TextStyle(
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(55)
                                    : 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RatingBar.builder(
                            onRatingUpdate: (rating) {
                              _coffeeProductDetailsScreenNotifiers.rate =
                                  rating;
                            },
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemSize: AppShared.isTablet ? 60 : 40,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _coffeeProductDetailsScreenNotifiers
                                .rateFromState,
                            child: TextFormField(
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(40)
                                    : 16,
                              ),
                              decoration: InputDecoration(
                                  hintText: AppShared.appLang['Comment'],
                                  hintStyle: TextStyle(
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(40)
                                        : 16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey[200],
                                      width: 0.5,
                                    ),
                                  )),
                              validator: (value) {
                                if (value.isEmpty)
                                  return AppShared
                                      .appLang['ThisFieldIsRequired'];
                                return null;
                              },
                              onSaved: (value) {
                                _coffeeProductDetailsScreenNotifiers.comment =
                                    value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Selector<CoffeeProductDetailsScreenNotifiers, bool>(
                            selector: (_, value) => value.isRateLoading,
                            builder: (_, isRateLoading, __) => Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              alignment: Alignment.center,
                              child: RaisedButton(
                                onPressed: isRateLoading
                                    ? null
                                    : () {
                                        _coffeeProductDetailsScreenNotifiers
                                            .rateProduct(_product.id);
                                      },
                                child: Row(
                                  mainAxisAlignment: isRateLoading
                                      ? MainAxisAlignment.spaceAround
                                      : MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AppShared.appLang['Send'],
                                      style: TextStyle(
                                        fontSize: AppShared.isTablet
                                            ? AppShared.screenUtil.setSp(40)
                                            : 16,
                                      ),
                                    ),
                                    isRateLoading
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
//          FittedBox(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: <Widget>[
//                Card(
//                  color: Theme.of(context).primaryColor,
//                  elevation: 5,
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(30))),
//                  child: Container(
//                    padding: const EdgeInsets.symmetric(
//                        vertical: 15, horizontal: 20),
//                    alignment: Alignment.center,
//                    child: Text(
//                      AppShared.appLang['AddToCart'],
//                      style: TextStyle(
//                        color: Colors.white,
//                      ),
//                    ),
//                  ),
//                ),
//                Card(
//                  elevation: 5,
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(
//                      Radius.circular(30),
//                    ),
//                  ),
//                  child: Container(
//                    width: 70,
//                    alignment: Alignment.center,
//                    child: IconButton(
//                      icon: Selector<Product, String>(
//                        selector: (_, value) => value.isLike,
//                        builder: (_, isLike, __) => Container(
//                          padding: const EdgeInsets.all(5),
//                          child: Image.asset(
//                            '${Constants.ASSETS_IMAGES_PATH}like.png',
//                            width: 50,
//                            height: 50,
//                            color: isLike == '1' ? Colors.blue : Colors.grey,
//                          ),
//                        ),
//                      ),
//                      onPressed: () {
//                        _product.changeIsLike();
//                      },
//                      color: Colors.white,
//                    ),
//                  ),
//                ),
//                Card(
//                  elevation: 5,
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(30))),
//                  child: Container(
//                    width: 70,
//                    alignment: Alignment.center,
//                    child: IconButton(
//                      icon: Selector<Product, String>(
//                        selector: (_, value) => value.isFavorite,
//                        builder: (_, isFavorite, __) => Container(
//                          padding: const EdgeInsets.all(5),
//                          child: Icon(
//                            Icons.favorite,
//                            color: isFavorite == "0" ? Colors.grey : Colors.red,
//                          ),
//                        ),
//                      ),
//                      onPressed: () {
//                        _product.changeIsFavorite();
//                      },
//                      color: Colors.white,
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
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
                            .similarProductsResponse.products?.isEmpty??true
                        ? Center(
                            child: Text(
                              'No Products Found !',
                              style: TextStyle(
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(40)
                                    : 16,
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

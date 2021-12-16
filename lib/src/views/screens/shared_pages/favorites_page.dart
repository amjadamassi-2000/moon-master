import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_pages_notifiers/favorites_page_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/customer_components/coffee_section_components/product_component.dart';
import 'package:moonapp/src/views/components/customer_components/shared_components/product_loading_component.dart';
import 'package:moonapp/src/views/components/others_components/custom_fade_animation_component.dart';
import 'package:moonapp/src/views/components/others_components/info_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class FavoritesPage extends StatelessWidget {
  final ZoomDrawerController _zoomDrawerController;

  FavoritesPage(this._zoomDrawerController);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesPageNotifiers>(
      create: (_) => FavoritesPageNotifiers(context),
      child: FavoritesPageBody(_zoomDrawerController),
    );
  }
}

class FavoritesPageBody extends StatefulWidget {
  final ZoomDrawerController _zoomDrawerController;

  FavoritesPageBody(this._zoomDrawerController);
  @override
  _FavoritesPageBodyState createState() => _FavoritesPageBodyState();
}

class _FavoritesPageBodyState extends State<FavoritesPageBody> {
  FavoritesPageNotifiers _favoritesPageNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favoritesPageNotifiers = Provider.of<FavoritesPageNotifiers>(context, listen: false);

    _favoritesPageNotifiers.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _favoritesPageNotifiers.productsScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Text(
          AppShared.appLang['Favorites'],
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 16,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Helpers.handleDrawer(widget._zoomDrawerController);
          },
          child: Icon(
            Icons.menu,
            color: Colors.black,
            size: AppShared.isTablet ? 50 : 25,
          ),
        ),
      ),
      bottomSheet: Selector<FavoritesPageNotifiers, bool>(
        selector: (_, value) => value.isPagingLoading,
        builder: (_, isPagingLoading, __) =>
            isPagingLoading && !_favoritesPageNotifiers.isLoading
                ? Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: LoadingComponent(),
                  )
                : Container(
                    height: 0,
                  ),
      ),
      body: Selector<FavoritesPageNotifiers, Tuple2<bool, bool>>(
        selector: (_, value) => Tuple2(value.isLoading, value.isNewDataLoaded),
        builder: (_, tuple, __) => tuple.item1
            ? Container(
                padding: AppStyles.defaultPadding3,
                child: ProductLoadingComponent(
                  isScrolling: true,
                ),
              )
            : _favoritesPageNotifiers.isError
                ? Center(
                    child: InfoComponent(
                      title: AppShared.appLang['SomethingWentWrong'],
                      infoComponentType: InfoComponentType
                          .INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS,
                      buttonTitle: AppShared.appLang['TryAgain'],
                      buttonOnTap: () {
                        _favoritesPageNotifiers.init(isInit: false);
                      },
                    ),
                  )
                : _favoritesPageNotifiers.favoriteResponse.products.data.isEmpty
                    ? Container(
                        color: Colors.white10,
                        child: Center(
                          child: InfoComponent(
                            infoComponentType: InfoComponentType
                                .INFO_COMPONENT_TYPE_NO_FAVORITES,
                            title: AppShared.appLang['FavoritesIsEmpty'],
                            description: '',
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.white10,
                        padding: AppStyles.defaultPadding3,
                        child: Column(
                          children: <Widget>[
//            Container(
//              height: _mediaQuery.size.height * 0.04,
//              child: ListView.builder(
//                scrollDirection: Axis.horizontal,
//                itemCount: FakeDataSource.categories.length,
//                itemBuilder: (_, index) => InkWell(
//                  onTap: () {
//                    setState(() {
//                      _clickedCat = index;
//                    });
//                  },
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        alignment: Alignment.center,
//                        padding: const EdgeInsets.symmetric(
//                            vertical: 5, horizontal: 20),
//                        decoration: BoxDecoration(
//                            color: _clickedCat == index
//                                ? Theme.of(context).primaryColor
//                                : Colors.white,
//                            borderRadius: BorderRadius.all(
//                              Radius.circular(20),
//                            ),
//                            border: Border.all(
//                              color: _clickedCat == index
//                                  ? Theme.of(context).primaryColor
//                                  : Colors.grey[300],
//                            )),
//                        child: Text(
//                          FakeDataSource.categories[index],
//                          style: TextStyle(
//                            fontSize: 12,
//                            color: _clickedCat == index
//                                ? Colors.white
//                                : Colors.black,
//                          ),
//                        ),
//                      ),
//                      SizedBox(
//                        width: 5,
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            ),
//            SizedBox(
//              height: 20,
//            ),
                            Expanded(
                                child: StaggeredGridView.countBuilder(
                              controller: _favoritesPageNotifiers
                                  .productsScrollController,
                              itemCount: _favoritesPageNotifiers
                                  .favoriteResponse.products.data.length,
                              crossAxisCount: AppShared.isTablet ? 3 : 2,
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(1),
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              itemBuilder: (_, index) =>
                                  CustomFadeAnimationComponent(
                                index.remainder(20) / 5,
                                ProductComponent(
                                  product: _favoritesPageNotifiers
                                      .favoriteResponse
                                      .products
                                      .data[index]
                                      .product,
                                  onUnFavorite: () {
                                    _favoritesPageNotifiers.onUnFavorite(index);
                                  },
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
      ),
    );
  }
}

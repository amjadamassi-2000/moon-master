import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_main_screen_notifiers/pages_notifiers/coffee_home_screen_notifiers/screens_notifiers/coffee_home_tab_page_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/views/components/customer_components/coffee_section_components/product_component.dart';
import 'package:moonapp/src/views/components/customer_components/shared_components/product_loading_component.dart';
import 'package:moonapp/src/views/components/customer_components/shared_components/slider_loading_component.dart';
import 'package:moonapp/src/views/components/others_components/custom_fade_animation_component.dart';
import 'package:moonapp/src/views/components/others_components/info_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';

class CoffeeHomeTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CoffeeHomeTabPageNotifiers>(
      create: (_) => CoffeeHomeTabPageNotifiers(context),
      child: CoffeeHomeTabPageBody(),
    );
  }
}

class CoffeeHomeTabPageBody extends StatefulWidget {
  @override
  _CoffeeHomeTabPageBodyState createState() => _CoffeeHomeTabPageBodyState();
}

class _CoffeeHomeTabPageBodyState extends State<CoffeeHomeTabPageBody> {
  CoffeeHomeTabPageNotifiers _coffeeHomeTabPageNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coffeeHomeTabPageNotifiers = Provider.of<CoffeeHomeTabPageNotifiers>(context, listen: false);
    _coffeeHomeTabPageNotifiers.init(true);
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      bottomSheet: Selector<CoffeeHomeTabPageNotifiers, bool>(
        selector: (_, value) => value.isPagingLoading,
        builder: (_, isPagingLoading, __) =>
            isPagingLoading && !_coffeeHomeTabPageNotifiers.isProductsLoading
                ? Container(
                    alignment: Alignment.center,
                    height: AppShared.isTablet ? 200 : 100,
                    child: LoadingComponent(),
                  )
                : Container(
                    height: 0,
                  ),
      ),
      body: Selector<CoffeeHomeTabPageNotifiers, bool>(
        selector: (_, value) => value.isError,
        builder: (_, isError, __) => isError
            ? Center(
                child: InfoComponent(
                  title: AppShared.appLang['SomethingWentWrong'],
                  infoComponentType:
                      InfoComponentType.INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS,
                  buttonTitle: AppShared.appLang['TryAgain'],
                  buttonOnTap: () {
                    _coffeeHomeTabPageNotifiers.init(false);
                  },
                ),
              )
            : SingleChildScrollView(
                controller:
                    _coffeeHomeTabPageNotifiers.productsScrollController,
                child: Container(
                  padding: AppStyles.defaultPadding3,
                  child: Column(
                    children: <Widget>[
                      Selector<CoffeeHomeTabPageNotifiers, bool>(
                        selector: (_, value) => value.isSliderLoading,
                        builder: (_, isSliderLoading, __) => isSliderLoading
                            ? SliderLoadingComponent()
                            : Stack(
                                children: <Widget>[
                                  Container(
                                    height: AppShared.isTablet
                                        ? MediaQuery.of(context).size.height *
                                            0.3
                                        : 200,
//                            padding: AppStyles.defaultPadding2,
                                    child: PageView.builder(
                                      onPageChanged: (value) {
                                        _coffeeHomeTabPageNotifiers.selectedSlider = value;
                                      },
                                      itemCount: _coffeeHomeTabPageNotifiers
                                          .coffeeSliderResponse.slider.length,
                                      itemBuilder: (_, index) => Stack(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            height: AppShared.isTablet
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.28
                                                : 200,
                                            alignment: Alignment.center,
                                            child: Image.network(
                                              _coffeeHomeTabPageNotifiers
                                                  .coffeeSliderResponse
                                                  .slider[index]
                                                  .image,
                                              width: double.infinity,
                                              height: AppShared.isTablet
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3
                                                  : 200,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (BuildContext ctx,
                                                      Widget child,
                                                      ImageChunkEvent
                                                          loadingProgress) =>
                                                  loadingProgress == null
                                                      ? child
                                                      : Center(
                                                          child: Shimmer
                                                              .fromColors(
                                                                  child: Icon(
                                                                    Icons.image,
                                                                    size: AppShared
                                                                            .isTablet
                                                                        ? 200
                                                                        : 100,
                                                                  ),
                                                                  baseColor:
                                                                      Colors.grey[
                                                                          300],
                                                                  highlightColor:
                                                                      Colors.grey[
                                                                          200]),
                                                        ),
                                            ),
//                                        width: 90,
//                                        height: 100,
                                          ),
                                          FittedBox(
                                            child: Container(
                                              height: AppShared.isTablet
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3
                                                  : 200,
                                              padding: AppShared.isTablet
                                                  ? const EdgeInsets.symmetric(
                                                      horizontal: 36)
                                                  : AppStyles.defaultPadding3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    _coffeeHomeTabPageNotifiers
                                                        .coffeeSliderResponse
                                                        .slider[index]
                                                        .title,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: AppShared
                                                              .isTablet
                                                          ? AppShared.screenUtil
                                                              .setSp(90)
                                                          : 25,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    _coffeeHomeTabPageNotifiers
                                                        .coffeeSliderResponse
                                                        .slider[index]
                                                        .details??'',
                                                    style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      fontSize: AppShared
                                                              .isTablet
                                                          ? AppShared.screenUtil
                                                              .setSp(30)
                                                          : 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Image.asset(
                                                      '${Constants.ASSETS_IMAGES_PATH}play.png'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: ListView.builder(
                                          itemCount: _coffeeHomeTabPageNotifiers
                                              .coffeeSliderResponse
                                              .slider
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (_, index2) => Selector<CoffeeHomeTabPageNotifiers, int>(
                                                selector: (_, value) => value.selectedSlider,
                                                builder: (_, selectedSlider, __) =>
                                                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      width: AppShared.isTablet
                                                          ? 15
                                                          : 7,
                                                      height: AppShared.isTablet
                                                          ? 15
                                                          : 7,
                                                      decoration: BoxDecoration(
                                                        color: index2 ==
                                                                selectedSlider
                                                            ? Colors.yellow[600]
                                                            : Colors.grey[200],
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    )
                                                  ],
                                                ),
                                              )),
                                    ),
                                  )
                                ],
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(

                        height: AppShared.isTablet
                            ? _mediaQuery.size.height * 0.05
                            : _mediaQuery.size.height * 0.04,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: AppShared
                              .settingResponse.settings.coffeeCategory.length,
                          itemBuilder: (_, index) =>
                              Selector<CoffeeHomeTabPageNotifiers, int>(
                            selector: (_, value) => value.selectedCategory,
                            builder: (_, selectedCategory, __) => InkWell(
                              onTap: () {
                                _coffeeHomeTabPageNotifiers.selectedCategory = index;
                                _coffeeHomeTabPageNotifiers.page = 1;
                                _coffeeHomeTabPageNotifiers.canLoadNewPage =
                                    true;
                                _coffeeHomeTabPageNotifiers.getProducts();
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: AppShared.isTablet
                                            ? AppShared.screenUtil.setWidth(70)
                                            : 20),
                                    decoration: BoxDecoration(
                                        color: selectedCategory == index
                                            ? Theme.of(context).primaryColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            AppShared.isTablet ? 50 : 20,
                                          ),
                                        ),
                                        border: Border.all(
                                          color: selectedCategory == index
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey[300],
                                        )),
                                    child: Text(
                                      AppShared.settingResponse.settings
                                          .coffeeCategory[index].name,
                                      style: TextStyle(
                                        fontSize: AppShared.isTablet ? 25 : 12,
                                        color: selectedCategory == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppShared.isTablet ? 15 : 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppShared.isTablet ? 20 : 10,
                      ),
                      Selector<CoffeeHomeTabPageNotifiers, bool>(
                        selector: (_, value) => value.isProductsLoading,
                        builder: (_, isProductsLoading, __) => Column(
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.centerStart,
                              child: isProductsLoading
                                  ? Text(
                                      '-  ${AppShared.appLang['Products']}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: AppShared.isTablet
                                            ? AppShared.screenUtil.setSp(40)
                                            : 16,
                                      ),
                                    )
                                  : Text(
                                      '${_coffeeHomeTabPageNotifiers.productsResponse.products.total} ${AppShared.appLang['Products']}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: AppShared.isTablet
                                              ? AppShared.screenUtil.setSp(40)
                                              : 16),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Selector<CoffeeHomeTabPageNotifiers, Tuple2<bool, bool>>(
                        selector: (_, value) => Tuple2(
                            value.isProductsLoading, value.isNewDataLoaded),
                        builder: (_, tuple, __) => tuple.item1
                            ? ProductLoadingComponent(
                                isScrolling: false,
                              )
                            : _coffeeHomeTabPageNotifiers
                                    .productsResponse.products.data.isEmpty
                                ? Container(
                                    child: Center(
                                      child: Text(
                                        AppShared.appLang['NoProducts'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: AppShared.isTablet
                                              ? AppShared.screenUtil.setSp(40)
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  )
                                : StaggeredGridView.countBuilder(
                                    crossAxisCount: AppShared.isTablet ? 3 : 2,
                                    staggeredTileBuilder: (int index) =>
                                        new StaggeredTile.fit(1),
                                    mainAxisSpacing:
                                        AppShared.isTablet ? 20 : 10,
                                    crossAxisSpacing:
                                        AppShared.isTablet ? 20 : 10,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
//                                    gridDelegate:
//                                        SliverGridDelegateWithFixedCrossAxisCount(
//                                      crossAxisCount:
//                                          AppShared.isTablet ? 3 : 2,
//                                      childAspectRatio: 1 / 1.6,
//                                      crossAxisSpacing:
//                                          AppShared.isTablet ? 20 : 10,
//                                      mainAxisSpacing:
//                                          AppShared.isTablet ? 20 : 10,
//                                    ),
                                    itemCount: _coffeeHomeTabPageNotifiers
                                        .productsResponse.products.data.length,

                                    itemBuilder: (_, index) =>
                                        CustomFadeAnimationComponent(
                                      index.remainder(20) / 5,
                                      ProductComponent(
                                        product: _coffeeHomeTabPageNotifiers
                                            .productsResponse
                                            .products
                                            .data[index],
                                      ),
                                    ),
                                  ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

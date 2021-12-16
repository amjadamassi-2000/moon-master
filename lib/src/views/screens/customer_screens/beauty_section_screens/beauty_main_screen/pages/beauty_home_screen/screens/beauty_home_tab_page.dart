import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/beauty_section_screens_notifiers/beauty_main_screen_notifiers/pages_notifiers/beauty_home_screen_notifiers/screens_notifiers/beauty_home_tab_page_notifiers.dart';
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

class BeautyHomeTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BeautyHomeTabPageNotifiers>(
      create: (_) => BeautyHomeTabPageNotifiers(context),
      child: BeautyHomeTabPageBody(),
    );
  }
}

class BeautyHomeTabPageBody extends StatefulWidget {
  @override
  _BeautyHomeTabPageBodyState createState() => _BeautyHomeTabPageBodyState();
}

class _BeautyHomeTabPageBodyState extends State<BeautyHomeTabPageBody> {
  BeautyHomeTabPageNotifiers _beautyHomeTabPageNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _beautyHomeTabPageNotifiers =
        Provider.of<BeautyHomeTabPageNotifiers>(context, listen: false);
    _beautyHomeTabPageNotifiers.init(true);
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      bottomSheet: Selector<BeautyHomeTabPageNotifiers, bool>(
        selector: (_, value) => value.isPagingLoading,
        builder: (_, isPagingLoading, __) =>
            isPagingLoading && !_beautyHomeTabPageNotifiers.isProductsLoading
                ? Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: LoadingComponent(),
                  )
                : Container(
                    height: 0,
                  ),
      ),
      body: Selector<BeautyHomeTabPageNotifiers, bool>(
        selector: (_, value) => value.isError,
        builder: (_, isError, __) => isError
            ? Center(
                child: InfoComponent(
                  title: AppShared.appLang['SomethingWentWrong'],
                  infoComponentType:
                      InfoComponentType.INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS,
                  buttonTitle: AppShared.appLang['TryAgain'],
                  buttonOnTap: () {
                    _beautyHomeTabPageNotifiers.init(false);
                  },
                ),
              )
            : SingleChildScrollView(
                controller:
                    _beautyHomeTabPageNotifiers.productsScrollController,
                child: Container(
                  padding: AppStyles.defaultPadding3,
                  child: Column(
                    children: <Widget>[
                      Selector<BeautyHomeTabPageNotifiers, bool>(
                        selector: (_, value) => value.isSliderLoading,
                        builder: (_, isSliderLoading, __) => isSliderLoading
                            ? SliderLoadingComponent()
                            : Stack(
                                children: <Widget>[
                                  Container(
                                    height: 200,
//                            padding: AppStyles.defaultPadding2,
                                    child: PageView.builder(
                                      onPageChanged: (value) {
                                        _beautyHomeTabPageNotifiers
                                            .selectedSlider = value;
                                      },
                                      itemCount: _beautyHomeTabPageNotifiers
                                          .coffeeSliderResponse.slider.length,
                                      itemBuilder: (_, index) => Stack(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            height: 200,
                                            alignment: Alignment.center,
                                            child: Image.network(
                                              _beautyHomeTabPageNotifiers
                                                  .coffeeSliderResponse
                                                  .slider[index]
                                                  .image,
                                              height: 200,
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
                                                                    size: 100,
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
                                              height: 200,
                                              padding:
                                                  AppStyles.defaultPadding3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    _beautyHomeTabPageNotifiers
                                                        .coffeeSliderResponse
                                                        .slider[index]
                                                        .title,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    _beautyHomeTabPageNotifiers
                                                        .coffeeSliderResponse
                                                        .slider[index]
                                                        .details??'',
                                                    style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      fontSize: 12,
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
                                          itemCount: _beautyHomeTabPageNotifiers
                                              .coffeeSliderResponse
                                              .slider
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (_, index2) => Selector<
                                                  BeautyHomeTabPageNotifiers,
                                                  int>(
                                                selector: (_, value) =>
                                                    value.selectedSlider,
                                                builder:
                                                    (_, selectedSlider, __) =>
                                                        Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 7,
                                                      height: 7,
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

                        height: _mediaQuery.size.height * 0.04,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: AppShared
                              .settingResponse.settings.serviceCategory.length,
                          itemBuilder: (_, index) =>
                              Selector<BeautyHomeTabPageNotifiers, int>(
                            selector: (_, value) => value.selectedCategory,
                            builder: (_, selectedCategory, __) => InkWell(
                              onTap: () {
                                _beautyHomeTabPageNotifiers.selectedCategory =
                                    index;
                                _beautyHomeTabPageNotifiers.page = 1;
                                _beautyHomeTabPageNotifiers.canLoadNewPage =
                                    true;
                                _beautyHomeTabPageNotifiers.getServices();
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: selectedCategory == index
                                            ? Theme.of(context).primaryColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        border: Border.all(
                                          color: selectedCategory == index
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey[300],
                                        )),
                                    child: Text(
                                      AppShared.settingResponse.settings
                                          .serviceCategory[index].name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: selectedCategory == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Selector<BeautyHomeTabPageNotifiers, bool>(
                        selector: (_, value) => value.isProductsLoading,
                        builder: (_, isProductsLoading, __) => Column(
                          children: <Widget>[
                            Container(

                              alignment: AlignmentDirectional.centerStart,
                              child: isProductsLoading
                                  ? Text('-  ${AppShared.appLang['Products']}')
                                  : Text(
                                      '${_beautyHomeTabPageNotifiers.productsResponse.products.total} ${AppShared.appLang['Products']}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Selector<BeautyHomeTabPageNotifiers, Tuple2<bool, bool>>(
                        selector: (_, value) => Tuple2(value.isProductsLoading, value.isNewDataLoaded),
                        builder: (_, tuple, __) => tuple.item1
                            ? ProductLoadingComponent(
                                isScrolling: false,
                              )
                            : _beautyHomeTabPageNotifiers
                                    .productsResponse.products.data.isEmpty
                                ? Container(

                                    child: Center(
                                      child: Text(AppShared.appLang['NoServices']),
                                    ),
                                  )
                                : StaggeredGridView.countBuilder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    crossAxisCount: 2,
                                    staggeredTileBuilder: (int index) =>
                                        new StaggeredTile.fit(1),
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    itemCount: _beautyHomeTabPageNotifiers
                                        .productsResponse.products.data.length,
                                    itemBuilder: (_, index) =>
                                        CustomFadeAnimationComponent(
                                      index.remainder(20) / 5,
                                      ProductComponent(
                                        product: _beautyHomeTabPageNotifiers
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

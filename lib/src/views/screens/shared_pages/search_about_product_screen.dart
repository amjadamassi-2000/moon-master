import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_pages_notifiers/search_about_product_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/views/components/customer_components/coffee_section_components/product_component.dart';
import 'package:moonapp/src/views/components/customer_components/shared_components/product_loading_component.dart';
import 'package:moonapp/src/views/components/others_components/custom_fade_animation_component.dart';
import 'package:moonapp/src/views/components/others_components/info_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class SearchAboutProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: ChangeNotifierProvider<SearchAboutProductScreenNotifiers>(
        create: (_) => SearchAboutProductScreenNotifiers(context),
        child: SearchAboutProductScreenBody(),
      ),
    );
  }
}

class SearchAboutProductScreenBody extends StatefulWidget {
  @override
  _SearchAboutProductScreenBodyState createState() =>
      _SearchAboutProductScreenBodyState();
}

class _SearchAboutProductScreenBodyState
    extends State<SearchAboutProductScreenBody> {
  SearchAboutProductScreenNotifiers _coffeeSearchAboutProductScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coffeeSearchAboutProductScreenNotifiers =
        Provider.of<SearchAboutProductScreenNotifiers>(context, listen: false);
    _coffeeSearchAboutProductScreenNotifiers.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _coffeeSearchAboutProductScreenNotifiers.searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffF7F0DD),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                    fontSize: AppShared.isTablet
                        ? AppShared.screenUtil.setSp(30)
                        : 13,
                  ),
                  controller: _coffeeSearchAboutProductScreenNotifiers
                      .searchTextController,
                  decoration: InputDecoration(
                    hintText: AppShared.appLang['SearchAboutProduct'],
                    hintStyle: TextStyle(
                      fontSize: AppShared.isTablet
                          ? AppShared.screenUtil.setSp(30)
                          : 13,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    _coffeeSearchAboutProductScreenNotifiers.page = 1;
                    _coffeeSearchAboutProductScreenNotifiers.canLoadNewPage =
                        true;
                    if (value.isEmpty)
                      _coffeeSearchAboutProductScreenNotifiers.getProducts();
                    else
                      _coffeeSearchAboutProductScreenNotifiers.search();
                  },
                ),





              ),
              InkWell(
                onTap: () {
                  if (_coffeeSearchAboutProductScreenNotifiers
                      .searchTextController.text.isEmpty) return;
                  _coffeeSearchAboutProductScreenNotifiers.searchTextController
                      .clear();
                  _coffeeSearchAboutProductScreenNotifiers.getProducts();
                },
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Selector<SearchAboutProductScreenNotifiers, bool>(
        selector: (_, value) => value.isPagingLoading,
        builder: (_, isPagingLoading, __) => isPagingLoading &&
                !_coffeeSearchAboutProductScreenNotifiers.isLoading
            ? Container(
                alignment: Alignment.center,
                height: 100,
                child: LoadingComponent(),
              )
            : Container(
                height: 0,
              ),
      ),
      body: Selector<SearchAboutProductScreenNotifiers, Tuple2<bool, bool>>(
          selector: (_, value) =>
              Tuple2(value.isLoading, value.isNewDataLoaded),
          builder: (_, tuple, __) => tuple.item1
              ? Container(
                  padding: AppStyles.defaultPadding3,
                  child: ProductLoadingComponent(
                    isScrolling: true,
                  ),
                )
              : (_coffeeSearchAboutProductScreenNotifiers.productsResponse ==
                          null ||
                      _coffeeSearchAboutProductScreenNotifiers
                          .productsResponse.products.data.isEmpty)
                  ? Container(
                      child: Center(
                        child: InfoComponent(
                          infoComponentType: InfoComponentType
                              .INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS,
                          title: AppShared.appLang['NoSearchResults'],
                          description: '',
                        ),
                      ),
                    )
                  : Container(
                      padding: AppStyles.defaultPadding3,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '${_coffeeSearchAboutProductScreenNotifiers.productsResponse.products.total} ${AppShared.appLang['Products']}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(40)
                                    : 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: StaggeredGridView.countBuilder(
                                controller:
                                    _coffeeSearchAboutProductScreenNotifiers
                                        .productsScrollController,
                                crossAxisCount: 2,
                                staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.fit(1),
                                mainAxisSpacing: AppShared.isTablet ? 20 : 10,
                                crossAxisSpacing: AppShared.isTablet ? 20 : 10,
                                itemCount:
                                    _coffeeSearchAboutProductScreenNotifiers
                                        .productsResponse.products.data.length,
                                itemBuilder: (_, index) => InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          Constants
                                              .SCREENS_COFFEE_PRODUCT_DETAILS_SCREEN,
                                          arguments:
                                              _coffeeSearchAboutProductScreenNotifiers
                                                  .productsResponse
                                                  .products
                                                  .data[index],
                                        );
                                      },
                                      child: CustomFadeAnimationComponent(
                                        index.remainder(20) / 5,
                                        ProductComponent(
                                          product:
                                              _coffeeSearchAboutProductScreenNotifiers
                                                  .productsResponse
                                                  .products
                                                  .data[index],
                                        ),
                                      ),
                                    )),
                          ),
                        ],
                      ),
                    )),
    );
  }
}

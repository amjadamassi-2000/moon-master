import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_pages_notifiers/offers_page_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/views/components/customer_components/coffee_section_components/product_component.dart';
import 'package:moonapp/src/views/components/customer_components/shared_components/product_loading_component.dart';
import 'package:moonapp/src/views/components/others_components/custom_fade_animation_component.dart';
import 'package:moonapp/src/views/components/others_components/info_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class OffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OffersPageNotifiers>(
      create: (_) => OffersPageNotifiers(context),
      child: OffersPageBody(),
    );
  }
}

class OffersPageBody extends StatefulWidget {
  @override
  _OffersPageBodyState createState() => _OffersPageBodyState();
}

class _OffersPageBodyState extends State<OffersPageBody> {
  OffersPageNotifiers _offersPageNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offersPageNotifiers =
        Provider.of<OffersPageNotifiers>(context, listen: false);
    _offersPageNotifiers.getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Selector<OffersPageNotifiers, bool>(
        selector: (_, value) => value.isPagingLoading,
        builder: (_, isPagingLoading, __) =>
            isPagingLoading && !_offersPageNotifiers.isLoading
                ? Container(
                    alignment: Alignment.center,
                    height: AppShared.isTablet ? 200 : 100,
                    child: LoadingComponent(),
                  )
                : Container(
                    height: 0,
                  ),
      ),
      body: Container(
        padding: AppStyles.defaultPadding3,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Selector<OffersPageNotifiers, Tuple2<bool, bool>>(
              selector: (_, value) =>
                  Tuple2(value.isLoading, value.isNewDataLoaded),
              builder: (_, tuple, __) => tuple.item1
                  ? ProductLoadingComponent(
                      isScrolling: false,
                    )
                  : _offersPageNotifiers.isError
                      ? Center(
                          child: InfoComponent(
                            title: AppShared.appLang['SomethingWentWrong'],
                            infoComponentType: InfoComponentType
                                .INFO_COMPONENT_TYPE_NO_SEARCH_RESULTS,
                            buttonTitle: AppShared.appLang['TryAgain'],
                            buttonOnTap: () {
                              _offersPageNotifiers.getOffers(isInit: false);
                            },
                          ),
                        )
                      : _offersPageNotifiers
                              .productsResponse.products.data.isEmpty
                          ? Container(
                              color: Colors.white10,
                              child: Center(
                                child: InfoComponent(
                                  infoComponentType: InfoComponentType
                                      .INFO_COMPONENT_TYPE_NO_OFFERS,
                                  title: AppShared.appLang['NoOffersAvailable'],
                                  description: '',
                                ),
                              ),
                            )
                          : Column(
                              children: <Widget>[
                                Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    ' ${AppShared.appLang['Products']} : ${_offersPageNotifiers.productsResponse.products.data.length} ',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: AppShared.isTablet
                                            ? AppShared.screenUtil.setSp(40)
                                            : 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: StaggeredGridView.countBuilder(
                                    controller: _offersPageNotifiers
                                        .offersScrollController,
                                    crossAxisCount: 2,
                                    staggeredTileBuilder: (int index) =>
                                        new StaggeredTile.fit(1),
                                    mainAxisSpacing:
                                        AppShared.isTablet ? 20 : 10,
                                    crossAxisSpacing:
                                        AppShared.isTablet ? 20 : 10,
                                    itemCount: _offersPageNotifiers
                                        .productsResponse.products.data.length,
                                    itemBuilder: (_, index) => InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(
                                                Constants
                                                    .SCREENS_COFFEE_PRODUCT_DETAILS_SCREEN,
                                                arguments: _offersPageNotifiers
                                                    .productsResponse
                                                    .products
                                                    .data[index])
                                            .then((value) {
                                          if (value == null) return;
                                          _offersPageNotifiers
                                              .productsResponse
                                              .products
                                              .data[index]
                                              .isFavorite = value;
                                          _offersPageNotifiers.isNewDataLoaded =
                                              !_offersPageNotifiers
                                                  .isNewDataLoaded;
                                        });
                                      },
                                      child: CustomFadeAnimationComponent(
                                        index.remainder(20) / 5,
                                        ProductComponent(
                                          product: _offersPageNotifiers
                                              .productsResponse
                                              .products
                                              .data[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
            ))
          ],
        ),
      ),
    );
  }
}

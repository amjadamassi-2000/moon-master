import 'package:flutter/material.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/coffee_product_details_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_product_details_screen/pages/coffee_product_details_page.dart';
import 'package:moonapp/src/views/screens/customer_screens/coffee_section_screens/coffee_product_details_screen/pages/coffee_product_reviews_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class CoffeeProductDetailsScreen extends StatelessWidget {
  Product product;

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context).settings.arguments;
    return ParentComponent(
      child: MultiProvider(
        providers: <ChangeNotifierProvider>[
          ChangeNotifierProvider<Product>.value(
            value: product,
          ),
          ChangeNotifierProvider<CoffeeProductDetailsScreenNotifiers>(
            create: (_) => CoffeeProductDetailsScreenNotifiers(context),
          ),
        ],
        child: CoffeeProductDetailsScreenBody(),
      ),
    );
  }
}

class CoffeeProductDetailsScreenBody extends StatefulWidget {
  @override
  _CoffeeProductDetailsScreenBodyState createState() =>
      _CoffeeProductDetailsScreenBodyState();
}

class _CoffeeProductDetailsScreenBodyState
    extends State<CoffeeProductDetailsScreenBody>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  CoffeeProductDetailsScreenNotifiers _coffeeProductDetailsScreenNotifiers;
  Product _product;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _coffeeProductDetailsScreenNotifiers = Provider.of<CoffeeProductDetailsScreenNotifiers>(context, listen: false);
    _product = Provider.of<Product>(context, listen: false);
    _coffeeProductDetailsScreenNotifiers.getProductDetails(_product.id);
    _coffeeProductDetailsScreenNotifiers.getSimilarProducts(_product.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: AppShared.isTablet
                    ? MediaQuery.of(context).size.height * 0.45
                    : 300,
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.white10,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Container(
                        height: AppShared.isTablet
                            ? MediaQuery.of(context).size.height * 0.43
                            : 300,
                        child:
                       _product.attachments.isEmpty? Image.network(
                                _product.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext ctx, Widget child,
                                        ImageChunkEvent loadingProgress) =>
                                    loadingProgress == null
                                        ? child
                                        : Center(
                                            child: Shimmer.fromColors(
                                                child: Icon(
                                                  Icons.image,
                                                  size: 250,
                                                ),
                                                baseColor: Colors.grey[300],
                                                highlightColor:
                                                    Colors.grey[200]),
                                          ),
                              ): PageView.builder(
                                onPageChanged: (value) {
                                  _coffeeProductDetailsScreenNotifiers
                                      .selectedSlider = value;
                                },

                                itemCount: _product.attachments.length,
                                itemBuilder: (_, index) => Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Image.network(
                                    _product.attachments[index].productImg,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext ctx,
                                            Widget child,
                                            ImageChunkEvent loadingProgress) =>
                                        loadingProgress == null
                                            ? child
                                            : Center(
                                                child: Shimmer.fromColors(
                                                    child: Icon(
                                                      Icons.image,
                                                      size: 250,
                                                    ),
                                                    baseColor: Colors.grey[300],
                                                    highlightColor:
                                                        Colors.grey[200]),
                                              ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: AppStyles.defaultPadding3,
                        alignment: AlignmentDirectional.bottomStart,
                        margin: EdgeInsets.only(
                            bottom: AppShared.isTablet ? 24 : 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${_product.views} ${AppShared.appLang['Views']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(40)
                                    : 16,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '${_product.likeCount} ${AppShared.appLang['Likes']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(40)
                                    : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          alignment: Alignment.center,
                          child: ListView.builder(
                            itemCount: 5,
                            //_product.attachments.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index2) => Selector<
                                CoffeeProductDetailsScreenNotifiers, int>(
                              selector: (_, value) => value.selectedSlider,
                              builder: (_, selectedSlider, __) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    width: AppShared.isTablet ? 20 : 7,
                                    height: AppShared.isTablet ? 20 : 7,
                                    decoration: BoxDecoration(
                                      color: index2 == selectedSlider
                                          ? Colors.yellow[600]
                                          : Colors.grey[200],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppShared.isTablet ? 10 : 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: Container(
            padding: AppStyles.defaultPadding3,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      '${_product.name}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: AppShared.isTablet
                            ? AppShared.screenUtil.setSp(60)
                            : 28,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 1,
                  ),

                  Container(
                    height: AppShared.isTablet ? 60 : 35,
                    child: TabBar(
                        indicatorColor: Theme.of(context).primaryColor,
                        controller: _tabController,
                        onTap: (value) {
                          _coffeeProductDetailsScreenNotifiers.selectedTab =
                              value;
                        },
                        tabs: [
                          Tab(
                            child: Text(
                              AppShared.appLang['Details'],
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(40)
                                    : 16,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              AppShared.appLang['Reviews'],
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: AppShared.isTablet
                                    ? AppShared.screenUtil.setSp(40)
                                    : 16,
                              ),
                            ),
                          ),
                        ]),
                  ),


                  Divider(
                    thickness: 1,
                  ),
                  Selector<CoffeeProductDetailsScreenNotifiers, int>(
                    selector: (_, value) => value.selectedTab,
                    builder: (_, selectedTab, __) => selectedTab == 0
                        ? CoffeeProductDetailsPage()
                        : CoffeeProductReviewsPage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

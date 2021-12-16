import 'package:flutter/material.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/store_section_screens_notifiers/store_product_details_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/screens/customer_screens/store_section_screens/store_product_details_screen/pages/store_product_details_page.dart';
import 'package:moonapp/src/views/screens/customer_screens/store_section_screens/store_product_details_screen/pages/store_product_reviews_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class StoreProductDetailsScreen extends StatelessWidget {
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
          ChangeNotifierProvider<StoreProductDetailsScreenNotifiers>(
            create: (_) => StoreProductDetailsScreenNotifiers(context),
          ),
        ],
        child: StoreProductDetailsScreenBody(),
      ),
    );
  }
}

class StoreProductDetailsScreenBody extends StatefulWidget {
  @override
  _StoreProductDetailsScreenBodyState createState() =>
      _StoreProductDetailsScreenBodyState();
}

class _StoreProductDetailsScreenBodyState
    extends State<StoreProductDetailsScreenBody>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  StoreProductDetailsScreenNotifiers _storeProductDetailsScreenNotifiers;
  Product _product;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _storeProductDetailsScreenNotifiers =
        Provider.of<StoreProductDetailsScreenNotifiers>(context, listen: false);
    _product = Provider.of<Product>(context, listen: false);
    _storeProductDetailsScreenNotifiers.getProductDetails(_product.id);
    _storeProductDetailsScreenNotifiers.getSimilarProducts(_product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 300,
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.white10,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Container(
                        height: 300,
                        child: _product.attachments.isEmpty
                            ? Image.network(
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
                              )
                            : PageView.builder(
                                onPageChanged: (value) {
                                  _storeProductDetailsScreenNotifiers
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${_product.views} ${AppShared.appLang['Views']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${_product.likeCount} ${AppShared.appLang['Likes']}',
                              style: TextStyle(
                                color: Colors.white,
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
                            itemCount: _product.attachments.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index2) => Selector<
                                StoreProductDetailsScreenNotifiers, int>(
                              selector: (_, value) => value.selectedSlider,
                              builder: (_, selectedSlider, __) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: BoxDecoration(
                                      color: index2 == selectedSlider
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
                        fontSize: 28,
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
                    height: 35,
                    child: TabBar(
                        indicatorColor: Theme.of(context).primaryColor,
                        controller: _tabController,
                        onTap: (value) {
                          _storeProductDetailsScreenNotifiers.selectedTab =
                              value;
                        },
                        tabs: [
                          Tab(
                            child: Text(
                              AppShared.appLang['Details'],
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              AppShared.appLang['Reviews'],
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Selector<StoreProductDetailsScreenNotifiers, int>(
                    selector: (_, value) => value.selectedTab,
                    builder: (_, selectedTab, __) => selectedTab == 0
                        ? StoreProductDetailsPage()
                        : StoreProductReviewsPage(),
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

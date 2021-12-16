import 'package:flutter/material.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/shared_screens_notifiers/reviews_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/views/components/customer_components/shared_components/review_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class ReviewsScreen extends StatelessWidget {
  int productId;
  @override
  Widget build(BuildContext context) {
    productId = ModalRoute.of(context).settings.arguments;
    return ParentComponent(
      child: ChangeNotifierProvider(
        create: (_) => ReviewsScreenNotifiers(context, productId),
        child: ReviewsScreenBody(),
      ),
    );
  }
}

class ReviewsScreenBody extends StatefulWidget {
  @override
  _ReviewsScreenBodyState createState() => _ReviewsScreenBodyState();
}

class _ReviewsScreenBodyState extends State<ReviewsScreenBody> {
  ReviewsScreenNotifiers _reviewsScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reviewsScreenNotifiers =
        Provider.of<ReviewsScreenNotifiers>(context, listen: false);
    _reviewsScreenNotifiers.getProductReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          AppShared.appLang['Reviews'],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: AppStyles.defaultPadding3,
        child: Selector<ReviewsScreenNotifiers, Tuple2<bool, bool>>(
          selector: (_, value) => Tuple2(value.isLoading, value.refreshList),
          builder: (_, tuple, __) => tuple.item1
              ? Center(
                  child: LoadingComponent(),
                )
              : _reviewsScreenNotifiers.reviewsResponse.reviews.data.isEmpty
                  ? Center(
                      child: Text(AppShared.appLang['NoReviews']),
                    )
                  : ListView.builder(
                      controller:
                          _reviewsScreenNotifiers.reviewsScrollController,
                      itemCount: _reviewsScreenNotifiers
                              .reviewsResponse.reviews.data.length +
                          1,
                      itemBuilder: (_, index) => index ==
                              _reviewsScreenNotifiers
                                  .reviewsResponse.reviews.data.length
                          ? Selector<ReviewsScreenNotifiers, bool>(
                              selector: (_, value) => value.isPagingLoading,
                              builder: (_, isPagingLoading, __) =>
                                  isPagingLoading
                                      ? Container(
                                          height: 100,
                                          child: LoadingComponent(),
                                        )
                                      : Container(
                                          height: 10,
                                        ),
                            )
                          : ReviewComponent(
                              by: _reviewsScreenNotifiers.reviewsResponse
                                  .reviews.data[index].user.name,
                              content: _reviewsScreenNotifiers
                                  .reviewsResponse.reviews.data[index].comment,
                              date: _reviewsScreenNotifiers.reviewsResponse
                                  .reviews.data[index].createdAt,
                              rating: _reviewsScreenNotifiers
                                  .reviewsResponse.reviews.data[index].rate
                                  .toDouble(),
                            ),
                    ),
        ),
      ),
    );
  }
}

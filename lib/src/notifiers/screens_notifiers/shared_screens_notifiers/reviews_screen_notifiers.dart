import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/reviews_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class ReviewsScreenNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = true;
  bool _isPagingLoading = false;
  bool _refreshList = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isPagingLoading => _isPagingLoading;

  set isPagingLoading(bool value) {
    _isPagingLoading = value;
    notifyListeners();
  }

  bool get refreshList => _refreshList;

  set refreshList(bool value) {
    _refreshList = value;
    notifyListeners();
  }

  // ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  ProductsController productsController;
  ReviewsResponse reviewsResponse;
  ScrollController reviewsScrollController;

  int page = 1;
  int productId;

  // ||... constructor ...||
  ReviewsScreenNotifiers(this.context, this.productId) {
    productsController = ProductsController.instance;
    reviewsScrollController = ScrollController();
    reviewsScrollController.addListener(() {
      if (reviewsScrollController.position.pixels ==
          reviewsScrollController.position.maxScrollExtent) {
        if (isLoading || isPagingLoading) return;
        getProductReviews();
      }
    });
  }

// ||...................... logic methods ............................||

  // get product reviews.
  void getProductReviews() async {
    if (page == 1) {
      try {
        reviewsResponse =
            await productsController.getProductReviews(productId: productId);
        isLoading = false;
        if (!reviewsResponse.status)
          Helpers.showMessage(
              reviewsResponse.message, MessageType.MESSAGE_FAILED);
        else
          page++;
      } catch (error) {
        isLoading = false;
        print(error.toString());
        Helpers.showMessage(AppShared.appLang['SomethingWentWrong'],
            MessageType.MESSAGE_FAILED);
      }
    } else {
      try {
        if (page > reviewsResponse.reviews.lastPage) return;
        isPagingLoading = true;
        ReviewsResponse response = await productsController.getProductReviews(
            productId: productId, page: page);
        isPagingLoading = false;
        if (response.status) {
          reviewsResponse.reviews.data.addAll(response.reviews.data);
          page++;
          refreshList = !refreshList;
        } else {
          Helpers.showMessage(response.message, MessageType.MESSAGE_FAILED);
        }
      } catch (error) {
        isPagingLoading = false;
        print(error.toString());
        Helpers.showMessage(AppShared.appLang['SomethingWentWrong'],
            MessageType.MESSAGE_FAILED);
      }
    }
  }
// ||...................... logic methods ............................||
}
